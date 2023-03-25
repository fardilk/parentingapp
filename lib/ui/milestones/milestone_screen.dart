import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:grouu/constants/font_family.dart';
import 'package:grouu/data/sqlite/db/database.dart';
import 'package:grouu/data/sqlite/models/milestone.dart';
import 'package:grouu/di/components/service_locator.dart';
import 'package:grouu/stores/children/children_store.dart';
import 'package:grouu/stores/milestone/milestone_store.dart';
import 'package:grouu/ui/milestones/widget/milestone_accordion.dart';
import 'package:grouu/utils/routes/routes.dart';
import 'package:grouu/widgets/progress_indicator_widget.dart';
import 'package:grouu/widgets/small_chip_widget.dart';
import 'package:iconly/iconly.dart';

class MilestoneScreen extends StatefulWidget {
  const MilestoneScreen({super.key});

  @override
  State<MilestoneScreen> createState() => _MilestoneScreenState();
}

class _MilestoneScreenState extends State<MilestoneScreen> {
  final ChildrenStore _childrenStore = getIt<ChildrenStore>();
  final MilestoneStore _milestoneStore = getIt<MilestoneStore>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_childrenStore.selectedChildrenId != 0) {
      _milestoneStore.getRegisteredMilestone(_childrenStore.selectedChildrenId);
    } else {
      _milestoneStore.getUnregisteredMilestone();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEFBFE),
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Color(0xff7AD0E2),
        title: _buildAppbarTitle(),
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildContentScroll(children: [
                _buildTitleAge(),
                _buildAgeSelector(),
                _buildProgressMilestone(),
                _buildMilestoneMovement(),
                _buildMilestoneMotoric(),
                _buildMilestoneLanguage(),
                _buildMilestoneSocial(),
                _buildMilestoneCognitive()
              ]),
            ],
          ),
          Observer(
            builder: (context) {
              return Visibility(
                  visible: _milestoneStore.loading,
                  child: CustomProgressIndicatorWidget());
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProgressMilestone() {
    return Observer(builder: (context) {
      if (_childrenStore.selectedChildrenId == 0) {
        return SizedBox.shrink();
      }
      return Container(
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: Image.asset(
                "assets/images/baby_girl_n_notes.png",
                alignment: Alignment.bottomRight,
                scale: 1.5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Perkembangan ${_childrenStore.firstName} ${_childrenStore.lastName} saat ini",
                          style: TextStyle(
                            fontFamily: FontFamily.avenirLTStd,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Color(0xFF3E3C3C),
                          ),
                        ),
                        SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: LinearProgressIndicator(
                            minHeight: 5,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xFFFFE873)),
                            value:
                                _milestoneStore.checked / _milestoneStore.total,
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          "${_milestoneStore.checked}/${_milestoneStore.total} perkembangan",
                          style: TextStyle(
                            fontFamily: FontFamily.avenirLTStd,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: Color(0xFF3E3C3C),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(flex: 1)
                ],
              ),
            )
          ],
        ),
      );
    });
  }

  Padding _buildTitleAge() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        "Usia Perkembangan",
        style: TextStyle(
            fontFamily: FontFamily.candyCake,
            fontSize: 20,
            fontWeight: FontWeight.w400),
      ),
    );
  }

  Widget _buildMilestoneSocial() {
    return Observer(builder: (context) {
      List<MilestoneChildren> listMilestone = _milestoneStore.listMilestone
          .map((e) => e as MilestoneChildren)
          .where((element) => element.milestone.categoryId == 1)
          .toList();
      return MilestoneAccordion(
        title: "Sosial & Emosional",
        icon: Image.asset('assets/icons/icon_heart.png'),
        listMilestone: listMilestone,
        onSelectMilestone: (milestone) =>
            _navigateToDetailMilestone(context, milestone),
        iconBackgroundColor: Color(0xffFFEFF3),
      );
    });
  }

  Widget _buildMilestoneMovement() {
    return Observer(builder: (context) {
      List<MilestoneChildren> listMilestone = _milestoneStore.listMilestone
          .map((e) => e as MilestoneChildren)
          .where((element) => element.milestone.categoryId == 5)
          .toList();
      return MilestoneAccordion(
        title: "Motorik Kasar",
        icon: Image.asset('assets/icons/icon_hand.png'),
        listMilestone: listMilestone,
        onSelectMilestone: (milestone) =>
            _navigateToDetailMilestone(context, milestone),
        iconBackgroundColor: Color(0xffFDFFDA),
      );
    });
  }

  Widget _buildMilestoneLanguage() {
    return Observer(builder: (context) {
      List<MilestoneChildren> listMilestone = _milestoneStore.listMilestone
          .map((e) => e as MilestoneChildren)
          .where((element) => element.milestone.categoryId == 2)
          .toList();
      return MilestoneAccordion(
        title: "Bahasa",
        icon: Image.asset('assets/icons/icon_message.png'),
        listMilestone: listMilestone,
        onSelectMilestone: (milestone) =>
            _navigateToDetailMilestone(context, milestone),
        iconBackgroundColor: Color(0xffFDFFDA),
      );
    });
  }

  Widget _buildMilestoneMotoric() {
    return Observer(builder: (context) {
      List<MilestoneChildren> listMilestone = _milestoneStore.listMilestone
          .map((e) => e as MilestoneChildren)
          .where((element) => element.milestone.categoryId == 4)
          .toList();
      return MilestoneAccordion(
        title: "Motorik Halus",
        icon: Image.asset('assets/icons/icon_foot.png'),
        listMilestone: listMilestone,
        onSelectMilestone: (milestone) =>
            _navigateToDetailMilestone(context, milestone),
        iconBackgroundColor: Color(0xffEFE6F1),
      );
    });
  }

  Widget _buildMilestoneCognitive() {
    return Observer(builder: (context) {
      List<MilestoneChildren> listMilestone = _milestoneStore.listMilestone
          .map((e) => e as MilestoneChildren)
          .where((element) => element.milestone.categoryId == 3)
          .toList();
      return MilestoneAccordion(
        title: "Kognitif",
        icon: Image.asset('assets/icons/icon_brain.png'),
        listMilestone: listMilestone,
        onSelectMilestone: (milestone) =>
            _navigateToDetailMilestone(context, milestone),
        iconBackgroundColor: Color(0xffDEF4F8),
      );
    });
  }

  Widget _buildAppbarTitle() {
    return Observer(builder: (context) {
      if (_childrenStore.childrens == null ||
          _childrenStore.childrens!.isEmpty) {
        return SizedBox();
      } else {
        List<Children> childrens = _childrenStore.childrens as List<Children>;
        return DropdownButton<String>(
          isExpanded: true,
          value: _childrenStore.selectedChildrenId.toString(),
          icon: const Icon(IconlyLight.arrow_down_2, color: Colors.white),
          elevation: 0,
          style: TextStyle(
              fontFamily: FontFamily.avenirLTStd,
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold),
          dropdownColor: Color(0xff13B2CC),
          underline: Container(
            height: 2,
            color: Colors.white,
          ),
          onChanged: (String? value) {
            _childrenStore.selectChildren(childrens.firstWhere(
                (Children element) => element.id.toString() == value));
          },
          items: childrens.map<DropdownMenuItem<String>>((children) {
            return DropdownMenuItem<String>(
              value: children.id.toString(),
              child: Text("${children.firstName} ${children.lastName}"),
            );
          }).toList(),
        );
      }
    });
  }

  Widget _buildAgeSelector() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 8),
      scrollDirection: Axis.horizontal,
      child: Observer(builder: (context) {
        return Row(
            children: _milestoneStore.listPeriode.map((e) {
          return SmallChipWidget(
            text: e.periodeTitle,
            selected: e.periodeId == _milestoneStore.selectedPeriodeIndex,
            onSelected: (p0) {
              _milestoneStore.setPeriode(e.periodeId);
              if (_childrenStore.selectedChildrenId == 0) {
                _milestoneStore.getUnregisteredMilestone();
              } else {
                _milestoneStore
                    .getRegisteredMilestone(_childrenStore.selectedChildrenId);
              }
            },
          );
        }).toList());
      }),
    );
  }

  Expanded _buildContentScroll({required List<Widget> children}) {
    return Expanded(
      flex: 1,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(),
            _buildRoundedTop(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            )
          ],
        ),
      ),
    );
  }

  Future<void> _navigateToDetailMilestone(
      BuildContext context, MilestoneChildren milestoneChildren) async {
    _milestoneStore.setMilestoneChildren(milestoneChildren);
    _milestoneStore.setMilestoneId(milestoneChildren.milestone.id);
    var results =
        await Navigator.of(context).pushNamed(Routes.milestone_detail);
    if (results != null) {
      if (!_milestoneStore.loading) {
        _milestoneStore
            .getRegisteredMilestone(_childrenStore.selectedChildrenId);
        _milestoneStore.dispose();
        _milestoneStore.clearInput();
      }
    }
  }

  Container _buildHeader() {
    return Container(
      padding: EdgeInsets.all(16),
      color: Color(0xff7AD0E2),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          tr("milestone_header"),
          style: TextStyle(
            color: Colors.white,
            fontFamily: FontFamily.candyCake,
            fontSize: 24,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 4),
        Text(
          tr("milestone_subheader"),
          style: TextStyle(
            color: Colors.white,
            fontFamily: FontFamily.avenirLTStd,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        )
      ]),
    );
  }

  Stack _buildRoundedTop() {
    return Stack(
      children: [
        Container(height: 16, color: Color(0xff7AD0E2)),
        Container(
          height: 17,
          decoration: BoxDecoration(
            color: Color(0xffEEFBFE),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(16), topLeft: Radius.circular(16)),
          ),
        )
      ],
    );
  }
}
