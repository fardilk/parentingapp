import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:grouu/constants/font_family.dart';
import 'package:grouu/data/local/constants/data_constants.dart';
import 'package:grouu/data/sqlite/db/database.dart';
import 'package:grouu/di/components/service_locator.dart';
import 'package:grouu/models/growth/local_growth.dart';
import 'package:grouu/stores/article/article_store.dart';
import 'package:grouu/stores/children/children_store.dart';
import 'package:grouu/stores/growth/growth_store.dart';
import 'package:grouu/stores/user/user_store.dart';
import 'package:grouu/ui/growth/growth_detail.dart';
import 'package:grouu/ui/growth/growth_graph_chart.dart';
import 'package:grouu/ui/home/widgets/home_data_tumbuh.dart';
import 'package:grouu/ui/home/widgets/home_tambah_data_tumbuh.dart';
import 'package:iconly/iconly.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shimmer/shimmer.dart';

import '../../data/local/constants/growth_constants.dart';
import '../../models/growth/local_growth_arguments.dart';
import '../../stores/home/home_store.dart';
import '../../utils/locale/wording_utils.dart';
import '../../utils/routes/routes.dart';
import '../../widgets/back_appbar_widget.dart';
import '../home/widgets/home_horizontal_content.dart';

class GrowthDashboard extends StatefulWidget {
  @override
  State<GrowthDashboard> createState() => _GrowthDashboardState();
}

