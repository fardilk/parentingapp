// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ArticleStore on _ArticleStore, Store {
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??=
          Computed<bool>(() => super.loading, name: '_ArticleStore.loading'))
      .value;

  late final _$fetchArticleListFutureAtom =
      Atom(name: '_ArticleStore.fetchArticleListFuture', context: context);

  @override
  ObservableFuture<ArticleList?> get fetchArticleListFuture {
    _$fetchArticleListFutureAtom.reportRead();
    return super.fetchArticleListFuture;
  }

  @override
  set fetchArticleListFuture(ObservableFuture<ArticleList?> value) {
    _$fetchArticleListFutureAtom
        .reportWrite(value, super.fetchArticleListFuture, () {
      super.fetchArticleListFuture = value;
    });
  }

  late final _$fetchArticleDetailFutureAtom =
      Atom(name: '_ArticleStore.fetchArticleDetailFuture', context: context);

  @override
  ObservableFuture<ArticleDetail?> get fetchArticleDetailFuture {
    _$fetchArticleDetailFutureAtom.reportRead();
    return super.fetchArticleDetailFuture;
  }

  @override
  set fetchArticleDetailFuture(ObservableFuture<ArticleDetail?> value) {
    _$fetchArticleDetailFutureAtom
        .reportWrite(value, super.fetchArticleDetailFuture, () {
      super.fetchArticleDetailFuture = value;
    });
  }

  late final _$fetchArticleCategoryFutureAtom =
      Atom(name: '_ArticleStore.fetchArticleCategoryFuture', context: context);

  @override
  ObservableFuture<ArticleCategoryList?> get fetchArticleCategoryFuture {
    _$fetchArticleCategoryFutureAtom.reportRead();
    return super.fetchArticleCategoryFuture;
  }

  @override
  set fetchArticleCategoryFuture(ObservableFuture<ArticleCategoryList?> value) {
    _$fetchArticleCategoryFutureAtom
        .reportWrite(value, super.fetchArticleCategoryFuture, () {
      super.fetchArticleCategoryFuture = value;
    });
  }

  late final _$articleAllListAtom =
      Atom(name: '_ArticleStore.articleAllList', context: context);

  @override
  List<Article>? get articleAllList {
    _$articleAllListAtom.reportRead();
    return super.articleAllList;
  }

  @override
  set articleAllList(List<Article>? value) {
    _$articleAllListAtom.reportWrite(value, super.articleAllList, () {
      super.articleAllList = value;
    });
  }

  late final _$articleHorizontalListAtom =
      Atom(name: '_ArticleStore.articleHorizontalList', context: context);

  @override
  List<Article>? get articleHorizontalList {
    _$articleHorizontalListAtom.reportRead();
    return super.articleHorizontalList;
  }

  @override
  set articleHorizontalList(List<Article>? value) {
    _$articleHorizontalListAtom.reportWrite(value, super.articleHorizontalList,
        () {
      super.articleHorizontalList = value;
    });
  }

  late final _$articleRelatedListAtom =
      Atom(name: '_ArticleStore.articleRelatedList', context: context);

  @override
  List<Article>? get articleRelatedList {
    _$articleRelatedListAtom.reportRead();
    return super.articleRelatedList;
  }

  @override
  set articleRelatedList(List<Article>? value) {
    _$articleRelatedListAtom.reportWrite(value, super.articleRelatedList, () {
      super.articleRelatedList = value;
    });
  }

  late final _$articleSearchListAtom =
      Atom(name: '_ArticleStore.articleSearchList', context: context);

  @override
  List<Article>? get articleSearchList {
    _$articleSearchListAtom.reportRead();
    return super.articleSearchList;
  }

  @override
  set articleSearchList(List<Article>? value) {
    _$articleSearchListAtom.reportWrite(value, super.articleSearchList, () {
      super.articleSearchList = value;
    });
  }

  late final _$articleCategoryListAtom =
      Atom(name: '_ArticleStore.articleCategoryList', context: context);

  @override
  ArticleCategoryList? get articleCategoryList {
    _$articleCategoryListAtom.reportRead();
    return super.articleCategoryList;
  }

  @override
  set articleCategoryList(ArticleCategoryList? value) {
    _$articleCategoryListAtom.reportWrite(value, super.articleCategoryList, () {
      super.articleCategoryList = value;
    });
  }

  late final _$selectedArticleAtom =
      Atom(name: '_ArticleStore.selectedArticle', context: context);

  @override
  ArticleDetail? get selectedArticle {
    _$selectedArticleAtom.reportRead();
    return super.selectedArticle;
  }

  @override
  set selectedArticle(ArticleDetail? value) {
    _$selectedArticleAtom.reportWrite(value, super.selectedArticle, () {
      super.selectedArticle = value;
    });
  }

  late final _$selectedArticleCategoryIdAtom =
      Atom(name: '_ArticleStore.selectedArticleCategoryId', context: context);

  @override
  int get selectedArticleCategoryId {
    _$selectedArticleCategoryIdAtom.reportRead();
    return super.selectedArticleCategoryId;
  }

  @override
  set selectedArticleCategoryId(int value) {
    _$selectedArticleCategoryIdAtom
        .reportWrite(value, super.selectedArticleCategoryId, () {
      super.selectedArticleCategoryId = value;
    });
  }

  late final _$selectedArticleListAtom =
      Atom(name: '_ArticleStore.selectedArticleList', context: context);

  @override
  List<Article>? get selectedArticleList {
    _$selectedArticleListAtom.reportRead();
    return super.selectedArticleList;
  }

  @override
  set selectedArticleList(List<Article>? value) {
    _$selectedArticleListAtom.reportWrite(value, super.selectedArticleList, () {
      super.selectedArticleList = value;
    });
  }

  late final _$successAtom =
      Atom(name: '_ArticleStore.success', context: context);

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  late final _$getArticleListAsyncAction =
      AsyncAction('_ArticleStore.getArticleList', context: context);

  @override
  Future<dynamic> getArticleList() {
    return _$getArticleListAsyncAction.run(() => super.getArticleList());
  }

  late final _$getArticleDetailAsyncAction =
      AsyncAction('_ArticleStore.getArticleDetail', context: context);

  @override
  Future<dynamic> getArticleDetail(String slug) {
    return _$getArticleDetailAsyncAction
        .run(() => super.getArticleDetail(slug));
  }

  late final _$getArticleSearchAsyncAction =
      AsyncAction('_ArticleStore.getArticleSearch', context: context);

  @override
  Future<dynamic> getArticleSearch(String keyword) {
    return _$getArticleSearchAsyncAction
        .run(() => super.getArticleSearch(keyword));
  }

  late final _$getArticleHorizontalAsyncAction =
      AsyncAction('_ArticleStore.getArticleHorizontal', context: context);

  @override
  Future<dynamic> getArticleHorizontal() {
    return _$getArticleHorizontalAsyncAction
        .run(() => super.getArticleHorizontal());
  }

  late final _$getArticleCategoryAsyncAction =
      AsyncAction('_ArticleStore.getArticleCategory', context: context);

  @override
  Future<dynamic> getArticleCategory() {
    return _$getArticleCategoryAsyncAction
        .run(() => super.getArticleCategory());
  }

  late final _$getArticleRelatedAsyncAction =
      AsyncAction('_ArticleStore.getArticleRelated', context: context);

  @override
  Future<dynamic> getArticleRelated(int categoryId) {
    return _$getArticleRelatedAsyncAction
        .run(() => super.getArticleRelated(categoryId));
  }

  late final _$setArticleDetailAsyncAction =
      AsyncAction('_ArticleStore.setArticleDetail', context: context);

  @override
  Future<dynamic> setArticleDetail(String title, String content) {
    return _$setArticleDetailAsyncAction
        .run(() => super.setArticleDetail(title, content));
  }

  late final _$_ArticleStoreActionController =
      ActionController(name: '_ArticleStore', context: context);

  @override
  void setArticleCategoryId(ArticleCategory articleCategory) {
    final _$actionInfo = _$_ArticleStoreActionController.startAction(
        name: '_ArticleStore.setArticleCategoryId');
    try {
      return super.setArticleCategoryId(articleCategory);
    } finally {
      _$_ArticleStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic getSelectedArticleCategory() {
    final _$actionInfo = _$_ArticleStoreActionController.startAction(
        name: '_ArticleStore.getSelectedArticleCategory');
    try {
      return super.getSelectedArticleCategory();
    } finally {
      _$_ArticleStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
fetchArticleListFuture: ${fetchArticleListFuture},
fetchArticleDetailFuture: ${fetchArticleDetailFuture},
fetchArticleCategoryFuture: ${fetchArticleCategoryFuture},
articleAllList: ${articleAllList},
articleHorizontalList: ${articleHorizontalList},
articleRelatedList: ${articleRelatedList},
articleSearchList: ${articleSearchList},
articleCategoryList: ${articleCategoryList},
selectedArticle: ${selectedArticle},
selectedArticleCategoryId: ${selectedArticleCategoryId},
selectedArticleList: ${selectedArticleList},
success: ${success},
loading: ${loading}
    ''';
  }
}
