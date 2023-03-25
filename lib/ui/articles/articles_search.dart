import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:grouu/models/article/article.dart';
import 'package:grouu/stores/article/article_store.dart';
import 'package:iconly/iconly.dart';

import '../../di/components/service_locator.dart';
import '../../widgets/back_appbar_widget.dart';
import '../../widgets/progress_indicator_widget.dart';
import '../../widgets/rounded_button_widget.dart';
import '../../widgets/textfield_widget.dart';
import '../home/widgets/home_article_content.dart';
import '../vaccine/styles/vaccine_styles.dart';

class ArticleSearch extends StatefulWidget {
  const ArticleSearch({super.key});

  @override
  State<ArticleSearch> createState() => _ArticleSearchState();
}

class _ArticleSearchState extends State<ArticleSearch> {
  TextEditingController _searchController = TextEditingController();
  ArticleStore _articleStore = getIt<ArticleStore>();

  @override
  void dispose() {
    super.dispose();
    _articleStore.disposeSearchArticle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEFBFE),
      appBar: BackAppBar(title: _buildSearchField()),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                _buildSearchBody(),
              ],
            ),
          ),
          Observer(
            builder: (context) {
              return Visibility(
                  visible: _articleStore.loading,
                  child: CustomProgressIndicatorWidget());
            },
          ),
        ],
      ),
    );
  }

  _buildSearchField() {
    return Observer(builder: (context) {
      return TextFieldWidget(
        contentPadding: EdgeInsets.zero,
        hint: "Cari artikel",
        errorText: null,
        inputAction: TextInputAction.search,
        textController: _searchController,
        prefixIcon: IconlyLight.search,
        fillColor: Colors.white,
        autoFocus: true,
        onChanged: (value) {},
        onFieldSubmitted: (value) {
          _articleStore.getArticleSearch(value);
        },
      );
    });
  }

  _buildSearchBody() {
    return Observer(
      builder: ((context) {
        if (_articleStore.articleSearchList == null) {
          return _buildNotFound();
        } else {
          List<Article> articles =
              _articleStore.articleSearchList?.map((e) => e).toList() ?? [];
          if (articles.isEmpty) {
            return _buildNotFound();
          } else {
            return HomeArticleContent(
              articleList: _articleStore.articleSearchList,
              forHomeContent: false,
              loading: _articleStore.loading,
            );
          }
        }
      }),
    );
  }

  Column _buildNotFound() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset("assets/images/eating_grouu_together.png"),
        Text("Pencarian tidak ditemukan", style: VaccineStyles.bold),
        SizedBox(height: 16),
        Text(
          "Artikel yang kamu cari tidak ada.",
          style: VaccineStyles.mediumGray,
        ),
        SizedBox(height: 24),
        RoundedButtonWidget(
            buttonText: "Kembali",
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ],
    );
  }
}