class _GrowthDashboardState extends State<GrowthDashboard>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  final GrowthStore _growthStore = getIt<GrowthStore>();
  final UserStore _userStore = getIt<UserStore>();
  final ChildrenStore _childrenStore = getIt<ChildrenStore>();
  final HomeStore _homeStore = getIt<HomeStore>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _growthStore.getAllGrowthRiskDatas(
        (_childrenStore.selectedChildren as Children?)?.gender ??
            DataConstants.MALE);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _growthStore.selectGrowthByChildId(
        (_childrenStore.selectedChildren as Children?)?.id);
    _growthStore.getAllGrowthRiskDatas(
        (_childrenStore.selectedChildren as Children?)?.gender ??
            DataConstants.MALE);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Color(0xFF7ad0e2),
        appBar: BackAppBar(title: _buildAppbarTitle()),
        body: _buildBody(),
        bottomNavigationBar: _buildBottomLoginButton(),
      ),
    );
  }

  Widget _buildAppbarTitle() {
    return Observer(builder: (context) {
      if (_childrenStore.childrens == null ||
          _childrenStore.childrens!.isEmpty) {
        return Text(tr('growth'),
            style: TextStyle(
                fontFamily: FontFamily.avenirLTStd,
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold));
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

  _buildBody() {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverToBoxAdapter(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(),
                SizedBox(height: 8.0),
                _buildCardContainer(),
              ],
            ),
          )
        ];
      },
      body: Container(
        color: Colors.white,
        child: TabBarView(
          controller: _tabController,
          children: [
            Observer(
              builder: (BuildContext context) {
                return GrowthItemPage(
                  growthData: _growthStore.selectedHeightGrowthRisk ?? [],
                  childGrowthData: _growthStore.selectedChildHeight ?? [],
                  statsType: StatsType.Height,
                );
              },
            ),
            Observer(
              builder: (BuildContext context) {
                return GrowthItemPage(
                  growthData: _growthStore.selectedWeightGrowthRisk ?? [],
                  childGrowthData: _growthStore.selectedChildWeight ?? [],
                  statsType: StatsType.Weight,
                );
              },
            ),
            Observer(
              builder: (BuildContext context) {
                return GrowthItemPage(
                  growthData: _growthStore.selectedHeadGrowthRisk ?? [],
                  childGrowthData: _growthStore.selectedChildHead ?? [],
                  statsType: StatsType.Head,
                );
              },
            ),
            Observer(
              builder: (BuildContext context) {
                return GrowthItemPage(
                  growthData: _growthStore.selectedBmiGrowthRisk ?? [],
                  childGrowthData: _growthStore.selectedChildBmi ?? [],
                  statsType: StatsType.Bmi,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Padding _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              tr('growth_header'),
              textAlign: TextAlign.left,
              maxLines: 1,
              style: TextStyle(
                fontFamily: FontFamily.avenirLTStd,
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 4.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              tr('growth_subheader'),
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: FontFamily.avenirLTStd,
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Colors.white,
                height: 1.4,
              ),
            ),
          ),
          SizedBox(height: 16.0),
          TambahDataGrowthButton(
            visible: true,
            withPadding: true,
            onTap: () async {
              if (_childrenStore.childrens == null ||
                  _childrenStore.childrens!.isEmpty ||
                  !_userStore.isVerified) {
                _homeStore.setCurrentHomeIndex(4);
                Navigator.of(context).pop();
              } else {
                var intent = await Navigator.of(context).pushNamed(
                    Routes.add_growth,
                    arguments: LocalGrowthArguments(false));
                if (intent == true) {
                  _growthStore.selectGrowthByChildId(
                      (_childrenStore.selectedChildren as Children?)?.id);
                }
              }
            },
          ),
        ],
      ),
    );
  }

  Container _buildCardContainer() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffEEFBFE),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildChildLastGrowth(),
          _buildTabBar(),
        ],
      ),
    );
  }

  _buildTabBar() {
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
        Tab(
          icon: Text("Berat/Tinggi",
              style: TextStyle(
                  fontFamily: FontFamily.avenirLTStd,
                  fontSize: 14,
                  fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }

  Widget? _buildBottomLoginButton() {
    if (_userStore.isLoggedIn) {
      return null;
    }
    return Container(
      padding: EdgeInsets.all(16),
      color: Color(0xffFFF5C3),
      child: Row(
        children: [
          Icon(
            IconlyLight.profile,
            size: 36,
            color: Color(0xff00A5C3),
          ),
          SizedBox(width: 8),
          Text(
            "Login/Sign up yuk",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xff13B2CC)),
          ),
          Spacer(),
          IconButton(
            onPressed: () async {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  Routes.onboarding, (Route<dynamic> route) => false,
                  arguments: true);
            },
            icon: Icon(IconlyBold.arrow_right_circle,
                size: 36, color: Color(0xff00A5C3)),
          )
        ],
      ),
    );
  }

  _buildChildLastGrowth() {
    return Observer(
      builder: (context) {
        List<Children> childrens =
            _childrenStore.childrens?.map((e) => e as Children).toList() ?? [];
        if (_userStore.isLoggedIn &&
            _growthStore.selectedGrowthId != 0 &&
            childrens.isNotEmpty &&
            _growthStore.selectedGrowth != null) {
          return Container(
            color: Color(0xFF7AD0E2),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: Color(0xFFEEFBFE),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                ),
                _buildGrowthHeader(),
              ],
            ),
          );
        } else {
          return SizedBox(height: 8.0);
        }
      },
    );
  }

  Observer _buildGrowthHeader() {
    return Observer(
      builder: (BuildContext context) {
        List<Children> childrens =
            _childrenStore.childrens?.map((e) => e as Children).toList() ?? [];

        return HomeDataTumbuhHeader(
          isHomeWidget: false,
          visible: _userStore.isLoggedIn &&
              _growthStore.selectedGrowthId != 0 &&
              childrens.isNotEmpty &&
              _growthStore.selectedGrowth != null,
          childHeight:
              "${(_growthStore.selectedGrowth as Growth?)?.height.toStringAsFixed(2)}",
          childWeight:
              "${(_growthStore.selectedGrowth as Growth?)?.weight.toStringAsFixed(2)}",
          childHead:
              "${(_growthStore.selectedGrowth as Growth?)?.headCircumference.toStringAsFixed(2)}",
          childHeightRisk: _growthStore.selectedHeightRisk,
          childWeightRisk: _growthStore.selectedWeightRisk,
          childHeadRisk: _growthStore.selectedHeadRisk,
          lastUpdated:
              "${WordingUtils.formatDate((_growthStore.selectedGrowth as Growth?)?.measurementDate)}",
          actionOnTap: () async {
            var intent =
                await Navigator.of(context).pushNamed(Routes.growth_history);
            if (intent == true) {
              _growthStore.selectGrowthByChildId(
                  (_childrenStore.selectedChildren as Children?)?.id);
            }
          },
        );
      },
    );
  }
}

