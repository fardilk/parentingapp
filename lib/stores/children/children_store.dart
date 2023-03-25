import 'dart:typed_data';

import 'package:age_calculator/age_calculator.dart';
import 'package:grouu/data/local/constants/growth_constants.dart';
import 'package:grouu/data/sqlite/db/database.dart';
import 'package:grouu/data/sqlite/service/children_service.dart';
import 'package:grouu/data/sqlite/service/vaccine_service.dart';
import 'package:grouu/di/components/service_locator.dart';
import 'package:grouu/stores/error/error_store.dart';
import 'package:grouu/stores/growth/growth_store.dart';
import 'package:grouu/stores/milestone/milestone_store.dart';
import 'package:grouu/stores/user/user_store.dart';
import 'package:mobx/mobx.dart';

part 'children_store.g.dart';

class ChildrenStore = _ChildrenStore with _$ChildrenStore;

abstract class _ChildrenStore with Store {
  // store for handling form errors
  final ChildrenErrorStore userErrorStore = ChildrenErrorStore();

  // store for handling error messages
  final ErrorStore errorStore = ErrorStore();
  late ChildrenService childrenService;
  late VaccineService vaccineService;

  UserStore userStore = getIt<UserStore>();
  GrowthStore growthStore = getIt<GrowthStore>();
  MilestoneStore milestoneStore = getIt<MilestoneStore>();

  // constructor:---------------------------------------------------------------
  _ChildrenStore() {
    // setting up disposers
    childrenService = ChildrenService();
    vaccineService = VaccineService();
    _setupDisposers();
  }

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void _setupDisposers() {
    _disposers = [
      reaction((_) => success, (_) => success = false, delay: 200),
      reaction((_) => gender, validateGender),
      reaction((_) => firstName, validateFirstName),
      reaction((_) => lastName, validateLastName),
      reaction((_) => birthday, validateBirthday)
    ];
  }

  @observable
  String firstName = '';

  @observable
  dynamic selectedChildren;

  @observable
  int selectedChildrenId = 0;

  @observable
  List<dynamic>? childrens;

  @action
  void setFirstName(String value) {
    firstName = value;
  }

  @observable
  String lastName = '';

  @action
  void setLastName(String value) {
    lastName = value;
  }

  @observable
  String gender = '';

  @action
  void setGender(String value) {
    gender = value;
  }

  @observable
  DateTime? birthday;

  @action
  void setBirthday(DateTime value) {
    birthday = value;
  }

  @computed
  String get getAge {
    DateDuration duration;
    duration = AgeCalculator.age(birthday ?? DateTime.now());
    final yearAge = duration.years > 0 ? "${duration.years} Tahun" : "";
    final age = "$yearAge${duration.months} Bulan ${duration.days} Hari";
    return age;
  }

  @observable
  bool success = false;

  @observable
  bool loading = false;

  @observable
  Uint8List? profileImage;

  @action
  void setProfileImage(Uint8List value) {
    profileImage = value;
  }

  @action
  void validateFirstName(String value) {
    if (value.isEmpty) {
      userErrorStore.firstName = "First Name can't be empty";
    } else {
      userErrorStore.firstName = null;
    }
  }

  @action
  void validateLastName(String value) {
    if (value.isEmpty) {
      userErrorStore.lastName = "Last Name can't be empty";
    } else {
      userErrorStore.lastName = null;
    }
  }

  @action
  void validateGender(String value) {
    if (value.isEmpty) {
      userErrorStore.gender = "Gender can't be empty";
    } else {
      userErrorStore.gender = null;
    }
  }

  @action
  void validateBirthday(DateTime? value) {
    if (value == null) {
      userErrorStore.birthday = "Birthaday can't be empty";
    } else {
      userErrorStore.birthday = null;
    }
  }

  @action
  Future<void> selectChildren(Children children) async {
    selectedChildren = children;
    selectedChildrenId = children.id;

    firstName = children.firstName;
    lastName = children.lastName;
    birthday = children.birthday;
    gender = children.gender;
    profileImage = children.image;
    await growthStore.selectGrowthByChildId(children.id);
    await growthStore
        .getAllGrowthRiskDatas((selectedChildren as Children).gender);
    await milestoneStore.getRegisteredMilestone(children.id);
  }

  @computed
  bool get canAddChildren =>
      !userErrorStore.hasErrorAddChild &&
      gender.isNotEmpty &&
      firstName.isNotEmpty &&
      lastName.isNotEmpty &&
      birthday != null;

  @action
  Future addChildren() async {
    loading = true;
    try {
      var data = await childrenService.addChildren(
          userId: userStore.currentUserId,
          birthday: birthday ?? DateTime.now(),
          firstName: firstName,
          lastName: lastName,
          gender: gender,
          image: profileImage);

      selectedChildren = data;
      selectedChildrenId = data.id;
      await vaccineService.initChildrenVaccine(data.id);
      await getChildrensByUser();
      loading = false;
      success = true;
    } catch (e) {
      errorStore.errorMessage = "Something went wrong";
      loading = false;
      success = false;
      print(e);
    }
  }

  @action
  Future updateChildren() async {
    loading = true;
    try {
      await childrenService.updateChildren(
          id: selectedChildrenId,
          birthday: birthday ?? DateTime.now(),
          firstName: firstName,
          lastName: lastName,
          gender: gender,
          image: profileImage);
      await getChildrensByUser();
      loading = false;
      success = true;
    } catch (e) {
      errorStore.errorMessage = "Something went wrong";
      loading = false;
      success = false;
      print(e);
    }
  }

  @action
  Future getChildrensByUser() async {
    try {
      childrens =
          await childrenService.getChildrensByUser(userStore.currentUserId);
      print(childrens);
    } catch (e) {
      print(e);
    }
  }

  @action
  Future getInitialChildrenData() async {
    try {
      await userStore.checkLogin();
      childrens =
          await childrenService.getChildrensByUser(userStore.currentUserId);
      if (firstName.isEmpty) {
        var children = childrens?.first;
        await selectChildren(children);
      } else {
        await growthStore
            .getAllGrowthRiskDatas((selectedChildren as Children).gender);
        await growthStore.selectGrowthByChildId(selectedChildrenId);
        await milestoneStore.getRegisteredMilestone(selectedChildrenId);
      }
      print(childrens);
    } catch (e) {
      print(e);
    }
  }

  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }

    success = false;
    loading = false;
    clearInput();
  }

  void clearInput() {
    firstName = "";
    lastName = "";
    gender = "";
    birthday = null;
  }

  void clearSavedData() {
    selectedChildren = null;
    selectedChildrenId = 0;
    childrens = [];
  }

  void logout() {
    dispose();
    clearSavedData();
  }
}

class ChildrenErrorStore = _ChildrenErrorStore with _$ChildrenErrorStore;

abstract class _ChildrenErrorStore with Store {
  @observable
  String? firstName;

  @observable
  String? lastName;

  @observable
  String? gender;

  @observable
  String? birthday;

  @computed
  bool get hasErrorAddChild =>
      firstName != null ||
      lastName != null ||
      gender != null ||
      birthday != null;
}
