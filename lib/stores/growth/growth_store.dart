import 'package:easy_localization/easy_localization.dart';
import 'package:grouu/constants/local_json_assets.dart';
import 'package:grouu/data/local/constants/data_constants.dart';
import 'package:grouu/data/local/constants/growth_constants.dart';
import 'package:grouu/data/sqlite/db/database.dart';
import 'package:grouu/data/sqlite/models/growths.dart';
import 'package:grouu/data/sqlite/service/growth_service.dart';
import 'package:grouu/di/components/service_locator.dart';
import 'package:grouu/models/growth/local_growth.dart';
import 'package:grouu/stores/children/children_store.dart';
import 'package:grouu/stores/error/error_store.dart';
import 'package:grouu/stores/user/user_store.dart';
import 'package:grouu/utils/locale/wording_utils.dart';
import 'package:mobx/mobx.dart';
import 'package:collection/collection.dart';

import '../../models/growth/local_combined_growth.dart';

part 'growth_store.g.dart';

class GrowthStore = _GrowthStore with _$GrowthStore;

abstract class _GrowthStore with Store {
  // store for handling form errors
  final GrowthErrorStore growthErrorStore = GrowthErrorStore();

  // store for handling error messages
  final ErrorStore errorStore = ErrorStore();
  late GrowthService growthService;

  UserStore userStore = getIt<UserStore>();

  // constructor:---------------------------------------------------------------
  _GrowthStore() {
    // setting up disposers
    growthService = GrowthService();
    setupDisposers();
  }

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void setupDisposers() {
    _disposers = [
      reaction((_) => success, (_) {
        clearInput();
        success = false;
      }, delay: 200),
      reaction((_) => height, validateHeight),
      reaction((_) => weight, validateWeight),
      reaction((_) => headCircumference, validateHeadCircumreference),
      reaction((_) => measurementDate, validateMeasurementDate),
      reaction((_) => selectedHeadGrowthRisk, (_) => getHeadRisk()),
      reaction((_) => selectedHeightGrowthRisk, (_) => getHeightRisk()),
      reaction((_) => selectedWeightGrowthRisk, (_) => getWeightRisk()),
      reaction((_) => selectedBmiGrowthRisk, (_) => getBmiRisk()),
    ];
  }

  @observable
  double height = 0;

  @observable
  double weight = 0;

  @observable
  double headCircumference = 0;

  @observable
  DateTime? measurementDate;

  @observable
  dynamic selectedGrowth;

  @observable
  int selectedGrowthId = 0;

  @observable
  List<dynamic>? growths;

  @observable
  List<dynamic>? selectedGrowths;

  @observable
  Resiko? selectedWeightRisk;

  @observable
  Resiko? selectedHeightRisk;

  @observable
  Resiko? selectedHeadRisk;

  @observable
  Resiko? selectedBmiRisk;

  @observable
  List<LocalGrowth>? selectedHeightGrowthRisk;

  @observable
  List<LocalGrowth>? selectedWeightGrowthRisk;

  @observable
  List<LocalGrowth>? selectedHeadGrowthRisk;

  @observable
  List<LocalGrowth>? selectedBmiGrowthRisk;

  @observable
  List<LocalGrowth>? maleHeightGrowthRisk;

  @observable
  List<LocalGrowth>? maleWeightGrowthRisk;

  @observable
  List<LocalGrowth>? maleHeadGrowthRisk;

  @observable
  List<LocalGrowth>? maleBmiGrowthRisk;

  @observable
  List<LocalGrowth>? femaleHeightGrowthRisk;

  @observable
  List<LocalGrowth>? femaleWeightGrowthRisk;

  @observable
  List<LocalGrowth>? femaleHeadGrowthRisk;

  @observable
  List<LocalGrowth>? femaleBmiGrowthRisk;

  @observable
  List<LocalChildGrowth>? selectedChildHeight;

