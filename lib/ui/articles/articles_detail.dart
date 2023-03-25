import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:grouu/data/network/constants/endpoints.dart';
import 'package:grouu/env/env.dart';
import 'package:grouu/ui/articles/localcontent/local_contents.dart';
import 'package:grouu/utils/locale/wording_utils.dart';
import 'package:iconly/iconly.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:html/parser.dart' as htmlparser;
import 'package:html/dom.dart' as dom;

import '../../constants/font_family.dart';
import '../../di/components/service_locator.dart';
import '../../stores/article/article_store.dart';
import '../home/widgets/home_horizontal_content.dart';

enum DetailType { Artikel, TermsCondition, PrivacyPolicy, AboutUs }

extension DetailTypeExt on DetailType {
  String get title {
    switch (this) {
      case DetailType.TermsCondition:
        return "Terms and Conditions";
      case DetailType.PrivacyPolicy:
        return "Privacy Policy";
      case DetailType.AboutUs:
        return "About Us";
      default:
        return "Article Detail";
    }
  }
}

class ArticlesDetail extends StatefulWidget {
  const ArticlesDetail(
      {super.key,
      required this.slug,
      this.categoryId,
      required this.detailType});
  final String slug;
  final int? categoryId;
  final DetailType detailType;

  @override
  State<ArticlesDetail> createState() => _ArticlesDetailState();
}

class _ArticlesDetailState extends State<ArticlesDetail> {
  final ArticleStore _articleStore = getIt<ArticleStore>();

