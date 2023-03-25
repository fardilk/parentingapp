import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:grouu/data/local/constants/data_constants.dart';
import 'package:grouu/di/components/service_locator.dart';
import 'package:grouu/stores/user/user_store.dart';
import 'package:grouu/ui/register/styles/register_styles.dart';
import 'package:grouu/ui/register/widgets/app_bar_register.dart';
import 'package:grouu/ui/register/widgets/register_bg.dart';
import 'package:grouu/ui/register/widgets/register_content_container.dart';
import 'package:grouu/utils/routes/routes.dart';
import 'package:grouu/utils/ui/color.dart';
import 'package:grouu/widgets/progress_indicator_widget.dart';
import 'package:grouu/widgets/role_container.dart';
import 'package:grouu/widgets/rounded_button_widget.dart';
import 'package:grouu/widgets/textfield_widget.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';

import '../../../widgets/show_error_modal.dart';

class ParentsInfo extends StatefulWidget {
  ParentsInfo({Key? key}) : super(key: key);

  @override
  State<ParentsInfo> createState() => _ParentsInfoState();
}

class _ParentsInfoState extends State<ParentsInfo> {
  TextEditingController _firstNameController = TextEditingController();

  TextEditingController _lastNameController = TextEditingController();

  TextEditingController _birthdayController = TextEditingController();

  UserStore _store = getIt<UserStore>();

  late FocusNode _lastNameFocusNode;

  @override
  void initState() {
    super.initState();
    _store.checkLogin();
    _store.reinitDisposer();
    _lastNameFocusNode = FocusNode();
    _firstNameController.text = _store.firstName;
    _lastNameController.text = _store.lastName;
    if (_store.birthday != null) {
      _birthdayController.text =
          DateFormat("d MMMM yyyy").format(_store.birthday!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: HexColor.fromHex("#FFFFFF"),
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: Stack(
                children: <Widget>[
                  RegisterGradientBackground(),
                  RegisterContentContainer(
                    appBar: AppBarRegister(onSkip: () => onSkip()),
                    child: _buildRegisterContent(),
                  ),
                  Observer(
                    builder: (context) {
                      return _store.success
                          ? navigate(context)
                          : _showErrorMessage(_store.errorStore.errorMessage);
                    },
                  ),
                  Observer(
                    builder: (context) {
                      return Visibility(
                          visible: _store.loading,
                          child: CustomProgressIndicatorWidget());
                    },
                  )
                ],
              ),
            ),
            _buildContinueButton(),
          ],
        ),
      ),
    );
  }

  Column _buildRegisterContent() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildRegisterHeader(),
        Row(
          children: [
            Expanded(child: _buildFirstNameField()),
            SizedBox(width: 12),
            Expanded(child: _buildLastNameField()),
          ],
        ),
        _buildDatePickerField(),
        _buildRolePicker()
      ],
    );
  }

  Column _buildRegisterHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 25.0),
        Text("Step 1 of 4", style: RegisterStyles.textSmall),
        Text("Parents Info", style: RegisterStyles.title),
        SizedBox(height: 5.0),
        Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod ",
            style: RegisterStyles.textMedium),
      ],
    );
  }

  Widget _buildRolePicker() {
    return Observer(builder: (context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 8),
            child: Text("Peran", style: RegisterStyles.textSmall),
          ),
          Row(
            children: [
              Expanded(
                child: RoleContainer(
                  active: _store.gender == DataConstants.MALE,
                  onPress: () async {
                    setState(() => _store.setGender(DataConstants.MALE));
                  },
                  image: Image.asset("assets/icons/icon_papa.png"),
                  text: "Ayah",
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: RoleContainer(
                  active: _store.gender == DataConstants.FEMALE,
                  onPress: () async {
                    setState(() => _store.gender = DataConstants.FEMALE);
                  },
                  image: Image.asset("assets/icons/icon_mama.png"),
                  text: "Ibu",
                ),
              )
            ],
          ),
        ],
      );
    });
  }

  Widget _buildFirstNameField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          isIcon: false,
          hint: "Nama Depan",
          hintColor: HexColor.fromHex("#7B7B7B"),
          inputType: TextInputType.name,
          padding: EdgeInsets.only(top: 16.0),
          inputAction: TextInputAction.next,
          textController: _firstNameController,
          errorText: _store.userErrorStore.firstName,
          onChanged: (value) {
            _store.setFirstName(_firstNameController.text);
          },
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(_lastNameFocusNode);
          },
        );
      },
    );
  }

  Widget _buildLastNameField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          isIcon: false,
          hint: "Nama Belakang",
          focusNode: _lastNameFocusNode,
          hintColor: HexColor.fromHex("#7B7B7B"),
          inputType: TextInputType.emailAddress,
          padding: EdgeInsets.only(top: 16.0),
          inputAction: TextInputAction.next,
          textController: _lastNameController,
          errorText: _store.userErrorStore.lastName,
          onChanged: (value) {
            _store.setLastName(_lastNameController.text);
          },
        );
      },
    );
  }

  Widget _buildDatePickerField() {
    return Observer(
      builder: (context) {
        return GestureDetector(
          onTap: () {
            showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            ).then((value) {
              if (value != null) {
                _store.setBirthday(value);
                _birthdayController.text =
                    DateFormat("d MMMM yyyy").format(value);
              }
            });
          },
          child: TextFieldWidget(
            hint: "Tanggal Lahir",
            hintColor: HexColor.fromHex("#7B7B7B"),
            icon: IconlyBold.calendar,
            enabled: false,
            inputType: TextInputType.phone,
            padding: EdgeInsets.only(top: 16.0),
            inputAction: TextInputAction.next,
            onFieldSubmitted: (value) {
              // FocusScope.of(context).requestFocus(_passwordFocusNode);
            },
            errorText: _store.userErrorStore.birthday,
            textController: _birthdayController,
          ),
        );
      },
    );
  }

  Widget _buildContinueButton() {
    return Observer(builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: RoundedButtonWidget(
          isLoading: _store.loading,
          buttonText: "Selanjutnya",
          onPressed: () async {
            if (_store.canContinueRegister) {
              _store.updateContinueRegister();
            } else {
              _showErrorMessage("Harap lengkapi data");
            }
          },
        ),
      );
    });
  }

  Widget navigate(BuildContext context) {
    Future.delayed(Duration(milliseconds: 0), () {
      Navigator.of(context).pushReplacementNamed(Routes.register_child_info);
    });
    _store.dispose();
    return Container();
  }

  void onSkip() {
    Navigator.of(context).pushNamed(Routes.register_child_info);
  }

  // General Methods:-----------------------------------------------------------
  _showErrorMessage(String message) {
    if (message.isNotEmpty) {
      Future.delayed(Duration(milliseconds: 0), () {
        showErrorModal(context, "Error", message);
      });
    }

    return SizedBox.shrink();
  }
}