  @observable
  List<LocalChildGrowth>? selectedChildWeight;

  @observable
  List<LocalChildGrowth>? selectedChildHead;

  @observable
  List<LocalChildGrowth>? selectedChildBmi;

  @observable
  List<LocalCombinedGrowth>? combinedGrowth;

  @action
  void setHeight(double value) {
    height = value;
  }

  @action
  void setWeight(double value) {
    weight = value;
  }

  @action
  void setHeadCircumreference(double value) {
    headCircumference = value;
  }

  @action
  void setMeasurementDate(DateTime value) {
    measurementDate = value;
  }

  @observable
  bool success = false;

  @observable
  bool successDelete = false;

  @observable
  bool loading = false;

  @action
  void validateHeight(double value) {
    if (value <= 0) {
      growthErrorStore.height = "Height can't be empty";
    } else {
      growthErrorStore.height = null;
    }
  }

  @action
  void validateWeight(double value) {
    if (value <= 0) {
      growthErrorStore.weight = "Weight can't be empty";
    } else {
      growthErrorStore.weight = null;
    }
  }

  @action
  void validateHeadCircumreference(double value) {
    if (value <= 0) {
      growthErrorStore.headCircumference =
          "Head Circumreference can't be empty";
    } else {
      growthErrorStore.headCircumference = null;
    }
  }

  @action
  void validateMeasurementDate(DateTime? value) {
    if (value == null) {
      growthErrorStore.measurementDate = "Measurement date can't be empty";
    } else {
      growthErrorStore.measurementDate = null;
    }
  }

  @action
  void getWeightRisk() {
    selectedWeightRisk =
        calculateRisk((selectedGrowth as Growth).weight, StatsType.Weight);
  }

  @action
  void getHeightRisk() {
    selectedHeightRisk =
        calculateRisk((selectedGrowth as Growth).height, StatsType.Height);
  }

  @action
  void getHeadRisk() {
    selectedHeadRisk = calculateRisk(
        (selectedGrowth as Growth).headCircumference, StatsType.Head);
  }

  @action
  void getBmiRisk() {
    double bmi = getBmi();
    selectedBmiRisk = calculateRisk(bmi, StatsType.Bmi);
  }

  double getBmi() {
    final double weight = (selectedGrowth as Growth).weight;
    final double height = (selectedGrowth as Growth).height / 100;
    final double bmi = weight / (height * height);
    return bmi;
  }

  @action
  void selectGrowth(Growth growth) {
    selectedGrowth = growth;
    selectedGrowthId = growth.id;

    height = growth.height;
    weight = growth.weight;
    headCircumference = growth.headCircumference;
    measurementDate = growth.measurementDate;
  }

  @computed
  bool get canAddGrowth {
    return !growthErrorStore.hasErrorAddGrowth &&
        height > 0 &&
        weight > 0 &&
        headCircumference > 0 &&
        measurementDate != null;
  }

  @action
  Future addGrowth(int childrenId) async {
    loading = true;
    var sameDateGrowth = (selectedGrowths as List<Growth>?)
        ?.firstWhereOrNull((g) => g.measurementDate == measurementDate);

    try {
      if (sameDateGrowth != null) {
        await growthService.updateGrowth(
          height: height,
          weight: weight,
          headCircumference: headCircumference,
          measurementDate: measurementDate!,
          id: sameDateGrowth.id,
        );
        selectGrowthByChildId(childrenId);
        loading = false;
        success = true;
      } else {
        await growthService.addGrowth(
          userId: userStore.currentUserId,
          childrenId: childrenId,
          height: height,
          weight: weight,
          headCircumference: headCircumference,
          measurementDate: measurementDate!,
        );
        selectGrowthByChildId(childrenId);
        loading = false;
        success = true;
      }
    } catch (e) {
      errorStore.errorMessage = "Something went wrong";
      loading = false;
      success = false;
      print(e);
    }
  }