class GrowthItemPage extends StatefulWidget {
  const GrowthItemPage({
    Key? key,
    required this.growthData,
    required this.statsType,
    this.childGrowthData,
  }) : super(key: key);

  final List<LocalGrowth> growthData;
  final List<LocalChildGrowth>? childGrowthData;
  final StatsType statsType;

  @override
  State<GrowthItemPage> createState() => _GrowthItemPageState();
}

class _GrowthItemPageState extends State<GrowthItemPage> {
  final GrowthStore _growthStore = getIt<GrowthStore>();
  final ChildrenStore _childrenStore = getIt<ChildrenStore>();
  final ArticleStore _articleStore = getIt<ArticleStore>();
  final UserStore _userStore = getIt<UserStore>();

  String pageTitle = '';
  String leftGraphLabel = '';

  @override
  void initState() {
    super.initState();
    pageTitle = "Grafik ${widget.statsType.typeName}";
    leftGraphLabel =
        '${widget.statsType.typeName} (${widget.statsType.typeSuffix})';
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Color(0xffEEFBFE),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    pageTitle,
                    style: TextStyle(
                      fontFamily: FontFamily.candyCake,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      color: Colors.black,
                      height: 1.4,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _openGraphModal();
                    },
                    child: Text(
                      "Detail Info",
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Observer(builder: (context) {
                    return _buildChildTable(
                        visible: _userStore.isLoggedIn &&
                            _growthStore.selectedGrowthId != 0 &&
                            _growthStore.selectedGrowth != null);
                  }),
                  Observer(builder: (context) {
                    return _buildGrowthDesc(
                        visible: _userStore.isLoggedIn &&
                            _growthStore.selectedGrowthId != 0 &&
                            _growthStore.selectedGrowth != null);
                  }),
                  _buildGrowthGraph(),
                  _buildGrowthLegends(),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "Sumber : WHO Child Growth Standards",
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: FontFamily.avenirLTStd,
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                        color: Color(0xff909090),
                      ),
                    ),
                  ),
                  HorizontalArticleContent(
                    categoryName: "Artikel Terkait",
                    articleList: _articleStore.articleHorizontalList,
                    loading: _articleStore.loading,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildGrowthDesc({bool visible = false}) {
    if (visible)
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Observer(builder: (context) {
          var desc = _growthStore.getGrowthDesc(widget.statsType);
          return Text(
            desc,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: FontFamily.avenirLTStd,
              fontWeight: FontWeight.w400,
              fontSize: 12,
              height: 1.5,
              color: Color(0xff242424),
            ),
          );
        }),
      );
    else
      return SizedBox.shrink();
  }

  Row _buildGrowthLegends() {
    var textStyle = TextStyle(
      fontFamily: FontFamily.avenirLTStd,
      fontWeight: FontWeight.w400,
      fontSize: 10,
      color: Color(0xff242424),
      height: 1.4,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Observer(builder: (context) {
          return Visibility(
            visible: _growthStore.selectedGrowths?.isNotEmpty ?? false,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 4,
                  backgroundColor: Color(0xff008297),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 4.0, right: 16),
                  child: Text(
                    "Anak",
                    style: textStyle,
                  ),
                ),
              ],
            ),
          );
        }),
        CircleAvatar(
          radius: 4,
          backgroundColor: Color(0xff3ED425),
        ),
        Padding(
          padding: EdgeInsets.only(left: 4.0, right: 16),
          child: Text(
            "Normal",
            style: textStyle,
          ),
        ),
        CircleAvatar(
          radius: 4,
          backgroundColor: Color(0xffff9533),
        ),
        Padding(
          padding: EdgeInsets.only(left: 4.0, right: 16),
          child: Text(
            "Risiko Sedang",
            style: textStyle,
          ),
        ),
        CircleAvatar(
          radius: 4,
          backgroundColor: Color(0xffdc3434),
        ),
        Padding(
          padding: EdgeInsets.only(left: 4.0, right: 16),
          child: Text(
            "Risiko Tinggi",
            style: textStyle,
          ),
        ),
      ],
    );
  }

  SizedBox _buildGrowthGraph() {
    return SizedBox(
      width: double.infinity,
      height: 250,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Observer(
          builder: (BuildContext context) {
            if (_growthStore.loading) {
              return Shimmer.fromColors(
                baseColor: Color(0xff7ad0e2),
                highlightColor: Colors.white,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white),
                ),
              );
            } else {
              return Observer(builder: (context) {
                _growthStore.selectedGrowths;
                return GrowthGraphChart(
                  leftGraphLabel: leftGraphLabel,
                  growthData: widget.growthData,
                  childGrowthData: widget.childGrowthData,
                );
              });
            }
          },
        ),
      ),
    );
  }

  Widget _buildChildTable({bool visible = false}) {
    if (visible) {
      return Observer(
        builder: (BuildContext context) {
          Resiko? _resiko = Resiko.Unknown;
          double? _statsValue = 0;
          switch (widget.statsType) {
            case StatsType.Height:
              _resiko = _growthStore.selectedHeightRisk;
              _statsValue = (_growthStore.selectedGrowth as Growth?)?.height;
              break;
            case StatsType.Weight:
              _resiko = _growthStore.selectedWeightRisk;
              _statsValue = (_growthStore.selectedGrowth as Growth?)?.weight;
              break;
            case StatsType.Head:
              _resiko = _growthStore.selectedHeadRisk;
              _statsValue =
                  (_growthStore.selectedGrowth as Growth?)?.headCircumference;
              break;
            case StatsType.Bmi:
              _resiko = _growthStore.selectedBmiRisk;
              _statsValue = _growthStore.getBmi();
              break;
            default:
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Color(0xFFE1E1E1)),
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              child: Column(
                children: [
                  _buildTableHeader(_resiko),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: Color(0xFFE1E1E1),
                  ),
                  _buildTableValue(_statsValue)
                ],
              ),
            ),
          );
        },
      );
    } else {
      return SizedBox.shrink();
    }
  }

  Padding _buildTableValue(double? _statsValue) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ChildStats(
            statsType: widget.statsType,
            statsValue: _statsValue?.toStringAsFixed(1) ?? "",
            isNormalValue: false,
            isChildValue: true,
          ),
          ChildStats(
            statsType: widget.statsType,
            statsValue: _growthStore.getNormalRiskValue(widget.statsType) ?? "",
            isNormalValue: true,
            isChildValue: false,
          ),
        ],
      ),
    );
  }

  Padding _buildTableHeader(Resiko? _resiko) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9.0, horizontal: 12),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              WordingUtils.getAgeByTimeDiff(
                  _childrenStore.birthday,
                  (_growthStore.selectedGrowth as Growth?)?.measurementDate ??
                      DateTime.now()),
              style: TextStyle(
                  fontFamily: FontFamily.avenirLTStd,
                  fontSize: 14,
                  color: Color(0xff3E3C3C),
                  fontWeight: FontWeight.bold),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
              decoration: BoxDecoration(
                color: _resiko?.backgroundColor,
                borderRadius: BorderRadius.circular(500),
              ),
              child: Text(
                _resiko?.name ?? "Normal",
                style: TextStyle(
                  fontSize: 8,
                  color: _resiko?.nameColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _openGraphModal() {
    return showMaterialModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0)),
        ),
        backgroundColor: Colors.white,
        context: context,
        enableDrag: true,
        isDismissible: true,
        builder: (BuildContext context) {
          return GrowthDetail(
            statsType: widget.statsType,
          );
        });
  }
}
