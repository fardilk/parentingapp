import 'dart:typed_data';

import 'package:grouu/data/repository/auth_repository.dart';
import 'package:grouu/data/sqlite/db/database.dart';
import 'package:grouu/data/sqlite/service/user_service.dart';
import 'package:grouu/stores/error/error_store.dart';
import 'package:mobx/mobx.dart';
import 'package:validators/validators.dart';

import '../../data/repository/repository.dart';

part 'user_store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  // repository instance
  final Repository _repository;
  final AuthRepository _authRepository;

  // store for handling form errors
  final UserErrorStore userErrorStore = UserErrorStore();

  // store for handling error messages
  final ErrorStore errorStore = ErrorStore();

  // bool to check if current user is logged in
  @observable
  bool isLoggedIn = false;

  @observable
  bool isVerified = false;

  @observable
  bool isPhoneVerified = false;

  @observable
  bool isFirstTimeShowcase = true;
  late UserService userservice;
  late User currentUser;

  // constructor:---------------------------------------------------------------
  _UserStore(Repository repository, AuthRepository authRepository)
      : this._repository = repository,
        this._authRepository = authRepository {
    // setting up disposers
    userservice = UserService();
    _setupDisposers();

    // checking if user is logged in
    checkLogin();
  }

  Future<void> checkLogin() async {
    loading = true;
    await _repository.isLoggedIn.then((value) async {
      this.isLoggedIn = value;

      print(value);

      if (value) {
        var userId = await _repository.currentUserId;
        var user = await userservice.getUser(userId);
        print(user);
        currentUser = user;
        currentUserId = user.id;
        email = user.email;
        phoneNumber = user.phoneNumber ?? "";
        firstName = user.firstName ?? "";
        lastName = user.lastName ?? "";
        profileImage = user.image;
        gender = user.gender ?? "";
        birthday = user.birthday;
        isVerified = user.isVerified;
        isPhoneVerified = user.isPhoneVerified;
      }
    });
    await _repository.isFirstTimeShowcase.then((value) {
      this.isFirstTimeShowcase = value;
    });
    loading = false;
  }

  showcaseCompleted() {
    isFirstTimeShowcase = false;
    _repository.saveFirstTimeShowcase(false);
  }

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void _setupDisposers() {
    _disposers = [
      reaction((_) => success, (_) => success = false, delay: 200),
      reaction((_) => email, validateUserEmail),
      reaction((_) => phoneNumber, validatePhoneNumber),
      reaction((_) => password, validatePassword),
      reaction((_) => oldPassword, validateOldPassword),
      reaction((_) => confirmPassword, validateConfirmPassword),
      reaction((_) => gender, validateGender),
      reaction((_) => firstName, validateFirstName),
      reaction((_) => lastName, validateLastName),
      reaction((_) => birthday, validateBirthday)
    ];
  }

  // empty responses:-----------------------------------------------------------
  static ObservableFuture<bool> emptyLoginResponse =
      ObservableFuture.value(false);

  // store variables:-----------------------------------------------------------
  @observable
  int currentUserId = 0;

  @observable
  Uint8List? profileImage;

  @action
  void setProfileImage(Uint8List value) {
    profileImage = value;
  }

  @observable
  String email = '';

  @action
  void setEmail(String value) {
    email = value;
  }

  @observable
  String firstName = '';

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

  @observable
  String phoneNumber = '';

  @action
  void setPhoneNumber(String value) {
    phoneNumber = value;
  }

  @observable
  String oldPassword = '';

  @action
  void setOldPassword(String value) {
    oldPassword = value;
  }

  @observable
  String password = '';

  @action
  void setPassword(String value) {
    password = value;
  }

  @observable
  String confirmPassword = '';

  @action
  void setConfirmPassword(String value) {
    confirmPassword = value;
  }

  @observable
  bool success = false;

  @observable
  bool loading = false;

  @observable
  ObservableFuture<bool> loginFuture = emptyLoginResponse;

  @computed
  bool get isLoading => loginFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------

  @action
  void validateUserEmail(String value) {
    if (value.isEmpty) {
      userErrorStore.email = "Email can't be empty";
    } else if (!isEmail(value)) {
      userErrorStore.email = 'Please enter a valid email address';
    } else {
      userErrorStore.email = null;
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
  void validatePhoneNumber(String value) {
    if (value.isEmpty) {
      userErrorStore.phoneNumber = "Phone number can't be empty";
    } else if (!isNumeric(value)) {
      userErrorStore.phoneNumber = 'Please enter a valid phone number';
    } else {
      userErrorStore.phoneNumber = null;
    }
  }

  @action
  void validatePassword(String value) {
    if (value.isEmpty) {
      userErrorStore.password = "Password can't be empty";
    } else if (value.length < 8) {
      userErrorStore.password = "Password must be at-least 8 characters long";
    } else {
      userErrorStore.password = null;
    }
  }

  @action
  void validateOldPassword(String value) {
    if (value.isEmpty) {
      userErrorStore.oldPassword = "Password can't be empty";
    } else if (value.length < 8) {
      userErrorStore.oldPassword =
          "Password must be at-least 8 characters long";
    } else {
      userErrorStore.oldPassword = null;
    }
  }

  @action
  void validateConfirmPassword(String value) {
    if (value.isEmpty) {
      userErrorStore.confirmPassword = "Confirm password can't be empty";
    } else if (value != password) {
      userErrorStore.confirmPassword = "Password doesn't match";
    } else {
      userErrorStore.confirmPassword = null;
    }
  }

  @computed
  bool get canContinueRegister =>
      !userErrorStore.hasErrorContinueRegister &&
      gender.isNotEmpty &&
      firstName.isNotEmpty &&
      lastName.isNotEmpty &&
      birthday != null;

  @computed
  bool get canChangePassword =>
      !userErrorStore.hasErrorContinueRegister &&
      password.isNotEmpty &&
      oldPassword.isNotEmpty &&
      confirmPassword.isNotEmpty;

  @action
  Future updateContinueRegister() async {
    loading = true;
    try {
      int result = await userservice.updateUser(
          id: currentUserId,
          email: email,
          phoneNumber: phoneNumber,
          birthday: birthday,
          firstName: firstName,
          lastName: lastName,
          gender: gender,
          image: profileImage);
      loading = false;
      success = true;
      print(result);
    } catch (e) {
      errorStore.errorMessage = "Something went wrong";
      loading = false;
      success = false;
      print(e);
    }
  }

  @action
  Future verifyEmail(String otp) async {
    try {
      bool verified = await _authRepository.postVerifyOtp(otp);
      if (verified) {
        await userservice.verifyEmail(id: currentUserId);
      }
      return verified;
    } catch (e) {
      errorStore.errorMessage = "Something went wrong";
      return false;
    }
  }

  @action
  Future sendVerificationEmail() async {
    loading = true;
    try {
      await _authRepository.postVerifyEmail(email);
      loading = false;
    } catch (e) {
      errorStore.errorMessage = "Something went wrong";
      loading = false;
    }
  }

  @action
  Future verifyPhone() async {
    try {
      await userservice.verifyPhone(id: currentUserId);
    } catch (e) {
      errorStore.errorMessage = "Something went wrong";
    }
  }

  @action
  Future deleteAccount() async {
    loading = true;
    try {
      int result = await userservice.deleteUser(currentUserId);
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

  @action
  Future login(String email, String password) async {
    final future = _repository.login(email, password);
    loginFuture = ObservableFuture(future);
    await future.then((value) async {
      if (value) {
        _repository.saveIsLoggedIn(true);
        this.isLoggedIn = true;
        this.success = true;
      } else {
        print('failed to login');
      }
    }).catchError((e) {
      print(e);
      this.isLoggedIn = false;
      this.success = false;
      throw e;
    });
  }

  @action
  Future changePassword() async {
    try {
      await userservice.login(email, oldPassword);
      final response =
          await _authRepository.postUpdatePassword(email, password);

      await userservice.updatePassword(currentUserId, password);
      loading = false;
      success = true;
    } catch (e) {
      errorStore.errorMessage = e.toString().contains("No element")
          ? "Password doesn't match"
          : e.toString();
      loading = false;
      success = false;
      print(e);
    }
  }

  logout() {
    this.isLoggedIn = false;
    this.isVerified = false;
    this.isPhoneVerified = false;
    _repository.removeAllData();
    currentUserId = 0;
    email = "";
    phoneNumber = "";
    firstName = "";
    lastName = "";
    profileImage = null;
    gender = "";
    birthday = null;
  }

  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
    userErrorStore.email = null;
    userErrorStore.phoneNumber = null;
    userErrorStore.firstName = null;
    userErrorStore.lastName = null;
    userErrorStore.birthday = null;
    userErrorStore.gender = null;

    success = false;
    loading = false;
  }

  void reinitDisposer() {
    this.dispose();
    this._setupDisposers();
  }

  void clearPasswordInput() {
    password = "";
    oldPassword = "";
    confirmPassword = "";
  }
}

class UserErrorStore = _UserErrorStore with _$UserErrorStore;

abstract class _UserErrorStore with Store {
  @observable
  String? email;

  @observable
  String? firstName;

  @observable
  String? lastName;

  @observable
  String? gender;

  @observable
  String? birthday;

  @observable
  String? phoneNumber;

  @observable
  String? password;

  @observable
  String? oldPassword;

  @observable
  String? confirmPassword;

  @computed
  bool get hasErrorContinueRegister =>
      firstName != null ||
      lastName != null ||
      gender != null ||
      birthday != null;

  @computed
  bool get hasErrorChangePassword =>
      oldPassword != null || password != null || confirmPassword != null;
}
