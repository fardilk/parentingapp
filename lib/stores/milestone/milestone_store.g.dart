// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'milestone_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MilestoneStore on _MilestoneStore, Store {
  late final _$selectedPeriodeIndexAtom =
      Atom(name: '_MilestoneStore.selectedPeriodeIndex', context: context);

  @override
  int get selectedPeriodeIndex {
    _$selectedPeriodeIndexAtom.reportRead();
    return super.selectedPeriodeIndex;
  }

  @override
  set selectedPeriodeIndex(int value) {
    _$selectedPeriodeIndexAtom.reportWrite(value, super.selectedPeriodeIndex,
        () {
      super.selectedPeriodeIndex = value;
    });
  }

  late final _$checkedAtom =
      Atom(name: '_MilestoneStore.checked', context: context);

  @override
  int get checked {
    _$checkedAtom.reportRead();
    return super.checked;
  }

  @override
  set checked(int value) {
    _$checkedAtom.reportWrite(value, super.checked, () {
      super.checked = value;
    });
  }

  late final _$totalAtom =
      Atom(name: '_MilestoneStore.total', context: context);

  @override
  int get total {
    _$totalAtom.reportRead();
    return super.total;
  }

  @override
  set total(int value) {
    _$totalAtom.reportWrite(value, super.total, () {
      super.total = value;
    });
  }

  late final _$milestoneAtom =
      Atom(name: '_MilestoneStore.milestone', context: context);

  @override
  dynamic get milestone {
    _$milestoneAtom.reportRead();
    return super.milestone;
  }

  @override
  set milestone(dynamic value) {
    _$milestoneAtom.reportWrite(value, super.milestone, () {
      super.milestone = value;
    });
  }

  late final _$milestoneChildrenAtom =
      Atom(name: '_MilestoneStore.milestoneChildren', context: context);

  @override
  dynamic get milestoneChildren {
    _$milestoneChildrenAtom.reportRead();
    return super.milestoneChildren;
  }

  @override
  set milestoneChildren(dynamic value) {
    _$milestoneChildrenAtom.reportWrite(value, super.milestoneChildren, () {
      super.milestoneChildren = value;
    });
  }

  late final _$childMilestoneAtom =
      Atom(name: '_MilestoneStore.childMilestone', context: context);

  @override
  dynamic get childMilestone {
    _$childMilestoneAtom.reportRead();
    return super.childMilestone;
  }

  @override
  set childMilestone(dynamic value) {
    _$childMilestoneAtom.reportWrite(value, super.childMilestone, () {
      super.childMilestone = value;
    });
  }

  late final _$milestoneIdAtom =
      Atom(name: '_MilestoneStore.milestoneId', context: context);

  @override
  int get milestoneId {
    _$milestoneIdAtom.reportRead();
    return super.milestoneId;
  }

  @override
  set milestoneId(int value) {
    _$milestoneIdAtom.reportWrite(value, super.milestoneId, () {
      super.milestoneId = value;
    });
  }

  late final _$listPeriodeAtom =
      Atom(name: '_MilestoneStore.listPeriode', context: context);

  @override
  List<Periode> get listPeriode {
    _$listPeriodeAtom.reportRead();
    return super.listPeriode;
  }

  @override
  set listPeriode(List<Periode> value) {
    _$listPeriodeAtom.reportWrite(value, super.listPeriode, () {
      super.listPeriode = value;
    });
  }

  late final _$listVaccineScheduleAtom =
      Atom(name: '_MilestoneStore.listVaccineSchedule', context: context);

  @override
  List<VaccineSchedule> get listVaccineSchedule {
    _$listVaccineScheduleAtom.reportRead();
    return super.listVaccineSchedule;
  }

  @override
  set listVaccineSchedule(List<VaccineSchedule> value) {
    _$listVaccineScheduleAtom.reportWrite(value, super.listVaccineSchedule, () {
      super.listVaccineSchedule = value;
    });
  }

  late final _$listMilestoneAtom =
      Atom(name: '_MilestoneStore.listMilestone', context: context);

  @override
  List<dynamic> get listMilestone {
    _$listMilestoneAtom.reportRead();
    return super.listMilestone;
  }

  @override
  set listMilestone(List<dynamic> value) {
    _$listMilestoneAtom.reportWrite(value, super.listMilestone, () {
      super.listMilestone = value;
    });
  }

  late final _$successAtom =
      Atom(name: '_MilestoneStore.success', context: context);

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

  late final _$loadingAtom =
      Atom(name: '_MilestoneStore.loading', context: context);

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

  late final _$setMilestoneIdAsyncAction =
      AsyncAction('_MilestoneStore.setMilestoneId', context: context);

  @override
  Future<void> setMilestoneId(int value) {
    return _$setMilestoneIdAsyncAction.run(() => super.setMilestoneId(value));
  }

  late final _$getUnregisteredMilestoneAsyncAction =
      AsyncAction('_MilestoneStore.getUnregisteredMilestone', context: context);

  @override
  Future<dynamic> getUnregisteredMilestone() {
    return _$getUnregisteredMilestoneAsyncAction
        .run(() => super.getUnregisteredMilestone());
  }

  late final _$getRegisteredMilestoneAsyncAction =
      AsyncAction('_MilestoneStore.getRegisteredMilestone', context: context);

  @override
  Future<dynamic> getRegisteredMilestone(int childrenId) {
    return _$getRegisteredMilestoneAsyncAction
        .run(() => super.getRegisteredMilestone(childrenId));
  }

  late final _$addMilestoneAsyncAction =
      AsyncAction('_MilestoneStore.addMilestone', context: context);

  @override
  Future<dynamic> addMilestone(int childrenId, int milestoneId) {
    return _$addMilestoneAsyncAction
        .run(() => super.addMilestone(childrenId, milestoneId));
  }

  late final _$_MilestoneStoreActionController =
      ActionController(name: '_MilestoneStore', context: context);

  @override
  void setPeriode(int periodeId) {
    final _$actionInfo = _$_MilestoneStoreActionController.startAction(
        name: '_MilestoneStore.setPeriode');
    try {
      return super.setPeriode(periodeId);
    } finally {
      _$_MilestoneStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMilestoneChildren(MilestoneChildren value) {
    final _$actionInfo = _$_MilestoneStoreActionController.startAction(
        name: '_MilestoneStore.setMilestoneChildren');
    try {
      return super.setMilestoneChildren(value);
    } finally {
      _$_MilestoneStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedPeriodeIndex: ${selectedPeriodeIndex},
checked: ${checked},
total: ${total},
milestone: ${milestone},
milestoneChildren: ${milestoneChildren},
childMilestone: ${childMilestone},
milestoneId: ${milestoneId},
listPeriode: ${listPeriode},
listVaccineSchedule: ${listVaccineSchedule},
listMilestone: ${listMilestone},
success: ${success},
loading: ${loading}
    ''';
  }
}
