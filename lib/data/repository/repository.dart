import 'dart:async';

import 'package:grouu/data/network/apis/article/article_api.dart';
import 'package:grouu/data/sharedpref/shared_preference_helper.dart';

import '../../models/article/article.dart';

class Repository {
  // api objects
  final ArticleApi _articleApi;
  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  Repository(this._sharedPrefsHelper, this._articleApi);

  // Article
  Future<ArticleList?> getArticleList() async {
    return await _articleApi.getArticleList().then((value) {
      return value.data;
    }).catchError((error) {
      throw error;
    });
  }

  Future<ArticleDetail?> getArticleDetail(String slug) async {
    return await _articleApi.getArticleDetail(slug).then((value) {
      return value.data?.articles?.first;
    }).catchError((error) {
      throw error;
    });
  }

  Future<ArticleList?> getArticleSearch(String keyword) async {
    return await _articleApi.getArticleSearch(keyword).then((value) {
      return value.data;
    }).catchError((error) {
      throw error;
    });
  }

  Future<ArticleList?> getArticleHorizontal() async {
    return await _articleApi.getArticleHorizontal().then((value) {
      return value.data;
    }).catchError((error) {
      throw error;
    });
  }

  Future<ArticleCategoryList?> getArticleCategory() async {
    return await _articleApi.getArticleCategory().then((value) {
      return value.data;
    }).catchError((error) {
      throw error;
    });
  }

  Future<ArticleList?> getArticleRelated(int categoryId) async {
    return await _articleApi.getArticleRelated(categoryId).then((value) {
      return value.data;
    }).catchError((error) {
      throw error;
    });
  }

  // Login:---------------------------------------------------------------------
  Future<bool> login(String email, String password) async {
    return await Future.delayed(Duration(seconds: 2), () => true);
  }

  Future<void> saveCurrentUserId(int value) =>
      _sharedPrefsHelper.saveCurrentUserId(value);

  Future<void> saveIsLoggedIn(bool value) =>
      _sharedPrefsHelper.saveIsLoggedIn(value);

  Future<void> saveFirstTimeShowcase(bool value) =>
      _sharedPrefsHelper.saveFirstTimeShowcase(value);

  Future<bool> get isLoggedIn => _sharedPrefsHelper.isLoggedIn;
  Future<int> get currentUserId => _sharedPrefsHelper.currentUserId;
  Future<bool> get isFirstTimeShowcase =>
      _sharedPrefsHelper.isFirstTimeShowcase;

  Future<void> removeAllData() => _sharedPrefsHelper.removeAllData();

  // Theme: --------------------------------------------------------------------
  Future<void> changeBrightnessToDark(bool value) =>
      _sharedPrefsHelper.changeBrightnessToDark(value);

  bool get isDarkMode => _sharedPrefsHelper.isDarkMode;

  // Language: -----------------------------------------------------------------
  Future<void> changeLanguage(String value) =>
      _sharedPrefsHelper.changeLanguage(value);

  String? get currentLanguage => _sharedPrefsHelper.currentLanguage;
}
