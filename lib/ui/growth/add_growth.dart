import 'dart:async';

import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:grouu/constants/font_family.dart';
import 'package:grouu/data/sqlite/db/database.dart';
import 'package:grouu/di/components/service_locator.dart';
import 'package:grouu/models/growth/local_growth_arguments.dart';
import 'package:grouu/stores/children/children_store.dart';
import 'package:grouu/stores/growth/growth_store.dart';
import 'package:grouu/stores/user/user_store.dart';
import 'package:grouu/ui/growth/growth_how_to_measure.dart';
import 'package:grouu/ui/growth/widget/growth_slider_widget.dart';
import 'package:grouu/utils/ui/color.dart';
import 'package:grouu/widgets/back_appbar_widget.dart';
import 'package:grouu/widgets/children_selector_widget.dart';
import 'package:grouu/widgets/outline_rounded_button_widget.dart';
import 'package:grouu/widgets/progress_indicator_widget.dart';
import 'package:grouu/widgets/rounded_button_widget.dart';
import 'package:grouu/widgets/show_error_modal.dart';
import 'package:grouu/widgets/textfield_widget.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../widgets/action_success_modal.dart';

class AddGrowthScreen extends StatefulWidget {
  const AddGrowthScreen({super.key});

  @override
  State<AddGrowthScreen> createState() => _AddGrowthScreen();
}