  @override
  void initState() {
    super.initState();
    //TODO: Remove this condition if api other than articles is okay
    if (widget.detailType == DetailType.Artikel) {
      _articleStore.getArticleDetail(widget.slug);
      if (widget.categoryId != null) {
        _articleStore.getArticleRelated(widget.categoryId!);
      }
    } else {
      switch (widget.detailType) {
        case DetailType.TermsCondition:
          _articleStore.setArticleDetail(
              "Terms and Conditions", LocalContents.termsAndCondition);
          break;
        case DetailType.PrivacyPolicy:
          _articleStore.setArticleDetail(
              "Privacy Policy", LocalContents.privacyPolicy);
          break;
        case DetailType.AboutUs:
          _articleStore.setArticleDetail("About Us", LocalContents.aboutUs);
          break;
        default:
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _articleStore.disposeSelectedArticle();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Color(0xFF7ad0e2),
        appBar: _buildAppBar(context),
        body: _buildBody(),
      ),
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: Icon(IconlyLight.arrow_left_2, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(widget.detailType.title,
          style: TextStyle(
              fontFamily: FontFamily.avenirLTStd,
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold)),
    );
  }

  _buildBody() {
    return Observer(
      builder: (BuildContext context) {
        return Container(
          height: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildArticleTitle(),
                  widget.detailType == DetailType.Artikel
                      ? _buildArticleAuthor()
                      : SizedBox.shrink(),
                  _buildArticleContent(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Padding _buildArticleAuthor() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          // Image.asset(
          //   "assets/images/logogram.png",
          //   height: 32,
          //   width: 32,
          // ),
          // SizedBox(width: 6.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // _articleStore.loading
              //     ? Shimmer.fromColors(
              //         baseColor: Color(0xff7ad0e2),
              //         highlightColor: Colors.white,
              //         child: Text(
              //           "███████████████",
              //           textAlign: TextAlign.left,
              //           style: TextStyle(
              //               fontFamily: FontFamily.avenirLTStd,
              //               fontSize: 12,
              //               color: Color(0xff242424),
              //               height: 1.5,
              //               fontWeight: FontWeight.bold),
              //         ),
              //       )
              //     : Text(
              //         "Grouu Team",
              //         textAlign: TextAlign.left,
              //         style: TextStyle(
              //             fontFamily: FontFamily.avenirLTStd,
              //             fontSize: 12,
              //             color: Color(0xff242424),
              //             height: 1.5,
              //             fontWeight: FontWeight.bold),
              //       ),
              _articleStore.loading
                  ? Shimmer.fromColors(
                      baseColor: Color(0xff7ad0e2),
                      highlightColor: Colors.white,
                      child: Text(
                        "█████████",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: FontFamily.avenirLTStd,
                            fontSize: 12,
                            color: Color(0xff676767),
                            height: 1.5,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  : Text(
                      WordingUtils.formatDateString(
                          _articleStore.selectedArticle?.date),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontFamily: FontFamily.avenirLTStd,
                          fontSize: 12,
                          color: Color(0xff676767),
                          height: 1.5,
                          fontWeight: FontWeight.normal),
                    ),
            ],
          ),
          Spacer(flex: 1),
          IconButton(
              color: Color(0xFF676767),
              onPressed: () {
                Share.share(
                    '${_articleStore.selectedArticle?.title} : ${Constants.baseWeb}${Endpoints.getArticleWeb}${widget.slug}');
              },
              icon: Icon(IconlyLight.upload)),
        ],
      ),
    );
  }

  _buildArticleTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Observer(
        builder: (BuildContext context) {
          return _articleStore.loading
              ? Shimmer.fromColors(
                  baseColor: Color(0xff7ad0e2),
                  highlightColor: Colors.white,
                  child: Text(
                    "███████████████",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontFamily: FontFamily.avenirLTStd,
                        fontSize: 20,
                        color: Color(0xff242424),
                        height: 1.5,
                        fontWeight: FontWeight.bold),
                  ),
                )
              : Text(
                  _articleStore.selectedArticle?.title ?? "",
                  style: TextStyle(
                      fontFamily: FontFamily.avenirLTStd,
                      fontSize: 20,
                      color: Color(0xff242424),
                      height: 1.5,
                      fontWeight: FontWeight.bold),
                );
        },
      ),
    );
  }

  _buildArticleContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Observer(
            builder: (BuildContext context) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: _articleStore.loading
                    ? Shimmer.fromColors(
                        baseColor: Color(0xff7ad0e2),
                        highlightColor: Colors.white,
                        child: SizedBox(
                          height: 96,
                          width: double.infinity,
                          child: Container(color: Color(0xff7ad0e2)),
                        ))
                    : Image.network(
                        _articleStore.selectedArticle?.imageUrl ?? "",
                        fit: BoxFit.fitHeight,
                        errorBuilder: (context, error, stackTrace) {
                          return SizedBox.shrink();
                        },
                      ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Observer(
            builder: (BuildContext context) {
              if (_articleStore.loading) {
                return Shimmer.fromColors(
                  baseColor: Color(0xff7ad0e2),
                  highlightColor: Colors.white,
                  child: Text(
                    "███████████████████████████████████████████████████████████████████████████ \n█████████████████████████\n█████████████████████████",
                    maxLines: 3,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: FontFamily.avenirLTStd,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Color(0xff3E3C3C),
                    ),
                  ),
                );
              } else {
                dom.Document? document =
                    htmlparser.parse(_articleStore.selectedArticle?.content);
                document.querySelectorAll("[style]").forEach((node) {
                  String? style = node.attributes["style"];
                  List<String> styles = style!.split(";");
                  styles.removeWhere(
                      (style) => style.trim().startsWith("font-family"));
                  styles.removeWhere(
                      (style) => style.trim().startsWith("white-space"));
                  styles.removeWhere(
                      (style) => style.trim().startsWith("margin-top"));
                  styles.removeWhere(
                      (style) => style.trim().startsWith("margin-bottom"));
                  styles.removeWhere(
                      (style) => style.trim().startsWith("line-height"));
                  styles.removeWhere(
                      (style) => style.trim().startsWith("list-style-type"));
                  node.attributes["style"] = styles.join(";");
                });
                return Html.fromDom(
                  document: document,
                  onLinkTap: (url, context, attributes, element) async {
                    if (await canLaunchUrl(Uri.parse(url ?? ""))) {
                      await launchUrl(Uri.parse(url!),
                          mode: LaunchMode.externalApplication);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  tagsList: Html.tags..remove("br"),
                  style: {
                    "body": Style(
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.zero,
                      fontFamily: FontFamily.avenirLTStd,
                      fontSize: FontSize(14),
                    ),
                    // "p": Style(
                    //   fontWeight: FontWeight.normal,
                    //   fontSize: FontSize(14),
                    //   color: Color(0xff242424),
                    //   fontFamily: FontFamily.avenirLTStd,
                    // ),
                    // "ol": Style(
                    //   fontWeight: FontWeight.normal,
                    //   fontSize: FontSize(14),
                    //   color: Color(0xff242424),
                    //   fontFamily: FontFamily.avenirLTStd,
                    // ),
                    // "li": Style(
                    //   fontWeight: FontWeight.bold,
                    //   fontSize: FontSize(12),
                    //   color: Color(0xff242424),

                    //   fontFamily: FontFamily.avenirLTStd,
                    // ),
                  },
                );
              }
            },
          ),
        ),
        Observer(
          builder: (BuildContext context) {
            if (widget.categoryId != null) {
              return HorizontalArticleContent(
                categoryName: "Related Article",
                articleList: _articleStore.articleRelatedList,
                loading: _articleStore.loading,
              );
            } else {
              return Container();
            }
          },
        ),
      ],
    );
  }
}
