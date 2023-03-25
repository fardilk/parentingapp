import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:grouu/constants/font_family.dart';
import 'package:grouu/data/local/constants/data_constants.dart';
import 'package:grouu/data/sqlite/db/database.dart';
import 'package:grouu/di/components/service_locator.dart';
import 'package:grouu/stores/children/children_store.dart';
import 'package:grouu/stores/growth/growth_store.dart';
import 'package:grouu/stores/preference/preference_store.dart';
import 'package:grouu/stores/user/user_store.dart';
import 'package:grouu/ui/profile/styles/profile_styles.dart';
import 'package:grouu/ui/profile/widgets/child_item_widget.dart';
import 'package:grouu/ui/profile/widgets/profile_logout_widget.dart';
import 'package:grouu/ui/profile/widgets/profile_menu_button.dart';
import 'package:grouu/ui/register/widgets/otp_failed.dart';
import 'package:grouu/ui/register/widgets/otp_register_screen.dart';
import 'package:grouu/ui/register/widgets/otp_success.dart';
import 'package:grouu/utils/routes/routes.dart';
import 'package:grouu/widgets/error_message_widget.dart';
import 'package:grouu/widgets/outline_rounded_button_widget.dart';
import 'package:grouu/widgets/rounded_button_widget.dart';
import 'package:grouu/widgets/show_error_modal.dart';
import 'package:grouu/widgets/title_appbar_widget.dart';
import 'package:iconly/iconly.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:unicons/unicons.dart';

import '../../constants/account_progression_constants.dart';
import '../articles/articles_detail.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class ProfileMenu {
  ProfileMenu({required this.icon, required this.title, required this.onPress});
  final IconData icon;
  final String title;
  final Function onPress;
}

class _ProfileState extends State<Profile> {
  final UserStore _userStore = getIt<UserStore>();
  final ChildrenStore _childrenStore = getIt<ChildrenStore>();
  final PreferenceStore _preferenceStore = getIt<PreferenceStore>();
  final GrowthStore _growthStore = getIt<GrowthStore>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // check to see if already called api
    if (!_childrenStore.loading) {
      _childrenStore.getChildrensByUser();
    }

    if (!_preferenceStore.loading) {
      _preferenceStore.getPreferenceByUser();
    }

