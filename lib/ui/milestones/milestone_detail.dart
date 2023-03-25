import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:grouu/constants/font_family.dart';
import 'package:grouu/data/sqlite/models/milestone.dart';
import 'package:grouu/di/components/service_locator.dart';
import 'package:grouu/stores/article/article_store.dart';
import 'package:grouu/stores/children/children_store.dart';
import 'package:grouu/stores/milestone/milestone_store.dart';
import 'package:grouu/stores/user/user_store.dart';
import 'package:grouu/widgets/action_success_modal.dart';
import 'package:grouu/widgets/back_appbar_widget.dart';
import 'package:grouu/widgets/progress_indicator_widget.dart';
import 'package:grouu/widgets/rounded_button_widget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../widgets/show_error_modal.dart';

class MilestoneDetailScreen extends StatefulWidget {
  const MilestoneDetailScreen({super.key});

  @override
  State<MilestoneDetailScreen> createState() => _MilestoneDetailScreenState();
}

class _MilestoneDetailScreenState extends State<MilestoneDetailScreen> {
  UserStore _userStore = getIt<UserStore>();
  ChildrenStore _childrenStore = getIt<ChildrenStore>();
  MilestoneStore _milestoneStore = getIt<MilestoneStore>();
  ArticleStore _articleStore = getIt<ArticleStore>();
  late MilestoneChildren milestone;

  @override
  void initState() {
    super.initState();
    milestone = _milestoneStore.milestoneChildren as MilestoneChildren;
  }

  @override
  void dispose() {
    _userStore.dispose();
    // _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BackAppBar(title: Text("Detail Milestone")),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildContentScroll(children: [
                _buildHeaderImage(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildMilestoneName(),
                      SizedBox(height: 8),
                      _buildMilestoneDescription(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Ide Stimulasi",
                        style: TextStyle(
                            fontFamily: FontFamily.candyCake,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: 8),
                      _buildStimulation(),
                    ],
                  ),
                ),
              ]),
              _buildSaveButton()
            ],
          ),
          Observer(
            builder: (context) {
              return _milestoneStore.success
                  ? navigate(context)
                  : _showErrorMessage(_milestoneStore.errorStore.errorMessage);
            },
          ),
          Observer(
            builder: (context) {
              return Visibility(
                  visible: _milestoneStore.loading,
                  child: CustomProgressIndicatorWidget());
            },
          )
        ],
      ),
    );
  }

  Observer _buildStimulation() {
    return Observer(builder: (context) {
      return Text(
        milestone.milestone.stimulation ?? "",
        style: TextStyle(
            fontFamily: FontFamily.avenirLTStd,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xff242424)),
      );
    });
  }

  Observer _buildMilestoneDescription() {
    return Observer(builder: (context) {
      return Text(
        milestone.milestone.description ?? "",
        style: TextStyle(
            fontFamily: FontFamily.avenirLTStd,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xff242424)),
      );
    });
  }

  Observer _buildHeaderImage() {
    return Observer(builder: (context) {
      if (milestone.milestone.image == null) {
        return Image.asset("assets/images/milestone_header.png");
      } else {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Image.network(milestone.milestone.image!),
        );
      }
    });
  }

  Observer _buildMilestoneName() {
    return Observer(builder: (context) {
      return Text(
        milestone.milestone.title,
        style: TextStyle(
            fontFamily: FontFamily.candyCake,
            fontSize: 20,
            fontWeight: FontWeight.w400),
      );
    });
  }

  Widget _buildSaveButton() {
    return Observer(builder: (context) {
      if (_childrenStore.selectedChildrenId == 0) {
        return SizedBox();
      }

      if (milestone.checked) {
        return SizedBox();
      }

      return Padding(
        padding: EdgeInsets.all(16),
        child: RoundedButtonWidget(
            isLoading: _milestoneStore.loading,
            buttonText: "Tercapai",
            onPressed: () async {
              _milestoneStore.addMilestone(_childrenStore.selectedChildrenId,
                  _milestoneStore.milestoneId);
            }),
      );
    });
  }

  Expanded _buildContentScroll({required List<Widget> children}) {
    return Expanded(
      flex: 1,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRoundedTop(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: children,
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

  Widget navigate(BuildContext context) {
    Future.delayed(Duration(milliseconds: 0), () {
      _showSuccessModal(context).then((value) {
        Navigator.of(context).pop(true);
        _milestoneStore.dispose();
        _milestoneStore.clearInput();
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

  _showSuccessModal(BuildContext context) {
    return showMaterialModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Colors.white,
      context: context,
      enableDrag: true,
      isDismissible: true,
      builder: (BuildContext context) {
        Timer(Duration(seconds: 5), () => Navigator.of(context).pop());
        return ActionSuccessModal(
          description:
              "Data perkembangan telah berhasil disimpan dalam database kamu",
          title: "Tercapai!",
        );
      },
    );
  }
}