  @action
  Future selectGrowthByChildId(int? childrenId) async {
    loading = true;
    try {
      await getGrowthsByUser();

      final selectedGrowthByChild = (growths as List<Growth>?)?.firstWhere(
          (element) => (element.children == childrenId &&
              element.user == userStore.currentUserId));

      selectedGrowths = (growths as List<Growth>?)
          ?.where((element) => (element.children == childrenId &&
              element.user == userStore.currentUserId))
          .toList();
      selectedGrowth = selectedGrowthByChild;
      selectedGrowthId = selectedGrowthByChild?.id ?? 0;
      getHeadRisk();
      getWeightRisk();
      getHeightRisk();
      getBmiRisk();
      getSelectedChildGrowthGraph();
      loading = false;
    } catch (e) {
      selectedGrowth = null;
      selectedGrowthId = 0;
      selectedGrowths = null;
      selectedChildHeight = null;
      selectedChildWeight = null;
      selectedChildHead = null;
      selectedChildBmi = null;
      selectedBmiRisk = null;
      selectedHeightRisk = null;
      selectedWeightRisk = null;
      selectedHeadRisk = null;

      if (e.toString().contains("No element")) {
        errorStore.errorMessage = "";
      } else {
        errorStore.errorMessage = e.toString();
      }
      loading = false;

      print(e);
    }
  }

