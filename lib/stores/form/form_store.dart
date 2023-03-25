import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:grouu/data/network/exceptions/network_exceptions.dart';
import 'package:grouu/data/repository/auth_repository.dart';
import 'package:grouu/data/sqlite/db/database.dart';
import 'package:grouu/data/sqlite/service/user_service.dart';
import 'package:grouu/stores/error/error_store.dart';
import 'package:grouu/ui/login/create_password.dart';
import 'package:grouu/ui/login/success_create_password.dart';
import 'package:grouu/widgets/show_error_modal.dart';
import 'package:mobx/mobx.dart';
import 'package:validators/validators.dart';

import '../../data/repository/repository.dart';
import '../../ui/login/otp.dart';

part 'form_store.g.dart';

class FormStore = _FormStore with _$FormStore;

abstract class _FormStore with Store {
  final Repository _repository;
  final AuthRepository _authRepository;
  // store for handling form errors
  final FormErrorStore formErrorStore = FormErrorStore();

  // store for handling error messages
  final ErrorStore errorStore = ErrorStore();
  late UserService userservice;

  _FormStore(Repository repository, AuthRepository authRepository)
      : this._repository = repository,
        this._authRepository = authRepository {
    userservice = UserService();
    setupValidations();
  }

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void setupValidations() {
    _disposers = [
      reaction((_) => userEmail, validateUserEmail),
      reaction((_) => password, validatePassword),
      reaction((_) => confirmPassword, validateConfirmPassword),
      reaction((_) => otpNumber, validateOtpNumber)
    ];
  }

  // store variables:-----------------------------------------------------------
  @observable
  int currentUserId = 0;

  @observable
  String userEmail = '';

  @observable
  String password = '';

  @observable
  String confirmPassword = '';

  @observable
  String otpNumber = '';

  @observable
  bool success = false;

  @observable
  bool loading = false;

  static ObservableFuture emptyResponse = ObservableFuture.value(null);

  @observable
  ObservableFuture future = ObservableFuture(emptyResponse);

  @computed
  bool get loadingFuture => future.status == FutureStatus.pending;

  BuildContext? rootLoginContext;

  @computed
  bool get canLogin =>
      !formErrorStore.hasErrorsInLogin &&
      userEmail.isNotEmpty &&
      password.isNotEmpty;

  @computed
  bool get canRegister =>
      !formErrorStore.hasErrorsInRegister &&
      userEmail.isNotEmpty &&
      password.isNotEmpty;

  @computed
  bool get canForgetPassword =>
      !formErrorStore.hasErrorInForgotPassword && userEmail.isNotEmpty;

  @computed
  bool get canOtp =>
      !formErrorStore.hasErrorInOtp &&
      otpNumber.isNotEmpty &&
      otpNumber.length == 6;

  @computed
  bool get canCreatePassword {
    final _minLength = 8;
    if (password.isEmpty) {
      return false;
    }

    bool hasUppercase = password.contains(new RegExp(r'[A-Z]'));
    bool hasDigits = password.contains(new RegExp(r'[0-9]'));
    bool hasLowercase = password.contains(new RegExp(r'[a-z]'));
    bool hasSpecialCharacters =
        password.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    bool hasMinLength = password.length >= _minLength;

    return hasDigits &
        hasUppercase &
        hasLowercase &
        hasSpecialCharacters &
        hasMinLength;
  }

  // actions:-------------------------------------------------------------------

  void setLoginContext(BuildContext loginContext) {
    rootLoginContext = loginContext;
  }

  @action
  void setUserId(String value) {
    userEmail = value;
  }

  @action
  void setPassword(String value) {
    password = value;
  }

  @action
  void setConfirmPassword(String value) {
    confirmPassword = value;
  }

  @action
  void setOtp(String value) {
    otpNumber = value;
  }

  @action
  void validateUserEmail(String value) {
    if (value.isEmpty) {
      formErrorStore.userEmail = "Email can't be empty";
    } else if (!isEmail(value)) {
      formErrorStore.userEmail = 'Please enter a valid email address';
    } else {
      formErrorStore.userEmail = null;
    }
  }

  @action
  void validatePassword(String value) {
    if (value.isEmpty) {
      formErrorStore.password = "Password can't be empty";
    } else if (value.length < 8) {
      formErrorStore.password = "Password must be at-least 8 characters long";
    } else {
      formErrorStore.password = null;
    }
  }

  @action
  void validateConfirmPassword(String value) {
    if (value.isEmpty) {
      formErrorStore.confirmPassword = "Confirm password can't be empty";
    } else if (value != password) {
      formErrorStore.confirmPassword = "Password doesn't match";
    } else {
      formErrorStore.confirmPassword = null;
    }
  }

  @action
  validateOtpNumber(String value) {
    if (value.isEmpty) {
      formErrorStore.otpNumber = "OTP number can't be empty";
    } else if (value.length < 4) {
      formErrorStore.otpNumber = "OTP must be at least 4 number";
    } else {
      formErrorStore.otpNumber = null;
    }
  }

