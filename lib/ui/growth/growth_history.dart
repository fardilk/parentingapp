import 'dart:async';

import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:grouu/data/sqlite/db/database.dart';
import 'package:grouu/models/growth/local_growth_arguments.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../constants/font_family.dart';
import '../../data/local/constants/data_constants.dart';
import '../../data/local/constants/growth_constants.dart';
import '../../di/components/service_locator.dart';
import '../../stores/children/children_store.dart';
import '../../stores/growth/growth_store.dart';
import '../../stores/user/user_store.dart';
import '../../utils/locale/wording_utils.dart';
import '../../utils/routes/routes.dart';
import '../../widgets/back_appbar_widget.dart';
import '../../widgets/delete_confirm_widget.dart';
import '../../widgets/show_error_modal.dart';
import '../home/widgets/home_data_tumbuh.dart';
import '../../widgets/action_success_modal.dart';

class GrowthHistory extends StatefulWidget {
  const GrowthHistory({super.key});

  @override
  State<GrowthHistory> createState() => _GrowthHistoryState();
}

class _GrowthHistoryState extends State<GrowthHistory> {
  final GrowthStore _growthStore = getIt<GrowthStore>();
  final ChildrenStore _childrenStore = getIt<ChildrenStore>();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    _growthStore.selectGrowthByChildId(
        (_childrenStore.selectedChildren as Children).id);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Color(0xFF7ad0e2),
        appBar: BackAppBar(
            title: Text("Riwayat",
                style: TextStyle(
                    fontFamily: FontFamily.avenirLTStd,
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold))),
        body: Stack(
          children: [
            _buildBody(),
            Observer(
              builder: (context) {
                return _growthStore.successDelete
                    ? _onSuccessDelete(context)
                    : _showErrorMessage(_growthStore.errorStore.errorMessage);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildChildPicture(),
        Expanded(
          flex: 1,
          child: Container(
            color: Color(0xFFEEFBFE),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 14.0),
                _buildChildName(),
                _buildChildHistoryCount(),
                _buildGrowthList(),
              ],
            ),
          ),
        )
      ],
    );
  }

  _buildGrowthList() {
    return Expanded(
      child: Observer(
        builder: (BuildContext context) {
          List<Growth> growthList =
              _growthStore.selectedGrowths as List<Growth>? ?? [];
          return ListView.builder(
            itemCount: growthList.length,
            prototypeItem: GrowthHistoryItem(
              growthId: 1,
              age: '',
              onDeleteTap: () {},
              onEditTap: () {},
            ),
            itemBuilder: (context, index) {
              return GrowthHistoryItem(
                age:
                    WordingUtils.formatDate(growthList[index].measurementDate) +
                        " - " +
                        WordingUtils.getAgeByTimeDiff(_childrenStore.birthday,
                            growthList[index].measurementDate),
                growthId: growthList[index].id,
                childHead:
                    growthList[index].headCircumference.toStringAsFixed(2),
                childHeight: growthList[index].height.toStringAsFixed(2),
                childWeight: growthList[index].weight.toStringAsFixed(2),
                onDeleteTap: () {
                  _showDeleteModal(_growthStore, growthList[index].id);
                },
                onEditTap: () {
                  _navigateToEditGrowth(growthList[index]);
                },
              );
            },
          );
        },
      ),
    );
  }

  Padding _buildChildName() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 16.0),
      child: Text(
        _childrenStore.firstName.isNotEmpty
            ? _childrenStore.firstName + " " + _childrenStore.lastName
            : "",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          color: Color(0xff0096B1),
          fontWeight: FontWeight.w700,
          fontFamily: FontFamily.avenirLTStd,
        ),
      ),
    );
  }

  Padding _buildChildHistoryCount() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 16.0),
      child: Observer(
        builder: (BuildContext context) {
          return Text(
            "${(_growthStore.selectedGrowths as List<Growth>?)?.length} riwayat pertumbuhan",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Color(0xff676767),
              fontWeight: FontWeight.w400,
              fontFamily: FontFamily.avenirLTStd,
            ),
          );
        },
      ),
    );
  }

  Stack _buildChildPicture() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 48,
          decoration: BoxDecoration(
            color: Color(0xFFEEFBFE),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
        ),
        Center(
          child: CircleAvatar(
            radius: 36,
            backgroundColor: Color(0xFFEEFBFE),
            child: CircleAvatar(
              radius: 34,
              backgroundColor:
                  (_childrenStore.selectedChildren as Children).gender ==
                          DataConstants.MALE
                      ? Color(0xffAEE3EE)
                      : Color(0xffF8B6C9),
              backgroundImage: _bgImage(),
            ),
          ),
        )
      ],
    );
  }

  ImageProvider<Object>? _bgImage() {
    var image = (_childrenStore.selectedChildren as Children).image;
    var gender = (_childrenStore.selectedChildren as Children).gender;
    if (image != null) {
      return MemoryImage(image);
    } else {
      return gender == DataConstants.MALE
          ? AssetImage("assets/images/baby_boy_profile.png")
          : AssetImage("assets/images/baby_girl_profile.png");
    }
  }

  Widget _onSuccessDelete(BuildContext context) {
    Future.delayed(Duration(milliseconds: 0), () {
      _showSuccessModal(context).then((value) async {
        _growthStore.dispose();
        _growthStore.clearInput();
        await _growthStore.selectGrowthByChildId(
            (_childrenStore.selectedChildren as Children).id);
        if (((_growthStore.selectedGrowths as List<Growth>?)?.length ?? 0) ==
            0) {
          Navigator.of(context).pop();
        } else {
          print((_growthStore.selectedGrowths as List<Growth>?)?.length);
        }
      });
    });
    return Container();
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
            description: "Data telah berhasil dihapus dalam database kamu",
            title: "Hapus Data Berhasil!",
          );
        });
  }

  _showDeleteModal(GrowthStore _growthStore, int growthId) {
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
          return DeleteConfirmWidget(
            onConfirmTap: () {
              _growthStore.deleteGrowth(growthId);
            },
            dialogWording: "Yakin ingin hapus data?",
          );
        });
  }

  _navigateToEditGrowth(Growth selectedGrowth) {
    _growthStore.selectGrowth(selectedGrowth);
    Navigator.of(context)
        .pushNamed(Routes.add_growth, arguments: LocalGrowthArguments(true));
  }

  _showErrorMessage(String message) {
    if (message.isNotEmpty) {
      Future.delayed(Duration(milliseconds: 0), () {
        showErrorModal(context, "Error", message);
      });
    }

    return SizedBox.shrink();
  }
}

