import 'package:grouu/constants/vaccine.dart';
import 'package:grouu/data/sqlite/models/milestone.dart';
import 'package:grouu/data/sqlite/service/milestone_service.dart';
import 'package:grouu/di/components/service_locator.dart';
import 'package:grouu/stores/error/error_store.dart';
import 'package:grouu/stores/user/user_store.dart';
import 'package:mobx/mobx.dart';

part 'milestone_store.g.dart';

class MilestoneStore = _MilestoneStore with _$MilestoneStore;

abstract class _MilestoneStore with Store {
  final ErrorStore errorStore = ErrorStore();
  UserStore userStore = getIt<UserStore>();

  late MilestoneService _milestoneService;

  // constructor:---------------------------------------------------------------
  _MilestoneStore() {
    // setting up disposers
    _milestoneService = MilestoneService();
    _setupDisposers();
  }

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void _setupDisposers() {
    _disposers = [
      reaction((_) => success, (_) => success = false, delay: 200),
    ];
  }

  @observable
  int selectedPeriodeIndex = 0;

  @observable
  int checked = 0;

  @observable
  int total = 0;

  @observable
  dynamic milestone;

  @observable
  dynamic milestoneChildren;

  @observable
  dynamic childMilestone;

  @observable
  int milestoneId = 0;

  @observable
  List<Periode> listPeriode = DataPeriode.listMilestonePeriode;

  @observable
  List<VaccineSchedule> listVaccineSchedule = [];

  @observable
  List<dynamic> listMilestone = [];

  @observable
  bool success = false;

  @observable
  bool loading = false;

  @action
  void setPeriode(int periodeId) {
    selectedPeriodeIndex = periodeId;
  }

  @action
  void setMilestoneChildren(MilestoneChildren value) {
    milestoneChildren = value;
  }

  @action
  Future<void> setMilestoneId(int value) async {
    milestoneId = value;
    await getMilestone();
  }

  @action
  Future getUnregisteredMilestone() async {
    loading = true;
    try {
      listMilestone = await _milestoneService.getUnregisteredMilestone(
        listPeriode[selectedPeriodeIndex].min,
        listPeriode[selectedPeriodeIndex].max,
      );

      loading = false;
    } catch (e) {
      print(e);
    }
  }

  @action
  Future getRegisteredMilestone(int childrenId) async {
    loading = true;
    try {
      List<Map<String, dynamic>> listTotal =
          await _milestoneService.getTotalMilestone(childrenId);

      total = listTotal[0]["total"];
      checked = listTotal[0]["checked"];

      listMilestone = await _milestoneService.getRegisteredMilestone(
          childrenId,
          listPeriode[selectedPeriodeIndex].min,
          listPeriode[selectedPeriodeIndex].max);

      loading = false;
    } catch (e) {
      print(e);
    }
  }

  @action
  Future addMilestone(int childrenId, int milestoneId) async {
    loading = true;
    try {
      await _milestoneService.addMiestone(
          childrenId: childrenId, milestoneId: milestoneId);
      loading = false;
      success = true;
    } catch (e) {
      errorStore.errorMessage = "Something went wrong";
      loading = false;
      success = false;
      print(e);
    }
  }

  Future getMilestone() async {
    try {
      milestone = await _milestoneService.getMilestone(milestoneId);
      print(milestone);
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
  }

  void clearInput() {
    milestone = null;
    milestoneId = 0;
  }
}
