// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preference_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PreferenceStore on _PreferenceStore, Store {
  late final _$listPreferenceItemsAtom =
      Atom(name: '_PreferenceStore.listPreferenceItems', context: context);

  @override
  List<PreferenceItem> get listPreferenceItems {
    _$listPreferenceItemsAtom.reportRead();
    return super.listPreferenceItems;
  }

  @override
  set listPreferenceItems(List<PreferenceItem> value) {
    _$listPreferenceItemsAtom.reportWrite(value, super.listPreferenceItems, () {
      super.listPreferenceItems = value;
    });
  }

  late final _$preferenceAtom =
      Atom(name: '_PreferenceStore.preference', context: context);

  @override
  dynamic get preference {
    _$preferenceAtom.reportRead();
    return super.preference;
  }

  @override
  set preference(dynamic value) {
    _$preferenceAtom.reportWrite(value, super.preference, () {
      super.preference = value;
    });
  }

  late final _$preferenceIdAtom =
      Atom(name: '_PreferenceStore.preferenceId', context: context);

  @override
  int get preferenceId {
    _$preferenceIdAtom.reportRead();
    return super.preferenceId;
  }

  @override
  set preferenceId(int value) {
    _$preferenceIdAtom.reportWrite(value, super.preferenceId, () {
      super.preferenceId = value;
    });
  }

  late final _$successAtom =
      Atom(name: '_PreferenceStore.success', context: context);

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
      Atom(name: '_PreferenceStore.loading', context: context);

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

  late final _$profileImageAtom =
      Atom(name: '_PreferenceStore.profileImage', context: context);

  @override
  Uint8List? get profileImage {
    _$profileImageAtom.reportRead();
    return super.profileImage;
  }

  @override
  set profileImage(Uint8List? value) {
    _$profileImageAtom.reportWrite(value, super.profileImage, () {
      super.profileImage = value;
    });
  }

  late final _$addPreferenceAsyncAction =
      AsyncAction('_PreferenceStore.addPreference', context: context);

  @override
  Future<dynamic> addPreference() {
    return _$addPreferenceAsyncAction.run(() => super.addPreference());
  }

  late final _$updatePreferenceAsyncAction =
      AsyncAction('_PreferenceStore.updatePreference', context: context);

  @override
  Future<dynamic> updatePreference() {
    return _$updatePreferenceAsyncAction.run(() => super.updatePreference());
  }

  late final _$getPreferenceByUserAsyncAction =
      AsyncAction('_PreferenceStore.getPreferenceByUser', context: context);

  @override
  Future<dynamic> getPreferenceByUser() {
    return _$getPreferenceByUserAsyncAction
        .run(() => super.getPreferenceByUser());
  }

  late final _$_PreferenceStoreActionController =
      ActionController(name: '_PreferenceStore', context: context);

  @override
  void setPreference(int id, bool value) {
    final _$actionInfo = _$_PreferenceStoreActionController.startAction(
        name: '_PreferenceStore.setPreference');
    try {
      return super.setPreference(id, value);
    } finally {
      _$_PreferenceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setProfileImage(Uint8List value) {
    final _$actionInfo = _$_PreferenceStoreActionController.startAction(
        name: '_PreferenceStore.setProfileImage');
    try {
      return super.setProfileImage(value);
    } finally {
      _$_PreferenceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
listPreferenceItems: ${listPreferenceItems},
preference: ${preference},
preferenceId: ${preferenceId},
success: ${success},
loading: ${loading},
profileImage: ${profileImage}
    ''';
  }
}