class GrowthHistoryItem extends StatelessWidget {
  GrowthHistoryItem(
      {super.key,
      this.childHeight,
      this.childWeight,
      this.childHead,
      required this.age,
      required this.growthId,
      required this.onEditTap,
      required this.onDeleteTap});
  final String? childHeight;
  final String? childWeight;
  final String? childHead;
  final String age;
  final int growthId;
  final Function() onEditTap;
  final Function() onDeleteTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(8.0)),
        elevation: 0,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ChildStats(
                    statsType: StatsType.Height,
                    statsValue: childHeight ?? "N/A",
                  ),
                  ChildStats(
                    statsType: StatsType.Weight,
                    statsValue: childWeight ?? "N/A",
                  ),
                  ChildStats(
                    statsType: StatsType.Head,
                    statsValue: childHead ?? "N/A",
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 1,
              color: Color(0xffE1E1E1),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      age,
                      style: TextStyle(
                        fontFamily: FontFamily.avenirLTStd,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Color(0xff909090),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: onEditTap,
                    child: Image.asset(
                      "assets/icons/icon_pen.png",
                      height: 16,
                      width: 16,
                    ),
                  ),
                  SizedBox(width: 16),
                  Container(
                    height: 24,
                    width: 1,
                    color: Color(0xffE1E1E1),
                  ),
                  SizedBox(width: 16),
                  InkWell(
                    onTap: onDeleteTap,
                    child: Image.asset(
                      "assets/icons/icon_trash.png",
                      height: 16,
                      width: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
