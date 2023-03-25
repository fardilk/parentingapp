// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleList _$ArticleListFromJson(Map<String, dynamic> json) => ArticleList(
      articles: (json['articles'] as List<dynamic>?)
          ?.map((e) => Article.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ArticleListToJson(ArticleList instance) =>
    <String, dynamic>{
      'articles': instance.articles,
    };

ArticleCategoryList _$ArticleCategoryListFromJson(Map<String, dynamic> json) =>
    ArticleCategoryList(
      articleCategory: (json['articleCategory'] as List<dynamic>?)
          ?.map((e) => ArticleCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ArticleCategoryListToJson(
        ArticleCategoryList instance) =>
    <String, dynamic>{
      'articleCategory': instance.articleCategory,
    };

ArticleCategory _$ArticleCategoryFromJson(Map<String, dynamic> json) =>
    ArticleCategory(
      categoryId: json['id_category'] as int,
      categoryName: json['category_name'] as String,
      slug: json['slug'] as String,
      articles: (json['articles'] as List<dynamic>?)
          ?.map((e) => Article.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ArticleCategoryToJson(ArticleCategory instance) =>
    <String, dynamic>{
      'id_category': instance.categoryId,
      'category_name': instance.categoryName,
      'slug': instance.slug,
      'articles': instance.articles,
    };

Article _$ArticleFromJson(Map<String, dynamic> json) => Article(
      title: json['artikel_title'] as String,
      date: json['date'] as String?,
      imageUrl: json['img'] as String,
      slug: json['slug'] as String,
      categoryId: json['id_category'] as int?,
    );

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'artikel_title': instance.title,
      'date': instance.date,
      'img': instance.imageUrl,
      'slug': instance.slug,
      'id_category': instance.categoryId,
    };

ArticleDetailList _$ArticleDetailListFromJson(Map<String, dynamic> json) =>
    ArticleDetailList(
      articles: (json['articles'] as List<dynamic>?)
          ?.map((e) => ArticleDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ArticleDetailListToJson(ArticleDetailList instance) =>
    <String, dynamic>{
      'articles': instance.articles,
    };

ArticleDetail _$ArticleDetailFromJson(Map<String, dynamic> json) =>
    ArticleDetail(
      title: json['artikel_title'] as String,
      date: json['date_publish'] as String?,
      imageUrl: json['banner_img'] as String,
      content: json['artikel_content_mobile'] as String,
      tag: json['tag'] as String,
      tagDesc: json['tag_desc'] as String,
    );

Map<String, dynamic> _$ArticleDetailToJson(ArticleDetail instance) =>
    <String, dynamic>{
      'artikel_title': instance.title,
      'artikel_content_mobile': instance.content,
      'date_publish': instance.date,
      'banner_img': instance.imageUrl,
      'tag': instance.tag,
      'tag_desc': instance.tagDesc,
    };
