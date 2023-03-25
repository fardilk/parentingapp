import 'package:flutter/material.dart';
import 'package:grouu/constants/font_family.dart';
import 'package:grouu/di/components/service_locator.dart';
import 'package:grouu/models/article/article.dart';
import 'package:grouu/ui/articles/articles_detail.dart';
import 'package:shimmer/shimmer.dart';

import '../../../stores/home/home_store.dart';

class HomeArticleContent extends StatefulWidget {
  const HomeArticleContent({
    Key? key,
    required this.forHomeContent,
    this.articleList,
    this.limit,
    required this.loading,
  }) : super(key: key);

  final bool forHomeContent;
  final List<Article>? articleList;
  final int? limit;
  final bool loading;

  @override
  State<HomeArticleContent> createState() => _HomeArticleContentState();
}

class _HomeArticleContentState extends State<HomeArticleContent> {
  final _homeStore = getIt<HomeStore>();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.forHomeContent ? Color(0xFFFFF5C3) : Colors.transparent,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    "Artikel",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: FontFamily.candyCake,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      color: Color(0xff3E3C3C),
                    ),
                  ),
                ),
                widget.forHomeContent
                    ? TextButton(
                        onPressed: () {
                          _homeStore.setCurrentHomeIndex(3);
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
                    : Container(),
              ],
            ),
          ),
          _buildArticleList(),
        ],
      ),
    );
  }

  Widget _buildArticleList() {
    if (widget.loading == true) {
      return HomeArticleItem(title: "", imageUrl: "", slug: "");
    } else {
      if (widget.limit != null) {
        return Column(
          children: <Widget>[
            ...?widget.articleList?.take(widget.limit!).map((item) {
              return HomeArticleItem(
                title: item.title,
                date: item.date,
                imageUrl: item.imageUrl,
                slug: item.slug,
              );
            }).toList(),
          ],
        );
      } else {
        return Column(
          children: <Widget>[
            ...?widget.articleList?.map((item) {
              return HomeArticleItem(
                title: item.title,
                date: item.date,
                imageUrl: item.imageUrl,
                slug: item.slug,
                categoryId: item.categoryId,
              );
            }).toList(),
          ],
        );
      }
    }
  }
}

class HomeArticleItem extends StatelessWidget {
  final String title;
  final String? date;
  final String imageUrl;
  final String slug;
  final int? categoryId;
  const HomeArticleItem(
      {Key? key,
      required this.title,
      this.date,
      required this.imageUrl,
      required this.slug,
      this.categoryId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: InkWell(
          onTap: () {
            if (slug.isNotEmpty) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ArticlesDetail(
                    slug: slug,
                    categoryId: categoryId,
                    detailType: DetailType.Artikel,
                  ),
                ),
              );
            }
          },
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title.isEmpty
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
                                fontSize: 14,
                                color: Color(0xff3E3C3C),
                              ),
                            ),
                          )
                        : Text(
                            "$title \n",
                            textAlign: TextAlign.left,
                            maxLines: 2,
                            style: TextStyle(
                              fontFamily: FontFamily.avenirLTStd,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Color(0xff3E3C3C),
                            ),
                          ),
                    SizedBox(height: 4),
                    Text(
                      date ?? "",
                      textAlign: TextAlign.left,
                      maxLines: 2,
                      style: TextStyle(
                        fontFamily: FontFamily.avenirLTStd,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Color(0xff676767),
                      ),
                    ),
                  ],
                ),
              ),
              ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: imageUrl.isEmpty
                      ? Shimmer.fromColors(
                          baseColor: Color(0xff7ad0e2),
                          highlightColor: Colors.white,
                          child: SizedBox(
                            height: 64,
                            width: 64,
                            child: Container(color: Color(0xff7ad0e2)),
                          ))
                      : Image.network(
                          imageUrl,
                          height: 64.0,
                          width: 64.0,
                          fit: BoxFit.fitHeight,
                        )),
            ],
          ),
        ),
      ),
    );
  }
}
