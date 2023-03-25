import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:grouu/constants/account_progression_constants.dart';
import 'package:grouu/data/sharedpref/shared_preference_helper.dart';
import 'package:grouu/data/sqlite/db/database.dart';
import 'package:grouu/models/growth/local_growth_arguments.dart';
import 'package:grouu/stores/children/children_store.dart';
import 'package:grouu/ui/home/widgets/home_article_content.dart';
import 'package:grouu/ui/home/widgets/home_banner_content.dart';
import 'package:grouu/ui/home/widgets/home_data_tumbuh.dart';
import 'package:grouu/ui/home/widgets/home_tambah_data_tumbuh.dart';
import 'package:grouu/ui/home/widgets/home_vaccination_button.dart';

import 'package:grouu/widgets/title_appbar_widget.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../di/components/service_locator.dart';
import '../../stores/article/article_store.dart';
import '../../stores/home/home_store.dart';
import '../../stores/milestone/milestone_store.dart';
import '../../stores/preference/preference_store.dart';
import '../../stores/user/user_store.dart';
import '../../stores/growth/growth_store.dart';
import '../../utils/locale/wording_utils.dart';
import '../../utils/routes/routes.dart';
import 'widgets/home_child_achievement.dart';
import 'widgets/home_child_overview_header.dart';
import 'widgets/home_complete_child_button.dart';
import 'widgets/home_features_button.dart';
import 'widgets/home_horizontal_content.dart';
import 'widgets/home_login_button.dart';

