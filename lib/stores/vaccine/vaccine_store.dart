import 'package:age_calculator/age_calculator.dart';
import 'package:grouu/constants/vaccine.dart';
import 'package:grouu/data/sqlite/db/database.dart';
import 'package:grouu/data/sqlite/service/vaccine_service.dart';
import 'package:grouu/di/components/service_locator.dart';
import 'package:grouu/stores/error/error_store.dart';
import 'package:grouu/stores/user/user_store.dart';
import 'package:mobx/mobx.dart';

part 'vaccine_store.g.dart';

class VaccineStore = _VaccineStore with _$VaccineStore;

abstract class _VaccineStore with Store {
  // store for handling form errors
  final VaccineErrorStore vaccineErrorStore = VaccineErrorStore();

  // store for handling error messages
  final ErrorStore errorStore = ErrorStore();

  UserStore userStore = getIt<UserStore>();

  late VaccineService _vaccineService;

  // constructor:---------------------------------------------------------------
  _VaccineStore() {
    // setting up disposers
    _vaccineService = VaccineService();
    _setupDisposers();
  }

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void _setupDisposers() {
    _disposers = [
      reaction((_) => success, (_) => success = false, delay: 200),
      reaction((_) => vaccineName, validateVaccineName),
      reaction((_) => vaccineBrand, validateBrands),
    ];
  }

  @observable
  int selectedPeriodeIndex = 0;

  @observable
  int selectedVaccinationId = 0;

  @observable
  dynamic vaccine;

  @observable
  dynamic vaccination;

  @observable
  String vaccineName = "";

  @observable
  int vaccineId = 0;

  @observable
  String vaccineBrand = "";

  @observable
  String locationName = "";

  @observable
  String doctorName = "";

  @observable
  String batchNumber = "";

  @observable
  String howToDeal = "";

  @observable
  String notes = "";

  @observable
  String searchQuery = "";

  @observable
  DateTime? vaccinationDate;

  @observable
  DateTime? vaccinationSchedule;

  @observable
  int statusIndex = 0;

  @observable
  List<Periode> listVaccinePeriode = DataPeriode.listPeriode;

  @observable
  List<VaccineSchedule> listVaccineSchedule = [];

  @observable
  bool success = false;

  @observable
  bool loading = false;

  @action
  void setPeriode(int periodeId) {
    selectedPeriodeIndex = periodeId;
  }

  @action
  void setVaccinationId(int vaccinationId) {
    selectedVaccinationId = vaccinationId;
  }

  @action
  Future<void> setVaccineId(int value) async {
    vaccineId = value;
    await getVaccine();
  }

  @action
  void setVaccineName(String value) {
    vaccineName = value;
  }

  @action
  void setVaccineBrand(String value) {
    vaccineBrand = value;
  }

  @action
  void setLocationName(String value) {
    locationName = value;
  }

  @action
  void setDoctorName(String value) {
    doctorName = value;
  }

  @action
  void setBatchNumber(String value) {
    batchNumber = value;
  }

  @action
  void setNotes(String value) {
    notes = value;
  }

  @action
  void setSearchQuery(String value) {
    searchQuery = value;
  }

  @action
  void setVaccinationDate(DateTime value) {
    vaccinationDate = value;
  }

  @action
  void setVaccinationSchedule(DateTime value) {
    vaccinationSchedule = value;
  }

  @action
  void setHowToDeal(String value) {
    howToDeal = value;
  }

  @action
  void validateBrands(String value) {
    if (value.isEmpty) {
      vaccineErrorStore.vaccineBrand = "Vaccine brand can't be empty";
    } else {
      vaccineErrorStore.vaccineBrand = null;
    }
  }

  @action
  void validateVaccineName(String value) {
    if (value.isEmpty) {
      vaccineErrorStore.vaccineName = "Vaccine name can't be empty";
    } else {
      vaccineErrorStore.vaccineName = null;
    }
  }

  @action
  void setStatus(int index) {
    statusIndex = index;
  }

  @action
  void setVaccination(Vaccination value) {
    vaccination = value;
    selectedVaccinationId = value.id;
    vaccineName = value.vaccineName;
    vaccineId = value.vaccine ?? 0;
    vaccineBrand = value.vaccineBrand ?? "";
    locationName = value.locationName ?? "";
    doctorName = value.doctorName ?? "";
    batchNumber = value.batchNumber ?? "";
    notes = value.notes ?? "";
    vaccinationDate = value.vaccinationDate;
    vaccinationSchedule = value.vaccinationSchedule;
  }

  @computed
  bool get canAddVaccine =>
      !vaccineErrorStore.hasError & vaccineName.isNotEmpty &&
      vaccineBrand.isNotEmpty &&
      vaccinationDate != null;

  @action
  Future getUnregisteredVaccine() async {
    loading = true;
    try {
      print(listVaccinePeriode[selectedPeriodeIndex]);
      var vaccines = await _vaccineService.getUnregisteredVaccine(
        listVaccinePeriode[selectedPeriodeIndex].min,
        listVaccinePeriode[selectedPeriodeIndex].max,
      );
      Set vaccineMonth = vaccines.map((e) => e.vaccinationMonth).toSet();
      List<VaccineSchedule> vaccineSchedule = [];

      vaccineMonth.forEach((month) {
        var schedule = vaccines.where((e) => e.vaccinationMonth == month);

        vaccineSchedule.add(VaccineSchedule(
            scheduleId: month,
            shceduleTitle: month < 36 ? "$month bulan" : "${month ~/ 12} tahun",
            listVaccine: schedule.toList()));
      });

      listVaccineSchedule = vaccineSchedule;

      loading = false;
    } catch (e) {
      print(e);
    }
  }

