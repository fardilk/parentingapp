import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:grouu/stores/article/article_store.dart';
import 'package:grouu/widgets/title_appbar_widget.dart';

import '../../di/components/service_locator.dart';
import '../../stores/user/user_store.dart';
import '../../utils/locale/wording_utils.dart';
import '../../widgets/small_chip_widget.dart';
import '../home/widgets/home_article_content.dart';
import '../home/widgets/home_horizontal_content.dart';

class ArticlesScreen extends StatefulWidget {
  const ArticlesScreen({super.key});

  @override
  State<ArticlesScreen> createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen>
    with AutomaticKeepAliveClientMixin {
  final UserStore _userStore = getIt<UserStore>();
  final ArticleStore _articleStore = getIt<ArticleStore>();

  @override
  void initState() {
    super.initState();
    if (!_articleStore.loading) {
      _articleStore.getArticleList();
      _articleStore.getArticleHorizontal();
      _articleStore.getArticleCategory();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Material(
      child: Scaffold(
        appBar: TitleAppBar(
          title: _userStore.isLoggedIn && _userStore.gender.isNotEmpty
              ? "Artikel terbaru untuk ${WordingUtils.genderGreeting(_userStore.gender)}"
              : "Artikel",
          useSearchButton: true,
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(children: [
              Container(
                color: Color(0xFF7AD0E2),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                        color: Color(0xFFEEFBFE),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                    ),
                    Observer(
                      builder: (BuildContext context) {
                        return HorizontalArticleContent(
                          loading: _articleStore.loading,
                          articleList: _articleStore.articleHorizontalList,
                        );
                      },
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Observer(builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: <Widget>[
                            ...?_articleStore
                                .articleCategoryList?.articleCategory
                                ?.map((item) {
                              return SmallChipWidget(
                                text: item.categoryName,
                                selected: item.categoryId ==
                                    _articleStore.selectedArticleCategoryId,
                                onSelected: (p0) {
                                  _articleStore.setArticleCategoryId(item);
                                },
                              );
                            }).toList(),
                          ],
                        ),
                      );
                    }),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Observer(
                        builder: ((context) {
                          return HomeArticleContent(
                            articleList: _articleStore.selectedArticleList,
                            forHomeContent: false,
                            loading: _articleStore.loading,
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
