// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'growth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$GrowthStore on _GrowthStore, Store {
  Computed<bool>? _$canAddGrowthComputed;

  @override
  bool get canAddGrowth =>
      (_$canAddGrowthComputed ??= Computed<bool>(() => super.canAddGrowth,
              name: '_GrowthStore.canAddGrowth'))
          .value;

  late final _$heightAtom = Atom(name: '_GrowthStore.height', context: context);

  @override
  double get height {
    _$heightAtom.reportRead();
    return super.height;
  }

  @override
  set height(double value) {
    _$heightAtom.reportWrite(value, super.height, () {
      super.height = value;
    });
  }

  late final _$weightAtom = Atom(name: '_GrowthStore.weight', context: context);

  @override
  double get weight {
    _$weightAtom.reportRead();
    return super.weight;
  }

  @override
  set weight(double value) {
    _$weightAtom.reportWrite(value, super.weight, () {
      super.weight = value;
    });
  }

  late final _$headCircumferenceAtom =
      Atom(name: '_GrowthStore.headCircumference', context: context);

  @override
  double get headCircumference {
    _$headCircumferenceAtom.reportRead();
    return super.headCircumference;
  }

  @override
  set headCircumference(double value) {
    _$headCircumferenceAtom.reportWrite(value, super.headCircumference, () {
      super.headCircumference = value;
    });
  }

  late final _$measurementDateAtom =
      Atom(name: '_GrowthStore.measurementDate', context: context);

  @override
  DateTime? get measurementDate {
    _$measurementDateAtom.reportRead();
    return super.measurementDate;
  }

  @override
  set measurementDate(DateTime? value) {
    _$measurementDateAtom.reportWrite(value, super.measurementDate, () {
      super.measurementDate = value;
    });
  }

  late final _$selectedGrowthAtom =
      Atom(name: '_GrowthStore.selectedGrowth', context: context);

  @override
  dynamic get selectedGrowth {
    _$selectedGrowthAtom.reportRead();
    return super.selectedGrowth;
  }

  @override
  set selectedGrowth(dynamic value) {
    _$selectedGrowthAtom.reportWrite(value, super.selectedGrowth, () {
      super.selectedGrowth = value;
    });
  }

  late final _$selectedGrowthIdAtom =
      Atom(name: '_GrowthStore.selectedGrowthId', context: context);

  @override
  int get selectedGrowthId {
    _$selectedGrowthIdAtom.reportRead();
    return super.selectedGrowthId;
  }

  @override
  set selectedGrowthId(int value) {
    _$selectedGrowthIdAtom.reportWrite(value, super.selectedGrowthId, () {
      super.selectedGrowthId = value;
    });
  }

  late final _$growthsAtom =
      Atom(name: '_GrowthStore.growths', context: context);

  @override
  List<dynamic>? get growths {
    _$growthsAtom.reportRead();
    return super.growths;
  }

  @override
  set growths(List<dynamic>? value) {
    _$growthsAtom.reportWrite(value, super.growths, () {
      super.growths = value;
    });
  }

  late final _$selectedGrowthsAtom =
      Atom(name: '_GrowthStore.selectedGrowths', context: context);

  @override
  List<dynamic>? get selectedGrowths {
    _$selectedGrowthsAtom.reportRead();
    return super.selectedGrowths;
  }

  @override
  set selectedGrowths(List<dynamic>? value) {
    _$selectedGrowthsAtom.reportWrite(value, super.selectedGrowths, () {
      super.selectedGrowths = value;
    });
  }

  late final _$selectedWeightRiskAtom =
      Atom(name: '_GrowthStore.selectedWeightRisk', context: context);

  @override
  Resiko? get selectedWeightRisk {
    _$selectedWeightRiskAtom.reportRead();
    return super.selectedWeightRisk;
  }

  @override
  set selectedWeightRisk(Resiko? value) {
    _$selectedWeightRiskAtom.reportWrite(value, super.selectedWeightRisk, () {
      super.selectedWeightRisk = value;
    });
  }

  late final _$selectedHeightRiskAtom =
      Atom(name: '_GrowthStore.selectedHeightRisk', context: context);

  @override
  Resiko? get selectedHeightRisk {
    _$selectedHeightRiskAtom.reportRead();
    return super.selectedHeightRisk;
  }

  @override
  set selectedHeightRisk(Resiko? value) {
    _$selectedHeightRiskAtom.reportWrite(value, super.selectedHeightRisk, () {
      super.selectedHeightRisk = value;
    });
  }

  late final _$selectedHeadRiskAtom =
      Atom(name: '_GrowthStore.selectedHeadRisk', context: context);

  @override
  Resiko? get selectedHeadRisk {
    _$selectedHeadRiskAtom.reportRead();
    return super.selectedHeadRisk;
  }

  @override
  set selectedHeadRisk(Resiko? value) {
    _$selectedHeadRiskAtom.reportWrite(value, super.selectedHeadRisk, () {
      super.selectedHeadRisk = value;
    });
  }

  late final _$selectedBmiRiskAtom =
      Atom(name: '_GrowthStore.selectedBmiRisk', context: context);

  @override
  Resiko? get selectedBmiRisk {
    _$selectedBmiRiskAtom.reportRead();
    return super.selectedBmiRisk;
  }

  @override
  set selectedBmiRisk(Resiko? value) {
    _$selectedBmiRiskAtom.reportWrite(value, super.selectedBmiRisk, () {
      super.selectedBmiRisk = value;
    });
  }

  late final _$selectedHeightGrowthRiskAtom =
      Atom(name: '_GrowthStore.selectedHeightGrowthRisk', context: context);

  @override
  List<LocalGrowth>? get selectedHeightGrowthRisk {
    _$selectedHeightGrowthRiskAtom.reportRead();
    return super.selectedHeightGrowthRisk;
  }

  @override
  set selectedHeightGrowthRisk(List<LocalGrowth>? value) {
    _$selectedHeightGrowthRiskAtom
        .reportWrite(value, super.selectedHeightGrowthRisk, () {
      super.selectedHeightGrowthRisk = value;
    });
  }

  late final _$selectedWeightGrowthRiskAtom =
      Atom(name: '_GrowthStore.selectedWeightGrowthRisk', context: context);

  @override
  List<LocalGrowth>? get selectedWeightGrowthRisk {
    _$selectedWeightGrowthRiskAtom.reportRead();
    return super.selectedWeightGrowthRisk;
  }

  @override
  set selectedWeightGrowthRisk(List<LocalGrowth>? value) {
    _$selectedWeightGrowthRiskAtom
        .reportWrite(value, super.selectedWeightGrowthRisk, () {
      super.selectedWeightGrowthRisk = value;
    });
  }

  late final _$selectedHeadGrowthRiskAtom =
      Atom(name: '_GrowthStore.selectedHeadGrowthRisk', context: context);

  @override
  List<LocalGrowth>? get selectedHeadGrowthRisk {
    _$selectedHeadGrowthRiskAtom.reportRead();
    return super.selectedHeadGrowthRisk;
  }

  @override
  set selectedHeadGrowthRisk(List<LocalGrowth>? value) {
    _$selectedHeadGrowthRiskAtom
        .reportWrite(value, super.selectedHeadGrowthRisk, () {
      super.selectedHeadGrowthRisk = value;
    });
  }

  late final _$selectedBmiGrowthRiskAtom =
      Atom(name: '_GrowthStore.selectedBmiGrowthRisk', context: context);

  @override
  List<LocalGrowth>? get selectedBmiGrowthRisk {
    _$selectedBmiGrowthRiskAtom.reportRead();
    return super.selectedBmiGrowthRisk;
  }

  @override
  set selectedBmiGrowthRisk(List<LocalGrowth>? value) {
    _$selectedBmiGrowthRiskAtom.reportWrite(value, super.selectedBmiGrowthRisk,
        () {
      super.selectedBmiGrowthRisk = value;
    });
  }

  late final _$maleHeightGrowthRiskAtom =
      Atom(name: '_GrowthStore.maleHeightGrowthRisk', context: context);

  @override
  List<LocalGrowth>? get maleHeightGrowthRisk {
    _$maleHeightGrowthRiskAtom.reportRead();
    return super.maleHeightGrowthRisk;
  }

  @override
  set maleHeightGrowthRisk(List<LocalGrowth>? value) {
    _$maleHeightGrowthRiskAtom.reportWrite(value, super.maleHeightGrowthRisk,
        () {
      super.maleHeightGrowthRisk = value;
    });
  }

  late final _$maleWeightGrowthRiskAtom =
      Atom(name: '_GrowthStore.maleWeightGrowthRisk', context: context);

  @override
  List<LocalGrowth>? get maleWeightGrowthRisk {
    _$maleWeightGrowthRiskAtom.reportRead();
    return super.maleWeightGrowthRisk;
  }

  @override
  set maleWeightGrowthRisk(List<LocalGrowth>? value) {
    _$maleWeightGrowthRiskAtom.reportWrite(value, super.maleWeightGrowthRisk,
        () {
      super.maleWeightGrowthRisk = value;
    });
  }

  late final _$maleHeadGrowthRiskAtom =
      Atom(name: '_GrowthStore.maleHeadGrowthRisk', context: context);

  @override
  List<LocalGrowth>? get maleHeadGrowthRisk {
    _$maleHeadGrowthRiskAtom.reportRead();
    return super.maleHeadGrowthRisk;
  }

  @override
  set maleHeadGrowthRisk(List<LocalGrowth>? value) {
    _$maleHeadGrowthRiskAtom.reportWrite(value, super.maleHeadGrowthRisk, () {
      super.maleHeadGrowthRisk = value;
    });
  }

  late final _$maleBmiGrowthRiskAtom =
      Atom(name: '_GrowthStore.maleBmiGrowthRisk', context: context);

  @override
  List<LocalGrowth>? get maleBmiGrowthRisk {
    _$maleBmiGrowthRiskAtom.reportRead();
    return super.maleBmiGrowthRisk;
  }

  @override
  set maleBmiGrowthRisk(List<LocalGrowth>? value) {
    _$maleBmiGrowthRiskAtom.reportWrite(value, super.maleBmiGrowthRisk, () {
      super.maleBmiGrowthRisk = value;
    });
  }

  late final _$femaleHeightGrowthRiskAtom =
      Atom(name: '_GrowthStore.femaleHeightGrowthRisk', context: context);

  @override
  List<LocalGrowth>? get femaleHeightGrowthRisk {
    _$femaleHeightGrowthRiskAtom.reportRead();
    return super.femaleHeightGrowthRisk;
  }

  @override
  set femaleHeightGrowthRisk(List<LocalGrowth>? value) {
    _$femaleHeightGrowthRiskAtom
        .reportWrite(value, super.femaleHeightGrowthRisk, () {
      super.femaleHeightGrowthRisk = value;
    });
  }

  late final _$femaleWeightGrowthRiskAtom =
      Atom(name: '_GrowthStore.femaleWeightGrowthRisk', context: context);

  @override
  List<LocalGrowth>? get femaleWeightGrowthRisk {
    _$femaleWeightGrowthRiskAtom.reportRead();
    return super.femaleWeightGrowthRisk;
  }

  @override
  set femaleWeightGrowthRisk(List<LocalGrowth>? value) {
    _$femaleWeightGrowthRiskAtom
        .reportWrite(value, super.femaleWeightGrowthRisk, () {
      super.femaleWeightGrowthRisk = value;
    });
  }

  late final _$femaleHeadGrowthRiskAtom =
      Atom(name: '_GrowthStore.femaleHeadGrowthRisk', context: context);

  @override
  List<LocalGrowth>? get femaleHeadGrowthRisk {
    _$femaleHeadGrowthRiskAtom.reportRead();
    return super.femaleHeadGrowthRisk;
  }

  @override
  set femaleHeadGrowthRisk(List<LocalGrowth>? value) {
    _$femaleHeadGrowthRiskAtom.reportWrite(value, super.femaleHeadGrowthRisk,
        () {
      super.femaleHeadGrowthRisk = value;
    });
  }

  late final _$femaleBmiGrowthRiskAtom =
      Atom(name: '_GrowthStore.femaleBmiGrowthRisk', context: context);

  @override
  List<LocalGrowth>? get femaleBmiGrowthRisk {
    _$femaleBmiGrowthRiskAtom.reportRead();
    return super.femaleBmiGrowthRisk;
  }

  @override
  set femaleBmiGrowthRisk(List<LocalGrowth>? value) {
    _$femaleBmiGrowthRiskAtom.reportWrite(value, super.femaleBmiGrowthRisk, () {
      super.femaleBmiGrowthRisk = value;
    });
  }

  late final _$selectedChildHeightAtom =
      Atom(name: '_GrowthStore.selectedChildHeight', context: context);

  @override
  List<LocalChildGrowth>? get selectedChildHeight {
    _$selectedChildHeightAtom.reportRead();
    return super.selectedChildHeight;
  }

  @override
  set selectedChildHeight(List<LocalChildGrowth>? value) {
    _$selectedChildHeightAtom.reportWrite(value, super.selectedChildHeight, () {
      super.selectedChildHeight = value;
    });
  }

  late final _$selectedChildWeightAtom =
      Atom(name: '_GrowthStore.selectedChildWeight', context: context);

  @override
  List<LocalChildGrowth>? get selectedChildWeight {
    _$selectedChildWeightAtom.reportRead();
    return super.selectedChildWeight;
  }

  @override
  set selectedChildWeight(List<LocalChildGrowth>? value) {
    _$selectedChildWeightAtom.reportWrite(value, super.selectedChildWeight, () {
      super.selectedChildWeight = value;
    });
  }

  late final _$selectedChildHeadAtom =
      Atom(name: '_GrowthStore.selectedChildHead', context: context);

  @override
  List<LocalChildGrowth>? get selectedChildHead {
    _$selectedChildHeadAtom.reportRead();
    return super.selectedChildHead;
  }

  @override
  set selectedChildHead(List<LocalChildGrowth>? value) {
    _$selectedChildHeadAtom.reportWrite(value, super.selectedChildHead, () {
      super.selectedChildHead = value;
    });
  }

  late final _$selectedChildBmiAtom =
      Atom(name: '_GrowthStore.selectedChildBmi', context: context);

  @override
  List<LocalChildGrowth>? get selectedChildBmi {
    _$selectedChildBmiAtom.reportRead();
    return super.selectedChildBmi;
  }

  @override
  set selectedChildBmi(List<LocalChildGrowth>? value) {
    _$selectedChildBmiAtom.reportWrite(value, super.selectedChildBmi, () {
      super.selectedChildBmi = value;
    });
  }

  late final _$combinedGrowthAtom =
      Atom(name: '_GrowthStore.combinedGrowth', context: context);

  @override
  List<LocalCombinedGrowth>? get combinedGrowth {
    _$combinedGrowthAtom.reportRead();
    return super.combinedGrowth;
  }

  @override
  set combinedGrowth(List<LocalCombinedGrowth>? value) {
    _$combinedGrowthAtom.reportWrite(value, super.combinedGrowth, () {
      super.combinedGrowth = value;
    });
  }

  late final _$successAtom =
      Atom(name: '_GrowthStore.success', context: context);

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  late final _$successDeleteAtom =
      Atom(name: '_GrowthStore.successDelete', context: context);

  @override
  bool get successDelete {
    _$successDeleteAtom.reportRead();
    return super.successDelete;
  }

  @override
  set successDelete(bool value) {
    _$successDeleteAtom.reportWrite(value, super.successDelete, () {
      super.successDelete = value;
    });
  }

  late final _$loadingAtom =
      Atom(name: '_GrowthStore.loading', context: context);

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  late final _$addGrowthAsyncAction =
      AsyncAction('_GrowthStore.addGrowth', context: context);

  @override
  Future<dynamic> addGrowth(int childrenId) {
    return _$addGrowthAsyncAction.run(() => super.addGrowth(childrenId));
  }

  late final _$selectGrowthByChildIdAsyncAction =
      AsyncAction('_GrowthStore.selectGrowthByChildId', context: context);

  @override
  Future<dynamic> selectGrowthByChildId(int? childrenId) {
    return _$selectGrowthByChildIdAsyncAction
        .run(() => super.selectGrowthByChildId(childrenId));
  }

  late final _$updateGrowthAsyncAction =
      AsyncAction('_GrowthStore.updateGrowth', context: context);

  @override
  Future<dynamic> updateGrowth(int childrenId) {
    return _$updateGrowthAsyncAction.run(() => super.updateGrowth(childrenId));
  }

  late final _$deleteGrowthAsyncAction =
      AsyncAction('_GrowthStore.deleteGrowth', context: context);

  @override
  Future<dynamic> deleteGrowth(int growthId) {
    return _$deleteGrowthAsyncAction.run(() => super.deleteGrowth(growthId));
  }

  late final _$getGrowthsByUserAsyncAction =
      AsyncAction('_GrowthStore.getGrowthsByUser', context: context);

  @override
  Future<dynamic> getGrowthsByUser() {
    return _$getGrowthsByUserAsyncAction.run(() => super.getGrowthsByUser());
  }

  late final _$getAllGrowthRiskDatasAsyncAction =
      AsyncAction('_GrowthStore.getAllGrowthRiskDatas', context: context);

  @override
  Future<dynamic> getAllGrowthRiskDatas(String? gender) {
    return _$getAllGrowthRiskDatasAsyncAction
        .run(() => super.getAllGrowthRiskDatas(gender));
  }

  late final _$getHeightDatasAsyncAction =
      AsyncAction('_GrowthStore.getHeightDatas', context: context);

  @override
  Future<dynamic> getHeightDatas(String? gender) {
    return _$getHeightDatasAsyncAction.run(() => super.getHeightDatas(gender));
  }

  late final _$getWeightDatasAsyncAction =
      AsyncAction('_GrowthStore.getWeightDatas', context: context);

  @override
  Future<dynamic> getWeightDatas(String? gender) {
    return _$getWeightDatasAsyncAction.run(() => super.getWeightDatas(gender));
  }

  late final _$getHeadDatasAsyncAction =
      AsyncAction('_GrowthStore.getHeadDatas', context: context);

  @override
  Future<dynamic> getHeadDatas(String? gender) {
    return _$getHeadDatasAsyncAction.run(() => super.getHeadDatas(gender));
  }

  late final _$getBmiDatasAsyncAction =
      AsyncAction('_GrowthStore.getBmiDatas', context: context);

  @override
  Future<dynamic> getBmiDatas(String? gender) {
    return _$getBmiDatasAsyncAction.run(() => super.getBmiDatas(gender));
  }

  late final _$getDetailedNormalTableAsyncAction =
      AsyncAction('_GrowthStore.getDetailedNormalTable', context: context);

  @override
  Future<dynamic> getDetailedNormalTable(StatsType statsType) {
    return _$getDetailedNormalTableAsyncAction
        .run(() => super.getDetailedNormalTable(statsType));
  }

  late final _$getSelectedChildGrowthGraphAsyncAction =
      AsyncAction('_GrowthStore.getSelectedChildGrowthGraph', context: context);

  @override
  Future<dynamic> getSelectedChildGrowthGraph() {
    return _$getSelectedChildGrowthGraphAsyncAction
        .run(() => super.getSelectedChildGrowthGraph());
  }

  late final _$_GrowthStoreActionController =
      ActionController(name: '_GrowthStore', context: context);

  @override
  void setHeight(double value) {
    final _$actionInfo = _$_GrowthStoreActionController.startAction(
        name: '_GrowthStore.setHeight');
    try {
      return super.setHeight(value);
    } finally {
      _$_GrowthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setWeight(double value) {
    final _$actionInfo = _$_GrowthStoreActionController.startAction(
        name: '_GrowthStore.setWeight');
    try {
      return super.setWeight(value);
    } finally {
      _$_GrowthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHeadCircumreference(double value) {
    final _$actionInfo = _$_GrowthStoreActionController.startAction(
        name: '_GrowthStore.setHeadCircumreference');
    try {
      return super.setHeadCircumreference(value);
    } finally {
      _$_GrowthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMeasurementDate(DateTime value) {
    final _$actionInfo = _$_GrowthStoreActionController.startAction(
        name: '_GrowthStore.setMeasurementDate');
    try {
      return super.setMeasurementDate(value);
    } finally {
      _$_GrowthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateHeight(double value) {
    final _$actionInfo = _$_GrowthStoreActionController.startAction(
        name: '_GrowthStore.validateHeight');
    try {
      return super.validateHeight(value);
    } finally {
      _$_GrowthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateWeight(double value) {
    final _$actionInfo = _$_GrowthStoreActionController.startAction(
        name: '_GrowthStore.validateWeight');
    try {
      return super.validateWeight(value);
    } finally {
      _$_GrowthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateHeadCircumreference(double value) {
    final _$actionInfo = _$_GrowthStoreActionController.startAction(
        name: '_GrowthStore.validateHeadCircumreference');
    try {
      return super.validateHeadCircumreference(value);
    } finally {
      _$_GrowthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateMeasurementDate(DateTime? value) {
    final _$actionInfo = _$_GrowthStoreActionController.startAction(
        name: '_GrowthStore.validateMeasurementDate');
    try {
      return super.validateMeasurementDate(value);
    } finally {
      _$_GrowthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getWeightRisk() {
    final _$actionInfo = _$_GrowthStoreActionController.startAction(
        name: '_GrowthStore.getWeightRisk');
    try {
      return super.getWeightRisk();
    } finally {
      _$_GrowthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getHeightRisk() {
    final _$actionInfo = _$_GrowthStoreActionController.startAction(
        name: '_GrowthStore.getHeightRisk');
    try {
      return super.getHeightRisk();
    } finally {
      _$_GrowthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getHeadRisk() {
    final _$actionInfo = _$_GrowthStoreActionController.startAction(
        name: '_GrowthStore.getHeadRisk');
    try {
      return super.getHeadRisk();
    } finally {
      _$_GrowthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getBmiRisk() {
    final _$actionInfo = _$_GrowthStoreActionController.startAction(
        name: '_GrowthStore.getBmiRisk');
    try {
      return super.getBmiRisk();
    } finally {
      _$_GrowthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void selectGrowth(dynamic growth) {
    final _$actionInfo = _$_GrowthStoreActionController.startAction(
        name: '_GrowthStore.selectGrowth');
    try {
      return super.selectGrowth(growth);
    } finally {
      _$_GrowthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String getGrowthDesc(StatsType statsType) {
    final _$actionInfo = _$_GrowthStoreActionController.startAction(
        name: '_GrowthStore.getGrowthDesc');
    try {
      return super.getGrowthDesc(statsType);
    } finally {
      _$_GrowthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
height: ${height},
weight: ${weight},
headCircumference: ${headCircumference},
measurementDate: ${measurementDate},
selectedGrowth: ${selectedGrowth},
selectedGrowthId: ${selectedGrowthId},
growths: ${growths},
selectedGrowths: ${selectedGrowths},
selectedWeightRisk: ${selectedWeightRisk},
selectedHeightRisk: ${selectedHeightRisk},
selectedHeadRisk: ${selectedHeadRisk},
selectedBmiRisk: ${selectedBmiRisk},
selectedHeightGrowthRisk: ${selectedHeightGrowthRisk},
selectedWeightGrowthRisk: ${selectedWeightGrowthRisk},
selectedHeadGrowthRisk: ${selectedHeadGrowthRisk},
selectedBmiGrowthRisk: ${selectedBmiGrowthRisk},
maleHeightGrowthRisk: ${maleHeightGrowthRisk},
maleWeightGrowthRisk: ${maleWeightGrowthRisk},
maleHeadGrowthRisk: ${maleHeadGrowthRisk},
maleBmiGrowthRisk: ${maleBmiGrowthRisk},
femaleHeightGrowthRisk: ${femaleHeightGrowthRisk},
femaleWeightGrowthRisk: ${femaleWeightGrowthRisk},
femaleHeadGrowthRisk: ${femaleHeadGrowthRisk},
femaleBmiGrowthRisk: ${femaleBmiGrowthRisk},
selectedChildHeight: ${selectedChildHeight},
selectedChildWeight: ${selectedChildWeight},
selectedChildHead: ${selectedChildHead},
selectedChildBmi: ${selectedChildBmi},
combinedGrowth: ${combinedGrowth},
success: ${success},
successDelete: ${successDelete},
loading: ${loading},
canAddGrowth: ${canAddGrowth}
    ''';
  }
}

mixin _$GrowthErrorStore on _GrowthErrorStore, Store {
  Computed<bool>? _$hasErrorAddGrowthComputed;

  @override
  bool get hasErrorAddGrowth => (_$hasErrorAddGrowthComputed ??= Computed<bool>(
          () => super.hasErrorAddGrowth,
          name: '_GrowthErrorStore.hasErrorAddGrowth'))
      .value;

  late final _$heightAtom =
      Atom(name: '_GrowthErrorStore.height', context: context);

  @override
  String? get height {
    _$heightAtom.reportRead();
    return super.height;
  }

  @override
  set height(String? value) {
    _$heightAtom.reportWrite(value, super.height, () {
      super.height = value;
    });
  }

  late final _$weightAtom =
      Atom(name: '_GrowthErrorStore.weight', context: context);

  @override
  String? get weight {
    _$weightAtom.reportRead();
    return super.weight;
  }

  @override
  set weight(String? value) {
    _$weightAtom.reportWrite(value, super.weight, () {
      super.weight = value;
    });
  }

  late final _$headCircumferenceAtom =
      Atom(name: '_GrowthErrorStore.headCircumference', context: context);

  @override
  String? get headCircumference {
    _$headCircumferenceAtom.reportRead();
    return super.headCircumference;
  }

  @override
  set headCircumference(String? value) {
    _$headCircumferenceAtom.reportWrite(value, super.headCircumference, () {
      super.headCircumference = value;
    });
  }

  late final _$measurementDateAtom =
      Atom(name: '_GrowthErrorStore.measurementDate', context: context);

  @override
  String? get measurementDate {
    _$measurementDateAtom.reportRead();
    return super.measurementDate;
  }

  @override
  set measurementDate(String? value) {
    _$measurementDateAtom.reportWrite(value, super.measurementDate, () {
      super.measurementDate = value;
    });
  }

  @override
  String toString() {
    return '''
height: ${height},
weight: ${weight},
headCircumference: ${headCircumference},
measurementDate: ${measurementDate},
hasErrorAddGrowth: ${hasErrorAddGrowth}
    ''';
  }
}
