import 'package:flutter/material.dart';
import 'package:grouu/constants/font_family.dart';
import 'package:shimmer/shimmer.dart';

import '../../../di/components/service_locator.dart';
import '../../../models/article/article.dart';
import '../../../stores/home/home_store.dart';
import '../../../utils/routes/routes.dart';
import '../../articles/articles_detail.dart';

class HorizontalArticleContent extends StatefulWidget {
  final String? categoryName;
  final List<Article>? articleList;
  final int? limit;
  final bool loading;
  final bool? isHomeWidget;

  const HorizontalArticleContent({
    Key? key,
    this.categoryName,
    this.articleList,
    this.limit,
    required this.loading,
    this.isHomeWidget = false,
  }) : super(key: key);

  @override
  State<HorizontalArticleContent> createState() =>
      _HorizontalArticleContentState();
}

class _HorizontalArticleContentState extends State<HorizontalArticleContent> {
  final _homeStore = getIt<HomeStore>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: widget.categoryName != null
              ? Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        widget.categoryName ?? "",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: FontFamily.candyCake,
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          color: Color(0xff3E3C3C),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        if (widget.isHomeWidget == true) {
                          _homeStore.setCurrentHomeIndex(3);
                        } else {
                          _homeStore.setCurrentHomeIndex(3);
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              Routes.home, (Route<dynamic> route) => false);
                          //Navigator.of(context).pushNamed(Routes.article_home);
                        }
                      },
                      child: Text(
                        "View All",
                        style: TextStyle(
                          fontFamily: FontFamily.avenirLTStd,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    )
                  ],
                )
              : Container(),
        ),
        SizedBox(
          height: 190,
          child: widget.loading == true
              ? Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16.0, bottom: 16.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: ArticleHorizontalItem(
                        title: "", imageUrl: "", slug: ""),
                  ),
                )
              : ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.articleList?.length ?? 0,
                  padding:
                      EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                  itemBuilder: (context, index) {
                    return ArticleHorizontalItem(
                      title: widget.articleList?[index].title ?? "",
                      imageUrl: widget.articleList?[index].imageUrl ?? "",
                      slug: widget.articleList?[index].slug ?? "",
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      width: 16.0,
                    );
                  },
                ),
        )
      ],
    );
  }
}

class ArticleHorizontalItem extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String slug;
  const ArticleHorizontalItem({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.slug,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (slug.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArticlesDetail(
                slug: slug,
                detailType: DetailType.Artikel,
              ),
            ),
          );
        }
      },
      child: Card(
        elevation: 10,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 230.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (imageUrl.isEmpty)
                Shimmer.fromColors(
                    baseColor: Color(0xff7ad0e2),
                    highlightColor: Colors.white,
                    child: SizedBox(
                      height: 96,
                      width: 230,
                      child: Container(color: Color(0xff7ad0e2)),
                    ))
              else
                Image.network(
                  imageUrl,
                  height: 96.0,
                  width: 230.0,
                  fit: BoxFit.fill,
                ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: title.isEmpty
                    ? Shimmer.fromColors(
                        baseColor: Color(0xff7ad0e2),
                        highlightColor: Colors.white,
                        child: Text(
                          "███████████████ \n██████████",
                          maxLines: 2,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: FontFamily.avenirLTStd,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Color(0xff3E3C3C),
                          ),
                        ),
                      )
                    : Text(
                        "$title \n",
                        maxLines: 2,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: FontFamily.avenirLTStd,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Color(0xff3E3C3C),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