  @action
  Future searchUnregisteredVaccine() async {
    loading = true;
    try {
      var vaccines = await _vaccineService.searchUnregistered(searchQuery);
      Set vaccineMonth = vaccines.map((e) => e.vaccinationMonth).toSet();
      List<VaccineSchedule> vaccineSchedule = [];

      vaccineMonth.forEach((month) {
        var schedule = vaccines.where((e) => e.vaccinationMonth == month);

        vaccineSchedule.add(VaccineSchedule(
            scheduleId: month,
            shceduleTitle: month < 36 ? "$month bulan" : "${month ~/ 12} tahun",
            listVaccine: schedule.toList()));
      });

      listVaccineSchedule = vaccineSchedule;

      loading = false;
    } catch (e) {
      print(e);
    }
  }

  @action
  Future searchRegisteredVaccine(int childrenId) async {
    loading = true;
    try {
      var vaccines =
          await _vaccineService.searchRegistered(searchQuery, childrenId);
      Set vaccineMonth = vaccines.map((e) => e.vaccinationMonth).toSet();
      List<VaccineSchedule> vaccineSchedule = [];

      vaccineMonth.forEach((month) {
        var schedule = vaccines.where((e) => e.vaccinationMonth == month);

        vaccineSchedule.add(VaccineSchedule(
            scheduleId: month,
            shceduleTitle: month < 36 ? "$month bulan" : "${month ~/ 12} tahun",
            listVaccine: [],
            listVaccination: schedule.toList()));
      });

      listVaccineSchedule = vaccineSchedule;

      loading = false;
    } catch (e) {
      print(e);
    }
  }

  @action
  Future updateVaccine() async {
    loading = true;
    try {
      await _vaccineService.updateVaccination(
          id: selectedVaccinationId,
          vaccinationDate: vaccinationDate,
          vaccineName: vaccineName,
          batchNumber: batchNumber,
          doctorName: doctorName,
          locationName: locationName,
          notes: notes,
          vaccineBrand: vaccineBrand,
          vaccinationSchedule: vaccinationSchedule);
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
  Future removeVaccine() async {
    loading = true;
    try {
      await _vaccineService.updateVaccination(
          id: selectedVaccinationId,
          vaccinationDate: null,
          vaccineName: vaccineName,
          batchNumber: null,
          doctorName: null,
          locationName: null,
          notes: null,
          vaccineBrand: null);
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
  Future getRegisteredVaccine(int childrenId) async {
    loading = true;
    try {
      print(listVaccinePeriode[selectedPeriodeIndex]);
      var vaccines = await _vaccineService.getVaccinationByChildren(
          childrenId,
          listVaccinePeriode[selectedPeriodeIndex].min,
          listVaccinePeriode[selectedPeriodeIndex].max,
          statusIndex);
      List<dynamic> vaccineMonth = vaccines.map((e) => e.vaccinationMonth).toSet().toList();
      vaccineMonth.sort();
      List<VaccineSchedule> vaccineSchedule = [];

      vaccineMonth.forEach((month) {
        var schedule = vaccines.where((e) => e.vaccinationMonth == month);
        vaccineSchedule.add(VaccineSchedule(
            scheduleId: month,
            shceduleTitle: month < 36 ? "$month bulan" : "${month ~/ 12} tahun",
            listVaccine: [],
            listVaccination: schedule.toList()));
      });

      listVaccineSchedule = vaccineSchedule;

      loading = false;
    } catch (e) {
      print(e);
    }
  }

  @action
  Future addVaccination(int childrenId, DateTime birthday) async {
    loading = true;
    try {
      var duration = AgeCalculator.dateDifference(
          fromDate: birthday, toDate: vaccinationDate!);

      int vaccinationMonth = (duration.years * 12) + duration.months;
      print(vaccinationMonth);
      await _vaccineService.addVaccination(
        childrenId: childrenId,
        vaccineName: vaccineName,
        vaccinationMonth: vaccinationMonth,
        vaccineBrand: vaccineBrand,
        locationName: locationName,
        doctorName: doctorName,
        batchNumber: batchNumber,
        notes: notes,
        vaccinationDate: vaccinationDate ?? DateTime.now(),
      );
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
  Future deleteVaccination() async {
    loading = true;
    try {
      int result =
          await _vaccineService.deleteVaccination(selectedVaccinationId);
      if (result == 1) {
        loading = false;
        success = true;
      } else {
        throw Exception("failed");
      }
    } catch (e) {
      errorStore.errorMessage = "Something went wrong";
      loading = false;
      success = false;
      print(e);
    }
  }

  Future getVaccine() async {
    try {
      vaccine = await _vaccineService.getVaccine(vaccineId);
      print(vaccine);
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
    selectedVaccinationId = 0;
    vaccine = null;
    vaccineName = "";
    vaccineId = 0;
    vaccineBrand = "";
    locationName = "";
    doctorName = "";
    batchNumber = "";
    howToDeal = "";
    notes = "";
    vaccinationDate = null;
    searchQuery = "";
  }
}

class VaccineErrorStore = _VaccineErrorStore with _$VaccineErrorStore;

abstract class _VaccineErrorStore with Store {
  String? vaccineName;
  String? vaccineBrand;

  @computed
  bool get hasError => vaccineName != null && vaccineBrand != null;
}
