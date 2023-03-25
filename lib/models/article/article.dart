import 'package:json_annotation/json_annotation.dart';

part 'article.g.dart';

@JsonSerializable()
class ArticleList {
  late final List<Article>? articles;

  ArticleList({this.articles});

  factory ArticleList.fromJson(List<dynamic> json) {
    List<Article> articles = <Article>[];
    articles = json.map((article) => Article.fromJson(article)).toList();

    return ArticleList(
      articles: articles,
    );
  }

  Map<String, dynamic> toJson() => _$ArticleListToJson(this);
}

@JsonSerializable()
class ArticleCategoryList {
  final List<ArticleCategory>? articleCategory;

  ArticleCategoryList({this.articleCategory});

  factory ArticleCategoryList.fromJson(List<dynamic> json) {
    List<ArticleCategory> articleCategory = <ArticleCategory>[];
    articleCategory =
        json.map((article) => ArticleCategory.fromJson(article)).toList();

    return ArticleCategoryList(
      articleCategory: articleCategory,
    );
  }

  Map<String, dynamic> toJson() => _$ArticleCategoryListToJson(this);
}

@JsonSerializable()
class ArticleCategory {
  @JsonKey(name: 'id_category')
  final int categoryId;
  @JsonKey(name: 'category_name')
  final String categoryName;
  @JsonKey(name: 'slug')
  final String slug;
  final List<Article>? articles;

  ArticleCategory({
    required this.categoryId,
    required this.categoryName,
    required this.slug,
    this.articles,
  });

  factory ArticleCategory.fromJson(Map<String, dynamic> json) =>
      _$ArticleCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleCategoryToJson(this);
}

@JsonSerializable()
class Article {
  @JsonKey(name: 'artikel_title')
  final String title;
  final String? date;
  @JsonKey(name: 'img')
  final String imageUrl;
  final String slug;
  @JsonKey(name: 'id_category')
  final int? categoryId;

  Article({
    required this.title,
    required this.date,
    required this.imageUrl,
    required this.slug,
    this.categoryId,
  });

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}

@JsonSerializable()
class ArticleDetailList {
  final List<ArticleDetail>? articles;

  ArticleDetailList({this.articles});

  factory ArticleDetailList.fromJson(List<dynamic> json) {
    List<ArticleDetail> articles = <ArticleDetail>[];
    articles = json.map((article) => ArticleDetail.fromJson(article)).toList();

    return ArticleDetailList(
      articles: articles,
    );
  }

  Map<String, dynamic> toJson() => _$ArticleDetailListToJson(this);
}

@JsonSerializable()
class ArticleDetail {
  @JsonKey(name: 'artikel_title')
  final String title;
  @JsonKey(name: 'artikel_content_mobile')
  final String content;
  @JsonKey(name: 'date_publish')
  final String? date;
  @JsonKey(name: 'banner_img')
  final String imageUrl;
  final String tag;
  @JsonKey(name: 'tag_desc')
  final String tagDesc;

  ArticleDetail({
    required this.title,
    required this.date,
    required this.imageUrl,
    required this.content,
    required this.tag,
    required this.tagDesc,
  });

  factory ArticleDetail.fromJson(Map<String, dynamic> json) =>
      _$ArticleDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleDetailToJson(this);
}