class HomeShowcaseBody extends StatelessWidget {
  final UserStore _store = getIt<UserStore>();
  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
      enableAutoScroll: true,
      onStart: ((p0, p1) {
        log("On Start, $p0 $p1");
      }),
      onFinish: () {
        _store.showcaseCompleted();
      },
      builder: Builder(
        builder: ((context) {
          return HomeBody();
        }),
      ),
    );
  }
}

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey _feature1 = GlobalKey();
  final GlobalKey _feature2 = GlobalKey();
  final GlobalKey _feature3 = GlobalKey();
  final GlobalKey _feature4 = GlobalKey();
  final GlobalKey _feature5 = GlobalKey();

  final _controller = ScrollController();

  final UserStore _userStore = getIt<UserStore>();
  final ChildrenStore _childrenStore = getIt<ChildrenStore>();
  final GrowthStore _growthStore = getIt<GrowthStore>();
  final ArticleStore _articleStore = getIt<ArticleStore>();
  final HomeStore _homeStore = getIt<HomeStore>();
  final MilestoneStore _milestoneStore = getIt<MilestoneStore>();
  final PreferenceStore _preferenceStore = getIt<PreferenceStore>();

  bool isMenuOpen = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // if (!_childrenStore.loading) {
    //   _childrenStore.getInitialChildrenData();
    // }
  }

  @override
  void initState() {
    super.initState();
    if (!_childrenStore.loading) {
      _childrenStore.getInitialChildrenData();
    }
    if (!_articleStore.loading) {
      _articleStore.getArticleList();
      _articleStore.getArticleHorizontal();
    }

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        final _sharedPref = getIt<SharedPreferenceHelper>();
        _sharedPref.isFirstTimeShowcase.then((value) {
          if (value) {
            ShowCaseWidget.of(context).startShowCase([
              _feature1,
              _feature2,
              _feature3,
              _feature4,
              _feature5,
            ]);
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Observer(
      builder: (BuildContext context) {
        return Scaffold(
          backgroundColor: Color(0xffEEFBFE),
          appBar: TitleAppBar(
              title: _userStore.isLoggedIn && _userStore.gender.isNotEmpty
                  ? "Selamat ${WordingUtils.timeGreeting()} ${WordingUtils.genderGreeting(_userStore.gender)} ${_userStore.lastName}"
                  : "Hello, Welcome to Grouu App"),
          extendBodyBehindAppBar: false,
          body: SingleChildScrollView(
            child: Stack(children: [
              _buildHomeScreen(),
            ]),
          ),
        );
      },
    );
  }

  Column _buildHomeScreen() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _buildHomeHeader(),
        _buildVaccineButton(),
        _buildHomeBanner(),
        _buildHomeContent(),
      ],
    );
  }

  Widget _buildHomeHeader() {
    return Column(
      children: [
        _buildLoginButton(),
        _buildCompleteInformationButton(),
        _buildChildOverviewHeader(),
        _buildAddGrowthButton(),
        _buildGrowthHeader(),
        _buildHomeFeatures(),
      ],
    );
  }

  Observer _buildLoginButton() {
    return Observer(
      builder: (BuildContext context) =>
          HomeLoginButton(visible: !_userStore.isLoggedIn),
    );
  }

  Observer _buildCompleteInformationButton() {
    return Observer(
      builder: (BuildContext context) {
        List<Children> childrens =
            _childrenStore.childrens?.map((e) => e as Children).toList() ?? [];

        AccountProgression progression = getAccountProgression(childrens);
        return HomeCompleteInformationButton(
          title: progression.title,
          subtitle: progression.desc(_userStore.gender),
          visible: _userStore.isLoggedIn &&
              (progression != AccountProgression.Completed),
          onTap: () async {
            switch (progression) {
              case AccountProgression.Unverified:
                _homeStore.setCurrentHomeIndex(4);
                break;
              case AccountProgression.UncompletedParentInfo:
                _navigateToEditProfile(context);
                break;
              case AccountProgression.UncompletedChildInfo:
                _navigateToAddChild(context);
                break;
              case AccountProgression.UncompletedChildGrowth:
                Navigator.of(context).pushNamed(Routes.add_growth,
                    arguments: LocalGrowthArguments(false));
                break;
              case AccountProgression.UncompletedPreferences:
                _navigateToEditPref(context);
                break;
              case AccountProgression.Completed:
                break;

              default:
            }
          },
        );
      },
    );
  }

  Observer _buildChildOverviewHeader() {
    return Observer(
      builder: (BuildContext context) {
        List<Children> childrens =
            _childrenStore.childrens?.map((e) => e as Children).toList() ?? [];
        return PortalTarget(
          visible: isMenuOpen,
          anchor: const Aligned(
            follower: Alignment.topCenter,
            target: Alignment.topCenter,
          ),
          portalFollower: Container(
            color: Colors.black54,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                ...childrens
                    .map(
                      (child) => HomeChildOverviewHeader(
                        visible: true,
                        onTap: () {
                          _childrenStore.selectChildren(child);
                          print(child);
                          setState(() {
                            isMenuOpen = false;
                          });
                        },
                        isItem: true,
                        children: child,
                      ),
                    )
                    .toList(),
              ],
            ),
          ),
          child: HomeChildOverviewHeader(
            visible: _userStore.isLoggedIn && childrens.isNotEmpty,
            children: _childrenStore.selectedChildren,
            isItem: false,
            onTap: () {
              setState(() {
                isMenuOpen = true;
              });
            },
          ),
        );
      },
    );
  }

  Observer _buildAddGrowthButton() {
    return Observer(
      builder: (BuildContext context) {
        List<Children> childrens =
            _childrenStore.childrens?.map((e) => e as Children).toList() ?? [];
        var progression = getAccountProgression(childrens);
        return TambahDataGrowthButton(
          withPadding: true,
          visible: _userStore.isLoggedIn &&
              progression == AccountProgression.UncompletedChildGrowth,
          onTap: () {
            if (progression == AccountProgression.UncompletedChildInfo) {
              _homeStore.setCurrentHomeIndex(4);
            } else {
              Navigator.of(context).pushNamed(Routes.add_growth,
                  arguments: LocalGrowthArguments(false));
            }
          },
        );
      },
    );
  }

  Observer _buildGrowthHeader() {
    return Observer(
      builder: (BuildContext context) {
        List<Children> childrens =
            _childrenStore.childrens?.map((e) => e as Children).toList() ?? [];

        if (!_growthStore.loading && !_childrenStore.loading) {
          return HomeDataTumbuhHeader(
            isHomeWidget: true,
            visible: _userStore.isLoggedIn &&
                _growthStore.selectedGrowthId != 0 &&
                childrens.isNotEmpty,
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
              var results = await Navigator.of(context).pushNamed(
                  Routes.add_growth,
                  arguments: LocalGrowthArguments(false));
              if (results != null) {
                _childrenStore.getInitialChildrenData();
              }
            },
          );
        } else {
          return Container();
        }
      },
    );
  }

  _buildHomeFeatures() {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: 56,
          decoration: BoxDecoration(
              color: Color(0xff7AD0E2),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0))),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 18),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: _controller,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HomeFeatureButton(
                    iconKey: _feature1,
                    featureName: "Pertumbuhan",
                    iconAsset: "assets/icons/icon_growth.png",
                    featureIndex: 0,
                    showcaseWording: tr('showcase_title_growth'),
                    onTap: () {
                      Navigator.of(context).pushNamed(Routes.growth_dashboard);
                    },
                  ),
                  SizedBox(width: 8),
                  HomeFeatureButton(
                    iconKey: _feature2,
                    featureName: "Vaksin",
                    iconAsset: "assets/icons/icon_vaccine.png",
                    featureIndex: 1,
                    showcaseWording: tr('showcase_title_vaccine'),
                    onTap: () async {
                      Navigator.of(context).pushNamed(Routes.vaccine);
                    },
                  ),
                  SizedBox(width: 8),
                  HomeFeatureButton(
                    iconKey: _feature3,
                    featureName: "Perkembangan",
                    iconAsset: "assets/icons/icon_milestone.png",
                    featureIndex: 2,
                    showcaseWording: tr('showcase_title_milestone'),
                    onTap: () {
                      _homeStore.setCurrentHomeIndex(2);
                    },
                  ),
                  SizedBox(width: 8),
                  HomeFeatureButton(
                    iconKey: _feature4,
                    featureName: "Belanja",
                    iconAsset: "assets/icons/icon_shop_beta.png",
                    featureIndex: 3,
                    showcaseWording: tr('showcase_title_shop'),
                    onTap: () {
                      _homeStore.setCurrentHomeIndex(1);
                    },
                  ),
                  SizedBox(width: 8),
                  HomeFeatureButton(
                    iconKey: _feature5,
                    featureName: "Artikel",
                    iconAsset: "assets/icons/icon_article.png",
                    featureIndex: 4,
                    showcaseWording: tr('showcase_title_article'),
                    onTap: () {
                      _homeStore.setCurrentHomeIndex(3);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  _buildVaccineButton() {
    return Observer(
      builder: (BuildContext context) {
        List<Children> childrens =
            _childrenStore.childrens?.map((e) => e as Children).toList() ?? [];
        return HomeVaccinationButton(
            onTap: () {
              Navigator.of(context).pushNamed(Routes.vaccine);
            },
            visible: _userStore.isLoggedIn && childrens.isNotEmpty,
            lastName: _childrenStore.lastName);
      },
    );
  }

  _buildHomeBanner() {
    return CarouselSlider(
      options: CarouselOptions(
        aspectRatio: 328 / 140,
        autoPlay: true,
        enableInfiniteScroll: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        scrollDirection: Axis.horizontal,
      ),
      items: homeBannerContent.map((e) {
        return Builder(
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                onTap: () async {
                  var uri = Uri.parse(e.url);
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  } else {
                    throw 'Could not launch $uri';
                  }
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.asset(
                    e.imageString,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  _buildHomeContent() {
    return Container(
      color: Color(0xFFF6F6F6),
      child: Column(
        children: [
          Observer(
            builder: (BuildContext context) {
              return HorizontalArticleContent(
                loading: _articleStore.loading,
                categoryName: "Kesehatan Buah Hati",
                articleList: _articleStore.articleHorizontalList,
                isHomeWidget: true,
              );
            },
          ),
          _buildHomeAchievement(),
          Observer(
            builder: (BuildContext context) {
              return HomeArticleContent(
                loading: _articleStore.loading,
                articleList: _articleStore.articleAllList,
                forHomeContent: true,
                limit: 5,
              );
            },
          ),
        ],
      ),
    );
  }

  Observer _buildHomeAchievement() {
    return Observer(
      builder: (BuildContext context) {
        List<Children> childrens =
            _childrenStore.childrens?.map((e) => e as Children).toList() ?? [];
        return HomeChildAchievement(
          visible: _userStore.isLoggedIn && childrens.isNotEmpty,
          lastName: _childrenStore.lastName,
          value: _milestoneStore.checked,
          totalValue: _milestoneStore.total,
          onTap: () {
            _homeStore.setCurrentHomeIndex(2);
          },
        );
      },
    );
  }

  // General Methods:-----------------------------------------------------------

  AccountProgression getAccountProgression(List<Children> childrens) {
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

  Future _navigateToEditProfile(BuildContext context) async {
    var results = await Navigator.of(context).pushNamed(Routes.account_info);
    if (results != null) {
      if (!_userStore.loading) {
        _userStore.dispose();
        _userStore.checkLogin();
      }
    }
  }

  Future<void> _navigateToAddChild(BuildContext context) async {
    var results = await Navigator.of(context).pushNamed(Routes.child_info_add);
    if (results != null) {
      _childrenStore.getInitialChildrenData();
    }
  }

  Future<void> _navigateToEditPref(BuildContext context) async {
    var results = await Navigator.of(context).pushNamed(Routes.preferences);
    if (results != null) {
      _preferenceStore.getPreferenceByUser();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
