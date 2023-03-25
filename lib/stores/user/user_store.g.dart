// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserStore on _UserStore, Store {
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading => (_$isLoadingComputed ??=
          Computed<bool>(() => super.isLoading, name: '_UserStore.isLoading'))
      .value;
  Computed<bool>? _$canContinueRegisterComputed;

  @override
  bool get canContinueRegister => (_$canContinueRegisterComputed ??=
          Computed<bool>(() => super.canContinueRegister,
              name: '_UserStore.canContinueRegister'))
      .value;
  Computed<bool>? _$canChangePasswordComputed;

  @override
  bool get canChangePassword => (_$canChangePasswordComputed ??= Computed<bool>(
          () => super.canChangePassword,
          name: '_UserStore.canChangePassword'))
      .value;

  late final _$isLoggedInAtom =
      Atom(name: '_UserStore.isLoggedIn', context: context);

  @override
  bool get isLoggedIn {
    _$isLoggedInAtom.reportRead();
    return super.isLoggedIn;
  }

  @override
  set isLoggedIn(bool value) {
    _$isLoggedInAtom.reportWrite(value, super.isLoggedIn, () {
      super.isLoggedIn = value;
    });
  }

  late final _$isVerifiedAtom =
      Atom(name: '_UserStore.isVerified', context: context);

  @override
  bool get isVerified {
    _$isVerifiedAtom.reportRead();
    return super.isVerified;
  }

  @override
  set isVerified(bool value) {
    _$isVerifiedAtom.reportWrite(value, super.isVerified, () {
      super.isVerified = value;
    });
  }

  late final _$isPhoneVerifiedAtom =
      Atom(name: '_UserStore.isPhoneVerified', context: context);

  @override
  bool get isPhoneVerified {
    _$isPhoneVerifiedAtom.reportRead();
    return super.isPhoneVerified;
  }

  @override
  set isPhoneVerified(bool value) {
    _$isPhoneVerifiedAtom.reportWrite(value, super.isPhoneVerified, () {
      super.isPhoneVerified = value;
    });
  }

  late final _$isFirstTimeShowcaseAtom =
      Atom(name: '_UserStore.isFirstTimeShowcase', context: context);

  @override
  bool get isFirstTimeShowcase {
    _$isFirstTimeShowcaseAtom.reportRead();
    return super.isFirstTimeShowcase;
  }

  @override
  set isFirstTimeShowcase(bool value) {
    _$isFirstTimeShowcaseAtom.reportWrite(value, super.isFirstTimeShowcase, () {
      super.isFirstTimeShowcase = value;
    });
  }

  late final _$currentUserIdAtom =
      Atom(name: '_UserStore.currentUserId', context: context);

  @override
  int get currentUserId {
    _$currentUserIdAtom.reportRead();
    return super.currentUserId;
  }

  @override
  set currentUserId(int value) {
    _$currentUserIdAtom.reportWrite(value, super.currentUserId, () {
      super.currentUserId = value;
    });
  }

  late final _$profileImageAtom =
      Atom(name: '_UserStore.profileImage', context: context);

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

  late final _$emailAtom = Atom(name: '_UserStore.email', context: context);

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  late final _$firstNameAtom =
      Atom(name: '_UserStore.firstName', context: context);

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

  late final _$lastNameAtom =
      Atom(name: '_UserStore.lastName', context: context);

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

  late final _$genderAtom = Atom(name: '_UserStore.gender', context: context);

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
      Atom(name: '_UserStore.birthday', context: context);

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

  late final _$phoneNumberAtom =
      Atom(name: '_UserStore.phoneNumber', context: context);

  @override
  String get phoneNumber {
    _$phoneNumberAtom.reportRead();
    return super.phoneNumber;
  }

  @override
  set phoneNumber(String value) {
    _$phoneNumberAtom.reportWrite(value, super.phoneNumber, () {
      super.phoneNumber = value;
    });
  }

  late final _$oldPasswordAtom =
      Atom(name: '_UserStore.oldPassword', context: context);

  @override
  String get oldPassword {
    _$oldPasswordAtom.reportRead();
    return super.oldPassword;
  }

  @override
  set oldPassword(String value) {
    _$oldPasswordAtom.reportWrite(value, super.oldPassword, () {
      super.oldPassword = value;
    });
  }

  late final _$passwordAtom =
      Atom(name: '_UserStore.password', context: context);

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  late final _$confirmPasswordAtom =
      Atom(name: '_UserStore.confirmPassword', context: context);

  @override
  String get confirmPassword {
    _$confirmPasswordAtom.reportRead();
    return super.confirmPassword;
  }

  @override
  set confirmPassword(String value) {
    _$confirmPasswordAtom.reportWrite(value, super.confirmPassword, () {
      super.confirmPassword = value;
    });
  }

  late final _$successAtom = Atom(name: '_UserStore.success', context: context);

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

  late final _$loadingAtom = Atom(name: '_UserStore.loading', context: context);

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

  late final _$loginFutureAtom =
      Atom(name: '_UserStore.loginFuture', context: context);

  @override
  ObservableFuture<bool> get loginFuture {
    _$loginFutureAtom.reportRead();
    return super.loginFuture;
  }

  @override
  set loginFuture(ObservableFuture<bool> value) {
    _$loginFutureAtom.reportWrite(value, super.loginFuture, () {
      super.loginFuture = value;
    });
  }

  late final _$updateContinueRegisterAsyncAction =
      AsyncAction('_UserStore.updateContinueRegister', context: context);

  @override
  Future<dynamic> updateContinueRegister() {
    return _$updateContinueRegisterAsyncAction
        .run(() => super.updateContinueRegister());
  }

  late final _$verifyEmailAsyncAction =
      AsyncAction('_UserStore.verifyEmail', context: context);

  @override
  Future<dynamic> verifyEmail(String otp) {
    return _$verifyEmailAsyncAction.run(() => super.verifyEmail(otp));
  }

  late final _$sendVerificationEmailAsyncAction =
      AsyncAction('_UserStore.sendVerificationEmail', context: context);

  @override
  Future<dynamic> sendVerificationEmail() {
    return _$sendVerificationEmailAsyncAction
        .run(() => super.sendVerificationEmail());
  }

  late final _$verifyPhoneAsyncAction =
      AsyncAction('_UserStore.verifyPhone', context: context);

  @override
  Future<dynamic> verifyPhone() {
    return _$verifyPhoneAsyncAction.run(() => super.verifyPhone());
  }

  late final _$deleteAccountAsyncAction =
      AsyncAction('_UserStore.deleteAccount', context: context);

  @override
  Future<dynamic> deleteAccount() {
    return _$deleteAccountAsyncAction.run(() => super.deleteAccount());
  }

  late final _$loginAsyncAction =
      AsyncAction('_UserStore.login', context: context);

  @override
  Future<dynamic> login(String email, String password) {
    return _$loginAsyncAction.run(() => super.login(email, password));
  }

  late final _$changePasswordAsyncAction =
      AsyncAction('_UserStore.changePassword', context: context);

  @override
  Future<dynamic> changePassword() {
    return _$changePasswordAsyncAction.run(() => super.changePassword());
  }

  late final _$_UserStoreActionController =
      ActionController(name: '_UserStore', context: context);

  @override
  void setProfileImage(Uint8List value) {
    final _$actionInfo = _$_UserStoreActionController.startAction(
        name: '_UserStore.setProfileImage');
    try {
      return super.setProfileImage(value);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEmail(String value) {
    final _$actionInfo =
        _$_UserStoreActionController.startAction(name: '_UserStore.setEmail');
    try {
      return super.setEmail(value);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFirstName(String value) {
    final _$actionInfo = _$_UserStoreActionController.startAction(
        name: '_UserStore.setFirstName');
    try {
      return super.setFirstName(value);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLastName(String value) {
    final _$actionInfo = _$_UserStoreActionController.startAction(
        name: '_UserStore.setLastName');
    try {
      return super.setLastName(value);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setGender(String value) {
    final _$actionInfo =
        _$_UserStoreActionController.startAction(name: '_UserStore.setGender');
    try {
      return super.setGender(value);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setBirthday(DateTime value) {
    final _$actionInfo = _$_UserStoreActionController.startAction(
        name: '_UserStore.setBirthday');
    try {
      return super.setBirthday(value);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPhoneNumber(String value) {
    final _$actionInfo = _$_UserStoreActionController.startAction(
        name: '_UserStore.setPhoneNumber');
    try {
      return super.setPhoneNumber(value);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setOldPassword(String value) {
    final _$actionInfo = _$_UserStoreActionController.startAction(
        name: '_UserStore.setOldPassword');
    try {
      return super.setOldPassword(value);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String value) {
    final _$actionInfo = _$_UserStoreActionController.startAction(
        name: '_UserStore.setPassword');
    try {
      return super.setPassword(value);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setConfirmPassword(String value) {
    final _$actionInfo = _$_UserStoreActionController.startAction(
        name: '_UserStore.setConfirmPassword');
    try {
      return super.setConfirmPassword(value);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateUserEmail(String value) {
    final _$actionInfo = _$_UserStoreActionController.startAction(
        name: '_UserStore.validateUserEmail');
    try {
      return super.validateUserEmail(value);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateBirthday(DateTime? value) {
    final _$actionInfo = _$_UserStoreActionController.startAction(
        name: '_UserStore.validateBirthday');
    try {
      return super.validateBirthday(value);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateFirstName(String value) {
    final _$actionInfo = _$_UserStoreActionController.startAction(
        name: '_UserStore.validateFirstName');
    try {
      return super.validateFirstName(value);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateLastName(String value) {
    final _$actionInfo = _$_UserStoreActionController.startAction(
        name: '_UserStore.validateLastName');
    try {
      return super.validateLastName(value);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateGender(String value) {
    final _$actionInfo = _$_UserStoreActionController.startAction(
        name: '_UserStore.validateGender');
    try {
      return super.validateGender(value);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validatePhoneNumber(String value) {
    final _$actionInfo = _$_UserStoreActionController.startAction(
        name: '_UserStore.validatePhoneNumber');
    try {
      return super.validatePhoneNumber(value);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validatePassword(String value) {
    final _$actionInfo = _$_UserStoreActionController.startAction(
        name: '_UserStore.validatePassword');
    try {
      return super.validatePassword(value);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateOldPassword(String value) {
    final _$actionInfo = _$_UserStoreActionController.startAction(
        name: '_UserStore.validateOldPassword');
    try {
      return super.validateOldPassword(value);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateConfirmPassword(String value) {
    final _$actionInfo = _$_UserStoreActionController.startAction(
        name: '_UserStore.validateConfirmPassword');
    try {
      return super.validateConfirmPassword(value);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoggedIn: ${isLoggedIn},
isVerified: ${isVerified},
isPhoneVerified: ${isPhoneVerified},
isFirstTimeShowcase: ${isFirstTimeShowcase},
currentUserId: ${currentUserId},
profileImage: ${profileImage},
email: ${email},
firstName: ${firstName},
lastName: ${lastName},
gender: ${gender},
birthday: ${birthday},
phoneNumber: ${phoneNumber},
oldPassword: ${oldPassword},
password: ${password},
confirmPassword: ${confirmPassword},
success: ${success},
loading: ${loading},
loginFuture: ${loginFuture},
isLoading: ${isLoading},
canContinueRegister: ${canContinueRegister},
canChangePassword: ${canChangePassword}
    ''';
  }
}

mixin _$UserErrorStore on _UserErrorStore, Store {
  Computed<bool>? _$hasErrorContinueRegisterComputed;

  @override
  bool get hasErrorContinueRegister => (_$hasErrorContinueRegisterComputed ??=
          Computed<bool>(() => super.hasErrorContinueRegister,
              name: '_UserErrorStore.hasErrorContinueRegister'))
      .value;
  Computed<bool>? _$hasErrorChangePasswordComputed;

  @override
  bool get hasErrorChangePassword => (_$hasErrorChangePasswordComputed ??=
          Computed<bool>(() => super.hasErrorChangePassword,
              name: '_UserErrorStore.hasErrorChangePassword'))
      .value;

  late final _$emailAtom =
      Atom(name: '_UserErrorStore.email', context: context);

  @override
  String? get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String? value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  late final _$firstNameAtom =
      Atom(name: '_UserErrorStore.firstName', context: context);

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
      Atom(name: '_UserErrorStore.lastName', context: context);

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
      Atom(name: '_UserErrorStore.gender', context: context);

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
      Atom(name: '_UserErrorStore.birthday', context: context);

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

  late final _$phoneNumberAtom =
      Atom(name: '_UserErrorStore.phoneNumber', context: context);

  @override
  String? get phoneNumber {
    _$phoneNumberAtom.reportRead();
    return super.phoneNumber;
  }

  @override
  set phoneNumber(String? value) {
    _$phoneNumberAtom.reportWrite(value, super.phoneNumber, () {
      super.phoneNumber = value;
    });
  }

  late final _$passwordAtom =
      Atom(name: '_UserErrorStore.password', context: context);

  @override
  String? get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String? value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  late final _$oldPasswordAtom =
      Atom(name: '_UserErrorStore.oldPassword', context: context);

  @override
  String? get oldPassword {
    _$oldPasswordAtom.reportRead();
    return super.oldPassword;
  }

  @override
  set oldPassword(String? value) {
    _$oldPasswordAtom.reportWrite(value, super.oldPassword, () {
      super.oldPassword = value;
    });
  }

  late final _$confirmPasswordAtom =
      Atom(name: '_UserErrorStore.confirmPassword', context: context);

  @override
  String? get confirmPassword {
    _$confirmPasswordAtom.reportRead();
    return super.confirmPassword;
  }

  @override
  set confirmPassword(String? value) {
    _$confirmPasswordAtom.reportWrite(value, super.confirmPassword, () {
      super.confirmPassword = value;
    });
  }

  @override
  String toString() {
    return '''
email: ${email},
firstName: ${firstName},
lastName: ${lastName},
gender: ${gender},
birthday: ${birthday},
phoneNumber: ${phoneNumber},
password: ${password},
oldPassword: ${oldPassword},
confirmPassword: ${confirmPassword},
hasErrorContinueRegister: ${hasErrorContinueRegister},
hasErrorChangePassword: ${hasErrorChangePassword}
    ''';
  }
}