  @action
  Future register() async {
    loading = true;
    try {
      await _authRepository.postRegister(userEmail, password);
      User user = await userservice.register(userEmail, password);
      await _authRepository.postVerifyEmail(userEmail);
      await login();
      currentUserId = user.id;
    } catch (e) {
      errorStore.errorMessage = e.toString().contains("UNIQUE")
          ? "User already exists"
          : e.toString();
      loading = false;
      success = false;
      print(e);
    }
  }

  @action
  Future login() async {
    formErrorStore.errorMessage = null;
    final email = userEmail;
    final pass = password;
    final response = _authRepository.postLogin(email, pass);
    future = ObservableFuture(response);

    response.then((value) async {
      User user = await userservice.login(email, pass);
      currentUserId = user.id;
      await _repository.saveCurrentUserId(currentUserId);
      await _repository.saveIsLoggedIn(true);
      success = true;
    }).catchError((e) {
      if (e.toString().contains("No element")) {
        final user = userservice.register(userEmail, password);
        future = ObservableFuture(user);
        user.then((value) {
          currentUserId = value.id;
          final save = _repository.saveCurrentUserId(currentUserId);
          future = ObservableFuture(save);
          save.then((value) {
            final saveIsLoggedIn = _repository.saveIsLoggedIn(true);
            future = ObservableFuture(saveIsLoggedIn);
            saveIsLoggedIn.then((value) {
              success = true;
              return;
            });
          });
        });
      } else {
        success = false;
        formErrorStore.errorMessage = e
                .toString()
                .contains("Invalid email or password")
            ? "Username and password doesn't match"
            : "Something went wrong, please check your internet connection and try again";
        errorStore.errorMessage = e
                .toString()
                .contains("Invalid email or password")
            ? "Username and password doesn't match"
            : "Something went wrong, please check your internet connection and try again";
        print(e);
      }
    });
  }

  @action
  Future forgotPassword(BuildContext context, bool isResent) async {
    final response = _authRepository.postForgotPassword(userEmail);
    future = ObservableFuture(response);
    response.then((value) async {
      int id = await userservice.getIdByEmail(userEmail);
      currentUserId = id;
      if (!isResent) {
        Navigator.of(context)
            .push(CupertinoPageRoute(builder: (context) => OtpScreen()));
      }
    }).catchError((e) {
      if (e is BadRequestException) {
        showErrorModal(context, "Email Error", e.model.data);
      } else {
        showErrorModal(context, "Email Error", e.toString());
      }
      print(e);
    });
  }

  @action
  Future submitOtp(BuildContext context) async {
    final response = _authRepository.postForgotOtp(otpNumber);
    future = ObservableFuture(response);
    response.then((value) {
      if (value) {
        Navigator.of(context).push(
            CupertinoPageRoute(builder: (context) => CreatePasswordScreen()));
      } else {
        return throw Future.error("ERROR_INVALID_OTP");
      }
    }).catchError((e) {
      if (e is BadRequestException) {
        showErrorModal(context, "OTP Error", e.model.data);
      } else {
        showErrorModal(context, "OTP Error", e.toString());
      }
      print(e);
    });
  }

  @action
  Future createPassword(BuildContext context) async {
    if (canCreatePassword) {
      final response = _authRepository.postUpdatePassword(userEmail, password);
      future = ObservableFuture(response);
      response.then((value) async {
        if (value) {
          await userservice.updatePassword(currentUserId, password);
          await Navigator.of(context).push(CupertinoPageRoute(
              builder: (context) => SuccessCreatePassScreen()));
        } else {
          return Future.error("ERROR_NETWORK_CREATE_PASSWORD");
        }
      }).catchError((e) {
        errorStore.errorMessage = e
                .toString()
                .contains("ERROR_INVALID_CREATE_PASSWORD")
            ? tr('create_password_error_verification_desc')
            : "Something went wrong, please check your internet connection and try again";
        print(e);
      });
    } else {
      return Future.error("ERROR_INVALID_CREATE_PASSWORD");
    }
  }

  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
    disposeLoginField();
  }

  void disposeOtp() {
    otpNumber = '';
  }

  void disposeLoginField() {
    userEmail = "";
    password = "";
    formErrorStore.userEmail = null;
    formErrorStore.password = null;
    success = false;
  }

  void validateAll() {
    validatePassword(password);
    validateUserEmail(userEmail);
  }

  void dismissForgotPassModal() {
    userEmail = '';
    password = '';
    confirmPassword = '';
    Navigator.of(rootLoginContext!).pop();
  }
}

class FormErrorStore = _FormErrorStore with _$FormErrorStore;

abstract class _FormErrorStore with Store {
  @observable
  String? userEmail;

  @observable
  String? password;

  @observable
  String? confirmPassword;

  @observable
  String? otpNumber;

  @observable
  String? errorMessage;

  @computed
  bool get hasErrorsInLogin => userEmail != null || password != null;

  @computed
  bool get hasErrorsInRegister => userEmail != null || password != null;

  @computed
  bool get hasErrorInForgotPassword => userEmail != null;

  @computed
  bool get hasErrorsInCreatePassword =>
      password != null || confirmPassword != null;

  @computed
  bool get hasErrorInOtp => otpNumber != null;
}