    if (!_growthStore.loading) {
      _growthStore.getGrowthsByUser();
    }
  }

  List<ProfileMenu> listMenu(BuildContext context) => [
        ProfileMenu(
          icon: IconlyLight.filter,
          onPress: () async {
            _navigateToEditPref(context);
          },
          title: "Preference",
        ),
        ProfileMenu(
          icon: IconlyLight.profile,
          onPress: () {
            _showAccountModal(context);
          },
          title: "Manage Account",
        ),
        ProfileMenu(
          icon: UniconsLine.mobile_android,
          onPress: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ArticlesDetail(
                  slug: "",
                  detailType: DetailType.AboutUs,
                ),
              ),
            );
          },
          title: "About Us",
        ),
        ProfileMenu(
            icon: UniconsLine.question_circle,
            onPress: () {
              Navigator.of(context).pushNamed(Routes.help_support);
            },
            title: "Help & Support"),
        ProfileMenu(
            icon: UniconsLine.file_shield_alt,
            onPress: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ArticlesDetail(
                    slug: "",
                    detailType: DetailType.PrivacyPolicy,
                  ),
                ),
              );
            },
            title: "Privacy Policy"),
        ProfileMenu(
            icon: UniconsLine.file_alt,
            onPress: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ArticlesDetail(
                    slug: "",
                    detailType: DetailType.TermsCondition,
                  ),
                ),
              );
            },
            title: "Terms of Use"),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEFBFE),
      appBar: TitleAppBar(title: "Profile"),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildProfileHeader(),
            _buildRegistrationProgress(),
            _buildEditProfileButton(),
            ColoredBox(color: Colors.white, child: SizedBox(height: 8)),
            _buildChildInfo(),
            _buildProfileMenu(),
            _buildLogoutButton(),
          ],
        ),
      ),
    );
  }

  Padding _buildEditProfileButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: OutlineRoundedButtonWidget(
        buttonText: "Edit Profile",
        onPressed: () async => _navigateToEditProfile(context),
      ),
    );
  }

  Widget _buildChildInfo() {
    return Observer(builder: (context) {
      List<Children> childrens =
          _childrenStore.childrens?.map((e) => e as Children).toList() ?? [];
      return Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Child Info", style: ProfileStyles.sectionTitle),
            childrens.isEmpty
                ? _buildDontHaveChild()
                : Column(
                    children: childrens.map((c) {
                      return ChildItemWidget(
                        childName: "${c.firstName} ${c.lastName}",
                        onTap: () async {
                          _navigateToEditChild(context, c);
                        },
                        birthday: c.birthday,
                        gender: c.gender,
                        image: c.image,
                      );
                    }).toList(),
                  ),
            OutlineRoundedButtonWidget(
              buttonText: "Add New Child",
              onPressed: () async {
                _navigateToAddChild(context);
              },
            )
          ],
        ),
      );
    });
  }

  Padding _buildDontHaveChild() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 36,
            backgroundColor: Color(0xfff6f6f6),
            child: CircleAvatar(
              radius: 32,
              backgroundColor: Color(0xffAEE3EE),
              backgroundImage: AssetImage("assets/images/baby_boy_profile.png"),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr("profile_unregistered_child_title"),
                    style: TextStyle(
                      fontFamily: FontFamily.avenirLTStd,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    tr("profile_unregistered_child_subtitle"),
                    style: ProfileStyles.textSmall,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  ColoredBox _buildProfileMenu() {
    return ColoredBox(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: listMenu(context).map((menu) {
            return ProfileMenuButton(
              icon: menu.icon,
              onPress: menu.onPress,
              title: menu.title,
            );
          }).toList(),
        ),
      ),
    );
  }

  Padding _buildLogoutButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: RoundedButtonWidget(
        buttonText: "Logout",
        onPressed: () {
          _showLogoutModal(context);
        },
        buttonColor: Color(0xffDE004F),
      ),
    );
  }

  Widget _buildRegistrationProgress() {
    return Observer(builder: (context) {
      AccountProgression progress = _getRegistrationProgress();
      return progress == AccountProgression.Completed
          ? Container()
          : Padding(
              padding: EdgeInsets.all(16),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffFFEE9B)),
                  color: Color(0xffffFFF5C3),
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 4),
                    Text(
                      progress.title,
                      style: ProfileStyles.textMedium,
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: LinearProgressIndicator(
                              value: progress.index /
                                  (AccountProgression.values.length - 1)),
                        ),
                        Expanded(
                            child: Center(
                                child: Text(
                                    "${progress.index} out of ${AccountProgression.values.length - 1} steps",
                                    style: ProfileStyles.textSmall)))
                      ],
                    ),
                  ],
                ),
              ),
            );
    });
  }

  Stack _buildProfileHeader() {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        ColoredBox(
          color: Color(0xff7AD0E2),
          child: SizedBox(
            height: 100,
            width: double.infinity,
          ),
        ),
        Column(
          children: [
            SizedBox(height: 36),
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: Color(0xffEEFBFE),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(40)),
              ),
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 36,
              backgroundColor: Color(0xfff6f6f6),
              child: _buildProfileImage(),
            ),
            SizedBox(height: 12),
            _buildUserNameOrEmail(),
            SizedBox(height: 4),
            _buildNotVerified(),
            _buildUserPhoneNumber()
          ],
        ),
      ],
    );
  }

  Observer _buildProfileImage() {
    return Observer(builder: (context) {
      return CircleAvatar(
        backgroundColor: Color(0xffB4D1C4),
        radius: 32,
        backgroundImage: _userStore.profileImage != null
            ? MemoryImage(_userStore.profileImage!) as ImageProvider
            : _userStore.gender == DataConstants.MALE
                ? AssetImage("assets/icons/icon_papa.png")
                : _userStore.gender == DataConstants.FEMALE
                    ? AssetImage("assets/icons/icon_mama.png")
                    : AssetImage("assets/images/profile.png"),
      );
    });
  }

  Observer _buildNotVerified() {
    return Observer(builder: (context) {
      if (_userStore.isVerified) {
        if (_userStore.firstName != "") {
          return Text(
            _userStore.email,
            textAlign: TextAlign.center,
            style: ProfileStyles.textSmall,
          );
        }
        return SizedBox();
      }
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => _showOtpModal(context),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
              color: Color(0xffDE004F),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Text(
                "Not Verified",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: FontFamily.avenirLTStd,
                    fontSize: 12),
              ),
            ),
          ),
        ),
      );
    });
  }

  Observer _buildUserPhoneNumber() {
    return Observer(builder: (context) {
      return Text(
        _userStore.phoneNumber,
        textAlign: TextAlign.center,
        style: ProfileStyles.textSmall,
      );
    });
  }

  Observer _buildUserNameOrEmail() {
    return Observer(builder: (context) {
      return Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            _userStore.firstName.isNotEmpty
                ? _userStore.firstName + " " + _userStore.lastName
                : _userStore.email,
            textAlign: TextAlign.center,
            softWrap: true,
            style: TextStyle(
              fontSize: 20,
              color: Color(0xff0096B1),
              fontWeight: FontWeight.w400,
              fontFamily: FontFamily.candyCake,
            ),
          ),
          _userStore.isVerified
              ? Icon(Icons.verified_sharp, color: Color(0xff3ED425), size: 14)
              : SizedBox()
        ],
      );
    });
  }

  Future<void> _navigateToEditProfile(BuildContext context) async {
    var results = await Navigator.of(context).pushNamed(Routes.account_info);
    if (results != null) {
      if (!_userStore.loading) {
        _userStore.dispose();
        _userStore.checkLogin();
      }
    }
  }

  Future<void> _navigateToAddChild(BuildContext context) async {
    if (!_userStore.isVerified) {
      Future.delayed(Duration(milliseconds: 0), () {
        showErrorModal(context, "Verification Needed",
            "Your account isn't verified yet, please do the verification to use this feature");
      });
      return;
    }

    var results = await Navigator.of(context).pushNamed(Routes.child_info_add);
    if (results != null) {
      if (!_childrenStore.loading) {
        _childrenStore.getChildrensByUser();
      }
    }
  }

  Future<void> _navigateToEditChild(
      BuildContext context, Children children) async {
    _childrenStore.selectChildren(children);
    var results = await Navigator.of(context).pushNamed(Routes.child_info_edit);
    if (results != null) {
      if (!_childrenStore.loading) {
        _childrenStore.getChildrensByUser();
      }
    }
  }

  Future<void> _navigateToEditPref(BuildContext context) async {
    var results = await Navigator.of(context).pushNamed(Routes.preferences);
    if (results != null) {
      if (!_preferenceStore.loading) {
        _preferenceStore.getPreferenceByUser();
      }
    }
  }

  _showLogoutModal(BuildContext context) {
    return showMaterialModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32), topRight: Radius.circular(32)),
        ),
        backgroundColor: Colors.white,
        context: context,
        enableDrag: true,
        isDismissible: true,
        builder: (BuildContext context) {
          return ProfileLogoutWidget();
        });
  }

  _showAccountModal(BuildContext context) {
    return showMaterialModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32), topRight: Radius.circular(32)),
      ),
      backgroundColor: Colors.white,
      context: context,
      enableDrag: true,
      isDismissible: true,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          height: MediaQuery.of(context).copyWith().size.height * 0.20,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ProfileMenuButton(
                onPress: () =>
                    Navigator.of(context).pushNamed(Routes.change_password),
                icon: IconlyLight.unlock,
                title: "Change Password",
              ),
              ProfileMenuButton(
                onPress: () =>
                    Navigator.of(context).pushNamed(Routes.delete_account),
                icon: Icons.person_off_outlined,
                title: "Delete Account",
                iconColor: Color(0xffDC3434),
                textColor: Color(0xffDC3434),
              )
            ],
          ),
        );
      },
    );
  }

  AccountProgression _getRegistrationProgress() {
    List<Children> childrens =
        _childrenStore.childrens?.map((e) => e as Children).toList() ?? [];
    var progression = AccountProgression.Unverified;
    if (!_userStore.isVerified) {
      progression = AccountProgression.Unverified;
    } else if (_userStore.firstName.isEmpty) {
      progression = AccountProgression.UncompletedParentInfo;
    } else if (childrens.isEmpty) {
      progression = AccountProgression.UncompletedChildInfo;
    } else if (_growthStore.selectedGrowthId == 0) {
      progression = AccountProgression.UncompletedChildGrowth;
    } else if (_preferenceStore.preferenceId == 0) {
      progression = AccountProgression.UncompletedPreferences;
    } else {
      progression = AccountProgression.Completed;
    }
    return progression;
  }

  _showOtpModal(BuildContext context) {
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32.0), topRight: Radius.circular(32.0)),
        ),
        backgroundColor: Colors.white,
        context: context,
        enableDrag: true,
        isScrollControlled: true,
        isDismissible: false,
        builder: (_) {
          return LayoutBuilder(builder: (context, _) {
            //<----- very important use this context
            return AnimatedPadding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                duration: Duration(milliseconds: 150),
                curve: Curves.easeOut,
                child: Container(
                  constraints: BoxConstraints(maxHeight: 500, minHeight: 150),
                  child: Container(
                      padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 28.0),
                      height:
                          MediaQuery.of(context).copyWith().size.height * 0.50,
                      child: OtpRegisterScreen(
                        onFailed: () {
                          _showFailedModal(context);
                        },
                        onSuccess: () {
                          Navigator.of(context).pop();
                          _showSuccessModal(context);
                        },
                      )),
                ));
          });
        });
  }

  _showSuccessModal(BuildContext context) {
    return showMaterialModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32.0), topRight: Radius.circular(32.0)),
        ),
        backgroundColor: Colors.white,
        context: context,
        enableDrag: true,
        isDismissible: true,
        builder: (BuildContext context) {
          Timer(Duration(seconds: 5), () => Navigator.of(context).pop());
          return Observer(builder: (context) {
            return OtpSuccessModal(
                onTapSuccess: () => {Navigator.of(context).pop()});
          });
        });
  }

  _showFailedModal(BuildContext context) {
    return showMaterialModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32.0), topRight: Radius.circular(32.0)),
        ),
        backgroundColor: Colors.white,
        context: context,
        enableDrag: true,
        isDismissible: true,
        builder: (BuildContext context) {
          Timer(Duration(seconds: 5), () => Navigator.of(context).pop());
          return OtpFailedModal();
        });
  }
}
