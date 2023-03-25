import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:grouu/data/local/constants/data_constants.dart';
import 'package:grouu/di/components/service_locator.dart';
import 'package:grouu/stores/user/user_store.dart';
import 'package:grouu/ui/profile/styles/profile_styles.dart';
import 'package:grouu/ui/register/styles/register_styles.dart';
import 'package:grouu/utils/locale/wording_utils.dart';
import 'package:grouu/utils/ui/color.dart';
import 'package:grouu/widgets/back_appbar_widget.dart';
import 'package:grouu/widgets/progress_indicator_widget.dart';
import 'package:grouu/widgets/role_container.dart';
import 'package:grouu/widgets/rounded_button_widget.dart';
import 'package:grouu/widgets/show_success_modal.dart';
import 'package:grouu/widgets/textfield_widget.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';

import '../../widgets/show_error_modal.dart';

class AccountInfo extends StatefulWidget {
  const AccountInfo({super.key});

  @override
  State<AccountInfo> createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  UserStore _store = getIt<UserStore>();

  TextEditingController _emailController = TextEditingController();

  TextEditingController _phoneController = TextEditingController();

  TextEditingController _firstNameController = TextEditingController();

  TextEditingController _lastNameController = TextEditingController();

  TextEditingController _birthdayController = TextEditingController();

  FocusNode _phoneNumberFocusNode = FocusNode();
  FocusNode _firstNameFocusNode = FocusNode();
  FocusNode _lastNameFocusNode = FocusNode();

  ImagePicker _picker = ImagePicker();

  void _pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
      );
      Uint8List? pickedImage = await pickedFile?.readAsBytes();
      if (pickedImage != null) {
        _store.setProfileImage(pickedImage);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _lastNameFocusNode = FocusNode();
    _store.checkLogin();
    _store.reinitDisposer();
    _firstNameController.text = _store.firstName;
    _lastNameController.text = _store.lastName;
    _emailController.text = _store.email;
    _phoneController.text = _store.phoneNumber;

    if (_store.birthday != null) {
      _birthdayController.text =
          DateFormat("d MMMM yyyy").format(_store.birthday!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop(true);
        _store.dispose();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: BackAppBar(title: Text("Account Info")),
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildContentScroll(children: [
                  _buildImagePicker(),
                  SizedBox(height: 8),
                  Text("Account Info", style: ProfileStyles.sectionTitle),
                  _buildEmailFeld(),
                  _buildPhoneNumberField(),
                  SizedBox(height: 16),
                  Text("Parent Info", style: ProfileStyles.sectionTitle),
                  Row(
                    children: [
                      Expanded(child: _buildFirstNameField()),
                      SizedBox(width: 12),
                      Expanded(child: _buildLastNameField()),
                    ],
                  ),
                  _buildDatePickerField(),
                  _buildRolePicker(),
                  SizedBox(height: 16),
                  _buildSaveButton(),
                ]),
              ],
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
    );
  }

  Widget _buildSaveButton() {
    return Observer(builder: (context) {
      return RoundedButtonWidget(
        buttonText: "Simpan",
        onPressed: () async {
          if (_store.canContinueRegister) {
            _store.updateContinueRegister();
          } else {
            _showErrorMessage("Harap lengkapi data");
          }
        },
      );
    });
  }

  Observer _buildProfileImage() {
    return Observer(builder: (context) {
      return CircleAvatar(
        backgroundColor: Color(0xffB4D1C4),
        radius: 32,
        backgroundImage: _store.profileImage != null
            ? MemoryImage(_store.profileImage!) as ImageProvider
            : _store.gender == DataConstants.MALE
                ? AssetImage("assets/icons/icon_papa.png")
                : _store.gender == DataConstants.FEMALE
                    ? AssetImage("assets/icons/icon_mama.png")
                    : AssetImage("assets/images/profile.png"),
      );
    });
  }

  Center _buildImagePicker() {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
              radius: 36,
              backgroundColor: Color(0xfff6f6f6),
              child: _buildProfileImage()),
          Positioned(
            bottom: -5,
            left: 36,
            child: ElevatedButton(
              onPressed: () async => _pickImage(),
              child: Icon(IconlyLight.camera, color: Colors.white),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(24, 24),
                shape: CircleBorder(),
              ),
            ),
          )
        ],
      ),
    );
  }

  Expanded _buildContentScroll({required List<Widget> children}) {
    return Expanded(
      flex: 1,
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildRoundedTop(),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: children,
              ),
            )
          ],
        ),
      ),
    );
  }

  Stack _buildRoundedTop() {
    return Stack(
      children: [
        Container(height: 16, color: Color(0xff7AD0E2)),
        Container(
          height: 16,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(16), topLeft: Radius.circular(16)),
          ),
        )
      ],
    );
  }

  Widget _buildEmailFeld() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          isIcon: false,
          hint: tr('login_et_user_email'),
          hintColor: HexColor.fromHex("#7B7B7B"),
          inputType: TextInputType.emailAddress,
          padding: EdgeInsets.only(top: 16.0),
          inputAction: TextInputAction.next,
          onChanged: (value) {
            _store.setEmail(_emailController.text);
          },
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(_phoneNumberFocusNode);
          },
          errorText: _store.userErrorStore.email,
          textController: _emailController,
          suffixWidget: !_store.isVerified
              ? TextButton(onPressed: () {}, child: Text("Verify Me"))
              : Icon(
                  Icons.verified_sharp,
                  color: Color(0xff00A5C3),
                ),
        );
      },
    );
  }

  Widget _buildPhoneNumberField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          isIcon: false,
          hint: "No. Handphone",
          hintColor: HexColor.fromHex("#7B7B7B"),
          inputType: TextInputType.phone,
          padding: EdgeInsets.only(top: 16.0),
          inputAction: TextInputAction.next,
          focusNode: _phoneNumberFocusNode,
          onChanged: (value) {
            _store.setPhoneNumber(_phoneController.text);
          },
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(_firstNameFocusNode);
          },
          errorText: _store.userErrorStore.phoneNumber,
          textController: _phoneController,
          // suffixWidget: !_store.isPhoneVerified
          //     ? TextButton(onPressed: () {}, child: Text("Verify Me"))
          //     : Icon(
          //         Icons.verified_sharp,
          //         color: Color(0xff00A5C3),
          //       ),
        );
      },
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
          focusNode: _firstNameFocusNode,
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

  Widget navigate(BuildContext context) {
    Future.delayed(Duration(milliseconds: 0), () {
      showSuccessModal(
        context,
        tr("dialog_success"),
        tr("dialog_success_profile",
            args: [WordingUtils.genderGreeting(_store.gender)]),
      ).then((value) {
        Navigator.of(context).pop(true);
        _store.dispose();
      });
    });
    return Container();
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
