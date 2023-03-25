// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'children_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ChildrenStore on _ChildrenStore, Store {
  Computed<String>? _$getAgeComputed;

  @override
  String get getAge => (_$getAgeComputed ??=
          Computed<String>(() => super.getAge, name: '_ChildrenStore.getAge'))
      .value;
  Computed<bool>? _$canAddChildrenComputed;

  @override
  bool get canAddChildren =>
      (_$canAddChildrenComputed ??= Computed<bool>(() => super.canAddChildren,
              name: '_ChildrenStore.canAddChildren'))
          .value;

  late final _$firstNameAtom =
      Atom(name: '_ChildrenStore.firstName', context: context);

  @override
  String get firstName {
    _$firstNameAtom.reportRead();
    return super.firstName;
  }

  @override
  set firstName(String value) {
    _$firstNameAtom.reportWrite(value, super.firstName, () {
      super.firstName = value;
    });
  }

  late final _$selectedChildrenAtom =
      Atom(name: '_ChildrenStore.selectedChildren', context: context);

  @override
  dynamic get selectedChildren {
    _$selectedChildrenAtom.reportRead();
    return super.selectedChildren;
  }

  @override
  set selectedChildren(dynamic value) {
    _$selectedChildrenAtom.reportWrite(value, super.selectedChildren, () {
      super.selectedChildren = value;
    });
  }

  late final _$selectedChildrenIdAtom =
      Atom(name: '_ChildrenStore.selectedChildrenId', context: context);

  @override
  int get selectedChildrenId {
    _$selectedChildrenIdAtom.reportRead();
    return super.selectedChildrenId;
  }

  @override
  set selectedChildrenId(int value) {
    _$selectedChildrenIdAtom.reportWrite(value, super.selectedChildrenId, () {
      super.selectedChildrenId = value;
    });
  }

  late final _$childrensAtom =
      Atom(name: '_ChildrenStore.childrens', context: context);

  @override
  List<dynamic>? get childrens {
    _$childrensAtom.reportRead();
    return super.childrens;
  }

  @override
  set childrens(List<dynamic>? value) {
    _$childrensAtom.reportWrite(value, super.childrens, () {
      super.childrens = value;
    });
  }

  late final _$lastNameAtom =
      Atom(name: '_ChildrenStore.lastName', context: context);

  @override
  String get lastName {
    _$lastNameAtom.reportRead();
    return super.lastName;
  }

  @override
  set lastName(String value) {
    _$lastNameAtom.reportWrite(value, super.lastName, () {
      super.lastName = value;
    });
  }

  late final _$genderAtom =
      Atom(name: '_ChildrenStore.gender', context: context);

  @override
  String get gender {
    _$genderAtom.reportRead();
    return super.gender;
  }

  @override
  set gender(String value) {
    _$genderAtom.reportWrite(value, super.gender, () {
      super.gender = value;
    });
  }

  late final _$birthdayAtom =
      Atom(name: '_ChildrenStore.birthday', context: context);

  @override
  DateTime? get birthday {
    _$birthdayAtom.reportRead();
    return super.birthday;
  }

  @override
  set birthday(DateTime? value) {
    _$birthdayAtom.reportWrite(value, super.birthday, () {
      super.birthday = value;
    });
  }

  late final _$successAtom =
      Atom(name: '_ChildrenStore.success', context: context);

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
      Atom(name: '_ChildrenStore.loading', context: context);

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
      Atom(name: '_ChildrenStore.profileImage', context: context);

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

  late final _$selectChildrenAsyncAction =
      AsyncAction('_ChildrenStore.selectChildren', context: context);

  @override
  Future<void> selectChildren(dynamic children) {
    return _$selectChildrenAsyncAction
        .run(() => super.selectChildren(children));
  }

  late final _$addChildrenAsyncAction =
      AsyncAction('_ChildrenStore.addChildren', context: context);

  @override
  Future<dynamic> addChildren() {
    return _$addChildrenAsyncAction.run(() => super.addChildren());
  }

  late final _$updateChildrenAsyncAction =
      AsyncAction('_ChildrenStore.updateChildren', context: context);

  @override
  Future<dynamic> updateChildren() {
    return _$updateChildrenAsyncAction.run(() => super.updateChildren());
  }

  late final _$getChildrensByUserAsyncAction =
      AsyncAction('_ChildrenStore.getChildrensByUser', context: context);

  @override
  Future<dynamic> getChildrensByUser() {
    return _$getChildrensByUserAsyncAction
        .run(() => super.getChildrensByUser());
  }

  late final _$getInitialChildrenDataAsyncAction =
      AsyncAction('_ChildrenStore.getInitialChildrenData', context: context);

  @override
  Future<dynamic> getInitialChildrenData() {
    return _$getInitialChildrenDataAsyncAction
        .run(() => super.getInitialChildrenData());
  }

  late final _$_ChildrenStoreActionController =
      ActionController(name: '_ChildrenStore', context: context);

  @override
  void setFirstName(String value) {
    final _$actionInfo = _$_ChildrenStoreActionController.startAction(
        name: '_ChildrenStore.setFirstName');
    try {
      return super.setFirstName(value);
    } finally {
      _$_ChildrenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLastName(String value) {
    final _$actionInfo = _$_ChildrenStoreActionController.startAction(
        name: '_ChildrenStore.setLastName');
    try {
      return super.setLastName(value);
    } finally {
      _$_ChildrenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setGender(String value) {
    final _$actionInfo = _$_ChildrenStoreActionController.startAction(
        name: '_ChildrenStore.setGender');
    try {
      return super.setGender(value);
    } finally {
      _$_ChildrenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setBirthday(DateTime value) {
    final _$actionInfo = _$_ChildrenStoreActionController.startAction(
        name: '_ChildrenStore.setBirthday');
    try {
      return super.setBirthday(value);
    } finally {
      _$_ChildrenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setProfileImage(Uint8List value) {
    final _$actionInfo = _$_ChildrenStoreActionController.startAction(
        name: '_ChildrenStore.setProfileImage');
    try {
      return super.setProfileImage(value);
    } finally {
      _$_ChildrenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateFirstName(String value) {
    final _$actionInfo = _$_ChildrenStoreActionController.startAction(
        name: '_ChildrenStore.validateFirstName');
    try {
      return super.validateFirstName(value);
    } finally {
      _$_ChildrenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateLastName(String value) {
    final _$actionInfo = _$_ChildrenStoreActionController.startAction(
        name: '_ChildrenStore.validateLastName');
    try {
      return super.validateLastName(value);
    } finally {
      _$_ChildrenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateGender(String value) {
    final _$actionInfo = _$_ChildrenStoreActionController.startAction(
        name: '_ChildrenStore.validateGender');
    try {
      return super.validateGender(value);
    } finally {
      _$_ChildrenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateBirthday(DateTime? value) {
    final _$actionInfo = _$_ChildrenStoreActionController.startAction(
        name: '_ChildrenStore.validateBirthday');
    try {
      return super.validateBirthday(value);
    } finally {
      _$_ChildrenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
firstName: ${firstName},
selectedChildren: ${selectedChildren},
selectedChildrenId: ${selectedChildrenId},
childrens: ${childrens},
lastName: ${lastName},
gender: ${gender},
birthday: ${birthday},
success: ${success},
loading: ${loading},
profileImage: ${profileImage},
getAge: ${getAge},
canAddChildren: ${canAddChildren}
    ''';
  }
}

mixin _$ChildrenErrorStore on _ChildrenErrorStore, Store {
  Computed<bool>? _$hasErrorAddChildComputed;

  @override
  bool get hasErrorAddChild => (_$hasErrorAddChildComputed ??= Computed<bool>(
          () => super.hasErrorAddChild,
          name: '_ChildrenErrorStore.hasErrorAddChild'))
      .value;

  late final _$firstNameAtom =
      Atom(name: '_ChildrenErrorStore.firstName', context: context);

  @override
  String? get firstName {
    _$firstNameAtom.reportRead();
    return super.firstName;
  }

  @override
  set firstName(String? value) {
    _$firstNameAtom.reportWrite(value, super.firstName, () {
      super.firstName = value;
    });
  }

  late final _$lastNameAtom =
      Atom(name: '_ChildrenErrorStore.lastName', context: context);

  @override
  String? get lastName {
    _$lastNameAtom.reportRead();
    return super.lastName;
  }

  @override
  set lastName(String? value) {
    _$lastNameAtom.reportWrite(value, super.lastName, () {
      super.lastName = value;
    });
  }

  late final _$genderAtom =
      Atom(name: '_ChildrenErrorStore.gender', context: context);

  @override
  String? get gender {
    _$genderAtom.reportRead();
    return super.gender;
  }

  @override
  set gender(String? value) {
    _$genderAtom.reportWrite(value, super.gender, () {
      super.gender = value;
    });
  }

  late final _$birthdayAtom =
      Atom(name: '_ChildrenErrorStore.birthday', context: context);

  @override
  String? get birthday {
    _$birthdayAtom.reportRead();
    return super.birthday;
  }

  @override
  set birthday(String? value) {
    _$birthdayAtom.reportWrite(value, super.birthday, () {
      super.birthday = value;
    });
  }

  @override
  String toString() {
    return '''
firstName: ${firstName},
lastName: ${lastName},
gender: ${gender},
birthday: ${birthday},
hasErrorAddChild: ${hasErrorAddChild}
    ''';
  }
}