class _AddGrowthScreen extends State<AddGrowthScreen>
    with TickerProviderStateMixin {
  GrowthStore _store = getIt<GrowthStore>();
  UserStore _userStore = getIt<UserStore>();
  ChildrenStore _childrenStore = getIt<ChildrenStore>();
  TextEditingController _lastMeasurementController = TextEditingController();
  late final TabController _tabController;
  LocalGrowthArguments? arguments = LocalGrowthArguments(false);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    _store.initState();
    _store.setupDisposers();
  }

  @override
  void dispose() {
    _userStore.dispose();
    _store.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    arguments =
        ModalRoute.of(context)!.settings.arguments as LocalGrowthArguments?;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BackAppBar(
          title: Text((arguments?.isEditGrowth == true ? "Edit" : "Tambah") +
              " Data Anak")),
      body: Stack(
        children: [
          _buildContentScroll(children: [
            _buildChildrenDropdown(),
            _buildDatePickerField(),
            _buildTabBar(),
            _buildTabBarView(),
          ]),
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
          ),
          Observer(
            builder: (context) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (arguments?.isEditGrowth == false) {
                  _store.clearInput();
                }
                if (_store.measurementDate != null) {
                  _lastMeasurementController.text = DateFormat("d MMMM yyyy")
                      .format(_store.measurementDate ?? DateTime.now());
                }
              });

              return Container();
            },
          )
        ],
      ),
    );
  }

  Widget _buildTabBarView() {
    return SizedBox(
      height: 550,
      child: TabBarView(controller: _tabController, children: [
        _buildHeightTab(),
        _buildWeightTab(),
        _buildHeadMeasurementTab(),
      ]),
    );
  }

  Widget _buildHeightTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 16),
        Observer(builder: (context) {
          return GrowthSliderWidget(
            max: 135,
            min: 0,
            interval: 20,
            measurement: "cm",
            value: _store.height,
            onChanged: (value) => _store.setHeight(value),
          );
        }),
        _buildInfoButton(),
        OutlineRoundedButtonWidget(
            buttonText: "Selanjutnya",
            onPressed: () {
              _tabController.index = 1;
            }),
        _buildSaveButton()
      ],
    );
  }

  Widget _buildWeightTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 16),
        Observer(builder: (context) {
          return GrowthSliderWidget(
            max: 35,
            min: 0,
            interval: 5,
            measurement: "kg",
            value: _store.weight,
            onChanged: (value) => _store.setWeight(value),
          );
        }),
        _buildInfoButton(),
        Row(
          children: [
            Expanded(
              child: OutlineRoundedButtonWidget(
                  buttonText: "Sebelumnya",
                  onPressed: () {
                    _tabController.index = 0;
                  }),
            ),
            SizedBox(width: 8),
            Expanded(
              child: OutlineRoundedButtonWidget(
                  buttonText: "Selanjutnya",
                  onPressed: () {
                    _tabController.index = 2;
                  }),
            ),
          ],
        ),
        _buildSaveButton()
      ],
    );
  }

  Widget _buildHeadMeasurementTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 16),
        Observer(builder: (context) {
          return GrowthSliderWidget(
            max: 60,
            min: 0,
            interval: 10,
            measurement: "cm",
            value: _store.headCircumference,
            onChanged: (value) => _store.setHeadCircumreference(value),
          );
        }),
        _buildInfoButton(),
        OutlineRoundedButtonWidget(
            buttonText: "Sebelumnya",
            onPressed: () {
              _tabController.index = 1;
            }),
        _buildSaveButton()
      ],
    );
  }

  TextButton _buildInfoButton() {
    return TextButton(
      style: TextButton.styleFrom(foregroundColor: Color(0xfff8b52e)),
      onPressed: () {
        _showMeasurementModal();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(IconlyLight.info_circle),
          SizedBox(width: 8),
          Text("Baca cara mengukur tinggi badan anak disini")
        ],
      ),
    );
  }

  TabBar _buildTabBar() {
    return TabBar(
      controller: _tabController,
      isScrollable: true,
      labelColor: Color(0xFF44BED5),
      unselectedLabelColor: Color(0xFFA4A4A4),
      indicatorColor: Color(0xFF44BED5),
      indicatorWeight: 2,
      indicatorSize: TabBarIndicatorSize.label,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(width: 2.0, color: Color(0xFF44BED5)),
        // insets: EdgeInsets.symmetric(horizontal: 80.0),
      ),
      tabs: <Widget>[
        Tab(
          icon: Text("Tinggi Badan",
              style: TextStyle(
                  fontFamily: FontFamily.avenirLTStd,
                  fontSize: 14,
                  fontWeight: FontWeight.w600)),
        ),
        Tab(
          icon: Text("Berat Badan",
              style: TextStyle(
                  fontFamily: FontFamily.avenirLTStd,
                  fontSize: 14,
                  fontWeight: FontWeight.w600)),
        ),
        Tab(
          icon: Text("Lingkar Kepala",
              style: TextStyle(
                  fontFamily: FontFamily.avenirLTStd,
                  fontSize: 14,
                  fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }

  Widget _buildChildrenDropdown() {
    return ChildrenSelectorWidget(childrenStore: _childrenStore);
  }

  Widget _buildDatePickerField() {
    return Observer(
      builder: (context) {
        return GestureDetector(
          onTap: () {
            showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate:
                  (_childrenStore.selectedChildren as Children?)?.birthday ??
                      DateTime(1990),
              lastDate: DateTime.now(),
            ).then((value) {
              if (value != null) {
                _store.setMeasurementDate(value);
                _lastMeasurementController.text =
                    DateFormat("d MMMM yyyy").format(value);
              }
            });
          },
          child: TextFieldWidget(
            hint: "Tanggal Pengukuran",
            hintColor: HexColor.fromHex("#7B7B7B"),
            icon: IconlyBold.calendar,
            enabled: false,
            inputType: TextInputType.datetime,
            padding: EdgeInsets.only(top: 16.0),
            inputAction: TextInputAction.next,
            errorText: _store.growthErrorStore.measurementDate,
            textController: _lastMeasurementController,
          ),
        );
      },
    );
  }

  Widget _buildSaveButton() {
    return Observer(builder: (context) {
      return RoundedButtonWidget(
          isLoading: _store.loading,
          buttonText: "Simpan",
          onPressed: () async {
            if (_childrenStore.selectedChildrenId != 0) {
              print(_store.height);
              if (arguments?.isEditGrowth == true) {
                //_store.resetErrorReaction();
                if (_store.canAddGrowth) {
                  _store.updateGrowth(_childrenStore.selectedChildrenId);
                } else {
                  _showErrorMessage(
                      "Pastikan data Tinggi badan, Berat badan, Lingkar kepala, dan Tanggal pengukuran telah diisi");
                }
              } else {
                if (_store.canAddGrowth) {
                  _store.addGrowth(_childrenStore.selectedChildrenId);
                } else {
                  _showErrorMessage(
                      "Pastikan data Tinggi badan, Berat badan, Lingkar kepala, dan Tanggal pengukuran telah diisi");
                }
              }
            }
          });
    });
  }

  Widget _buildContentScroll({required List<Widget> children}) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRoundedTop(),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          )
        ],
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
        _store.dispose();
      });
    });
    return Container();
  }

  // General Methods:-----------------------------------------------------------

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
                "Data pertumbuhan telah berhasil ditambah dalam database kamu",
            title: (arguments?.isEditGrowth == true ? "Edit" : "Tambah") +
                " Data Berhasil!",
          );
        });
  }

  _showErrorMessage(String message) {
    if (message.isNotEmpty) {
      Future.delayed(Duration(milliseconds: 0), () {
        showErrorModal(
            context,
            (arguments?.isEditGrowth == true ? "Edit" : "Tambah") +
                " Data Gagal!",
            message);
      });
    }

    return SizedBox.shrink();
  }

  Future _showMeasurementModal() {
    return showMaterialModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: Colors.white,
        context: context,
        enableDrag: true,
        isDismissible: true,
        builder: (BuildContext context) {
          return GrowthHowToMeasureModal();
        });
  }
}