  @action
  Future updateGrowth(int childrenId) async {
    loading = true;
    try {
      await growthService.updateGrowth(
        id: selectedGrowthId,
        height: height,
        weight: weight,
        headCircumference: headCircumference,
        measurementDate: measurementDate!,
      );
      selectGrowthByChildId(childrenId);

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
  Future deleteGrowth(int growthId) async {
    loading = true;
    try {
      int result = await growthService.deleteGrowth(
        id: growthId,
      );
      if (result == 1) {
        loading = false;
        successDelete = true;
      } else {
        throw Exception("failed");
      }
      loading = false;
    } catch (e) {
      errorStore.errorMessage = "Something went wrong";
      loading = false;
      successDelete = false;
      print(e);
    }
  }

  @action
  Future getGrowthsByUser() async {
    try {
      growths = await growthService.getGrowthsByUser(userStore.currentUserId);
      print(growths);
    } catch (e) {
      print(e);
    }
  }

  @action
  Future getAllGrowthRiskDatas(String? gender) async {
    try {
      loading = true;
      getHeightDatas(gender);
      getWeightDatas(gender);
      getHeadDatas(gender);
      getBmiDatas(gender);
      loading = false;
    } catch (e) {
      print(e);
      loading = false;
    }
  }

  @action
  Future getHeightDatas(String? gender) async {
    try {
      loading = true;
      if (maleHeightGrowthRisk == null || femaleHeightGrowthRisk == null) {
        maleHeightGrowthRisk =
            await growthService.getGrowthJson(LocalJsonAssets.heightMale);
        femaleHeightGrowthRisk =
            await growthService.getGrowthJson(LocalJsonAssets.heightFemale);
      }

      if (gender != null) {
        if (gender == DataConstants.MALE) {
          selectedHeightGrowthRisk = maleHeightGrowthRisk;
        } else {
          selectedHeightGrowthRisk = femaleHeightGrowthRisk;
        }
      }
      loading = false;
    } catch (e) {
      print(e);
      loading = false;
    }
  }

  @action
  Future getWeightDatas(String? gender) async {
    try {
      loading = true;
      if (maleWeightGrowthRisk == null || femaleWeightGrowthRisk == null) {
        maleWeightGrowthRisk =
            await growthService.getGrowthJson(LocalJsonAssets.weightMale);
        femaleWeightGrowthRisk =
            await growthService.getGrowthJson(LocalJsonAssets.weightFemale);
      }
      if (gender != null) {
        if (gender == DataConstants.MALE) {
          selectedWeightGrowthRisk = maleWeightGrowthRisk;
        } else {
          selectedWeightGrowthRisk = femaleWeightGrowthRisk;
        }
      }

      loading = false;
    } catch (e) {
      print(e);
      loading = false;
    }
  }

  @action
  Future getHeadDatas(String? gender) async {
    try {
      loading = true;
      if (maleHeadGrowthRisk == null || femaleHeadGrowthRisk == null) {
        maleHeadGrowthRisk =
            await growthService.getGrowthJson(LocalJsonAssets.headMale);
        femaleHeadGrowthRisk =
            await growthService.getGrowthJson(LocalJsonAssets.headFemale);
      }

      if (gender != null) {
        if (gender == DataConstants.MALE) {
          selectedHeadGrowthRisk = maleHeadGrowthRisk;
        } else {
          selectedHeadGrowthRisk = femaleHeadGrowthRisk;
        }
      }

      loading = false;
    } catch (e) {
      print(e);
      loading = false;
    }
  }

  @action
  Future getBmiDatas(String? gender) async {
    try {
      loading = true;
      if (maleBmiGrowthRisk == null || femaleBmiGrowthRisk == null) {
        maleBmiGrowthRisk =
            await growthService.getGrowthJson(LocalJsonAssets.bmiMale);
        femaleBmiGrowthRisk =
            await growthService.getGrowthJson(LocalJsonAssets.bmiFemale);
      }

      if (gender != null) {
        if (gender == DataConstants.MALE) {
          selectedBmiGrowthRisk = maleBmiGrowthRisk;
        } else {
          selectedBmiGrowthRisk = femaleBmiGrowthRisk;
        }
      }

      loading = false;
    } catch (e) {
      print(e);
      loading = false;
    }
  }

  @action
  Future getDetailedNormalTable(StatsType statsType) async {
    final int _threeMonths = 90; //90 days
    final int _oneMonth = 30;
    combinedGrowth = [];
    try {
      loading = true;
      combinedGrowth?.clear();
      List<LocalGrowth> selectedMaleStats = [];
      List<LocalGrowth> selectedFemaleStats = [];

      switch (statsType) {
        case StatsType.Weight:
          selectedMaleStats = maleWeightGrowthRisk ?? [];
          selectedFemaleStats = femaleWeightGrowthRisk ?? [];
          break;
        case StatsType.Height:
          selectedMaleStats = maleHeightGrowthRisk ?? [];
          selectedFemaleStats = femaleHeightGrowthRisk ?? [];
          break;
        case StatsType.Head:
          selectedMaleStats = maleHeadGrowthRisk ?? [];
          selectedFemaleStats = femaleHeadGrowthRisk ?? [];
          break;
        case StatsType.Bmi:
          selectedMaleStats = maleBmiGrowthRisk ?? [];
          selectedFemaleStats = femaleBmiGrowthRisk ?? [];
          break;
        default:
      }

      for (int days = 0;
          days < (maleWeightGrowthRisk?.length ?? 0);
          days = days + _threeMonths) {
        combinedGrowth?.add(LocalCombinedGrowth(
            "${days ~/ _oneMonth} - ${(days + _threeMonths - 1) ~/ _oneMonth} bulan",
            "${selectedMaleStats[days].normal.toStringAsFixed(1)} - ${selectedMaleStats[days + _threeMonths - 1].normal.toStringAsFixed(1)} ${statsType.typeSuffix}",
            "${selectedFemaleStats[days].normal.toStringAsFixed(1)} - ${selectedFemaleStats[days + _threeMonths - 1].normal.toStringAsFixed(1)} ${statsType.typeSuffix}"));
      }
      loading = false;
    } catch (e) {
      print(e);
      loading = false;
    }
  }

  @action
  Future getSelectedChildGrowthGraph() async {
    try {
      List<LocalChildGrowth> _selectedChildHeight = [];
      List<LocalChildGrowth> _selectedChildWeight = [];
      List<LocalChildGrowth> _selectedChildHead = [];
      List<LocalChildGrowth> _selectedChildBmi = [];

      if (selectedGrowths != null) {
        for (final growth in selectedGrowths as List<Growth>) {
          final height = growth.height;
          final weight = growth.weight;
          final head = growth.headCircumference;
          final bmi = weight / ((height / 100) * (height / 100));
          final age = calculateAge(measurementDate: growth.measurementDate);

          _selectedChildHeight.add(LocalChildGrowth(age, height));
          _selectedChildWeight.add(LocalChildGrowth(age, weight));
          _selectedChildHead.add(LocalChildGrowth(age, head));
          _selectedChildBmi.add(LocalChildGrowth(age, bmi));
        }
      }
      selectedChildHeight = _selectedChildHeight;
      selectedChildWeight = _selectedChildWeight;
      selectedChildHead = _selectedChildHead;
      selectedChildBmi = _selectedChildBmi;
      loading = false;
    } catch (e) {
      print(e);

      loading = false;
    }
  }

  @action
  String getGrowthDesc(StatsType statsType) {
    final UserStore _userStore = getIt<UserStore>();
    switch (statsType) {
      case StatsType.Weight:
        switch (selectedWeightRisk) {
          case Resiko.HighBelow:
            return tr("growth_bb_highrisk_below");
          case Resiko.MediumBelow:
            return tr("growth_bb_lowrisk_below");
          case Resiko.Normal:
            return tr("growth_bb_normal",
                args: [WordingUtils.genderGreeting(_userStore.gender)]);
          case Resiko.MediumAbove:
            return tr("growth_bb_lowrisk_above");
          case Resiko.HighAbove:
            return tr("growth_bb_highrisk_above");
          default:
            return "";
        }
      case StatsType.Height:
        switch (selectedHeightRisk) {
          case Resiko.HighBelow:
            return tr("growth_tb_highrisk_below");
          case Resiko.MediumBelow:
            return tr("growth_tb_lowrisk_below");
          case Resiko.Normal:
            return tr("growth_tb_normal",
                args: [WordingUtils.genderGreeting(_userStore.gender)]);
          case Resiko.MediumAbove:
            return tr("growth_tb_lowrisk_above");
          case Resiko.HighAbove:
            return tr("growth_tb_highrisk_above");
          default:
            return "";
        }
      case StatsType.Head:
        switch (selectedHeadRisk) {
          case Resiko.HighBelow:
            return tr("growth_lk_highrisk_below");
          case Resiko.MediumBelow:
            return tr("growth_lk_lowrisk_below");
          case Resiko.Normal:
            return tr("growth_lk_normal",
                args: [WordingUtils.genderGreeting(_userStore.gender)]);
          case Resiko.MediumAbove:
            return tr("growth_lk_lowrisk_above");
          case Resiko.HighAbove:
            return tr("growth_lk_highrisk_above");
          default:
            return "";
        }
      case StatsType.Bmi:
        switch (selectedBmiRisk) {
          case Resiko.HighBelow:
            return tr("growth_bmi_highrisk_below");
          case Resiko.MediumBelow:
            return tr("growth_bmi_lowrisk_below");
          case Resiko.Normal:
            return tr("growth_bmi_normal",
                args: [WordingUtils.genderGreeting(_userStore.gender)]);
          case Resiko.MediumAbove:
            return tr("growth_bmi_lowrisk_above");
          case Resiko.HighAbove:
            return tr("growth_bmi_highrisk_above");
          default:
            return "";
        }
      default:
        return "";
    }
  }

  // general methods:-----------------------------------------------------------

  String? getNormalRiskValue(StatsType statsType) {
    loading = true;
    try {
      int _age = calculateAge();
      LocalGrowth? _selectedRisk = selectedWeightGrowthRisk?[_age];
      switch (statsType) {
        case StatsType.Weight:
          _selectedRisk = selectedWeightGrowthRisk?[_age];
          break;
        case StatsType.Height:
          _selectedRisk = selectedHeightGrowthRisk?[_age];
          break;
        case StatsType.Head:
          _selectedRisk = selectedHeadGrowthRisk?[_age];
          break;
        case StatsType.Bmi:
          _selectedRisk = selectedBmiGrowthRisk?[_age];
          break;
        default:
      }
      loading = false;

      return "${_selectedRisk?.minThresholdLowRisk.toStringAsFixed(1)} - ${_selectedRisk?.maxThresholdLowRisk.toStringAsFixed(1)}";
    } catch (e) {
      print(e);
      loading = false;
      return "";
    }
  }

  Resiko calculateRisk(double value, StatsType statsType) {
    loading = true;
    try {
      int _age = calculateAge();
      LocalGrowth? _selectedRisk = selectedWeightGrowthRisk?[_age];
      switch (statsType) {
        case StatsType.Weight:
          _selectedRisk = selectedWeightGrowthRisk?[_age];
          break;
        case StatsType.Height:
          _selectedRisk = selectedHeightGrowthRisk?[_age];
          break;
        case StatsType.Head:
          _selectedRisk = selectedHeadGrowthRisk?[_age];
          break;
        default:
      }

      if (value < _selectedRisk!.maxThresholdLowRisk &&
          value > _selectedRisk.minThresholdLowRisk) {
        loading = false;
        return Resiko.Normal;
      } else if (value < _selectedRisk.minThresholdLowRisk &&
          value > _selectedRisk.minThresholdHighRisk) {
        loading = false;
        return Resiko.MediumBelow;
      } else if (value > _selectedRisk.maxThresholdLowRisk &&
          value < _selectedRisk.maxThresholdHighRisk) {
        loading = false;
        return Resiko.MediumAbove;
      } else if (value < _selectedRisk.minThresholdHighRisk) {
        loading = false;
        return Resiko.HighBelow;
      } else {
        loading = false;
        return Resiko.HighAbove;
      }
    } catch (e) {
      print(e);
      loading = false;

      return Resiko.Unknown;
    }
  }

  int calculateAge({DateTime? measurementDate}) {
    var _childrenStore = getIt<ChildrenStore>();
    var _birthday = (_childrenStore.selectedChildren as Children).birthday;

    var _measurementDate = measurementDate == null
        ? (selectedGrowth as Growth).measurementDate
        : measurementDate;
    Duration _difference = _measurementDate.difference(_birthday);
    int _age = _difference.inDays;
    return _age;
  }

  void dispose() {
    for (final d in _disposers) {
      d();
    }
    initState();
    clearInput();
  }

  void initState() {
    success = false;
    successDelete = false;
    loading = false;
  }

  void clearInput() {
    height = 0;
    weight = 0;
    headCircumference = 0;
    measurementDate = null;
  }

  void clearSavedData() {
    selectedGrowth = null;
    selectedGrowthId = 0;
    growths = [];
    selectedHeadRisk = null;
    selectedHeightRisk = null;
    selectedWeightRisk = null;
    selectedBmiRisk = null;
    selectedChildBmi = null;
    selectedChildHead = null;
    selectedChildHeight = null;
    selectedChildWeight = null;
  }

  void resetErrorReaction() {
    growthErrorStore.height = null;
    growthErrorStore.weight = null;
    growthErrorStore.headCircumference = null;
    growthErrorStore.measurementDate = null;
  }

  void logout() {
    dispose();
    clearSavedData();
  }
}

class GrowthErrorStore = _GrowthErrorStore with _$GrowthErrorStore;

abstract class _GrowthErrorStore with Store {
  @observable
  String? height;

  @observable
  String? weight;

  @observable
  String? headCircumference;

  @observable
  String? measurementDate;

  @computed
  bool get hasErrorAddGrowth =>
      height != null ||
      weight != null ||
      headCircumference != null ||
      measurementDate != null;
}
