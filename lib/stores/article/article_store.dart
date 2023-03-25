import 'package:grouu/models/article/article.dart';
import 'package:grouu/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';

import '../../data/repository/repository.dart';
import '../error/error_store.dart';

part 'article_store.g.dart';

class ArticleStore = _ArticleStore with _$ArticleStore;

abstract class _ArticleStore with Store {
  // repository instance
  late Repository _repository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();

  _ArticleStore(Repository repository) {
    _setupDisposers();
    this._repository = repository;
  }
  late List<ReactionDisposer> _disposers;
  void _setupDisposers() {
    _disposers = [
      reaction((_) => success, (_) => success = false, delay: 200),
    ];
  }

  static ObservableFuture<ArticleList?> emptyArticleListResponse =
      ObservableFuture.value(null);

  static ObservableFuture<ArticleDetail?> emptyArticleDetailResponse =
      ObservableFuture.value(null);

  static ObservableFuture<ArticleCategoryList?>
      emptyArticleCategoryListResponse = ObservableFuture.value(null);

  @observable
  ObservableFuture<ArticleList?> fetchArticleListFuture =
      ObservableFuture<ArticleList?>(emptyArticleListResponse);

  @observable
  ObservableFuture<ArticleDetail?> fetchArticleDetailFuture =
      ObservableFuture<ArticleDetail?>(emptyArticleDetailResponse);

  @observable
  ObservableFuture<ArticleCategoryList?> fetchArticleCategoryFuture =
      ObservableFuture<ArticleCategoryList?>(emptyArticleCategoryListResponse);

  @observable
  List<Article>? articleAllList;

  @observable
  List<Article>? articleHorizontalList;

  @observable
  List<Article>? articleRelatedList;

  @observable
  List<Article>? articleSearchList;

  @observable
  ArticleCategoryList? articleCategoryList;

  @observable
  ArticleDetail? selectedArticle;

  @observable
  int selectedArticleCategoryId = -1;

  @observable
  List<Article>? selectedArticleList;

  @observable
  bool success = false;

  @computed
  bool get loading =>
      fetchArticleListFuture.status == FutureStatus.pending ||
      fetchArticleDetailFuture.status == FutureStatus.pending ||
      fetchArticleCategoryFuture.status == FutureStatus.pending;

  @action
  Future getArticleList() async {
    final future = _repository.getArticleList();
    fetchArticleListFuture = ObservableFuture(future);

    future.then((value) {
      this.articleAllList = value?.articles;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future getArticleDetail(String slug) async {
    final future = _repository.getArticleDetail(slug);
    fetchArticleDetailFuture = ObservableFuture(future);

    future.then((value) {
      return this.selectedArticle = value;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future getArticleSearch(String keyword) async {
    final future = _repository.getArticleSearch(keyword);
    fetchArticleListFuture = ObservableFuture(future);

    future.then((value) {
      return this.articleSearchList = value?.articles;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future getArticleHorizontal() async {
    final future = _repository.getArticleHorizontal();
    fetchArticleListFuture = ObservableFuture(future);

    future.then((value) {
      return this.articleHorizontalList = value?.articles;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future getArticleCategory() async {
    final future = _repository.getArticleCategory();
    fetchArticleCategoryFuture = ObservableFuture(future);

    future.then((value) {
      this.articleCategoryList = value;
      this.selectedArticleCategoryId =
          value?.articleCategory?.first.categoryId ?? -1;
      this.selectedArticleList = value?.articleCategory?.first.articles;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future getArticleRelated(int categoryId) async {
    final future = _repository.getArticleRelated(categoryId);
    fetchArticleListFuture = ObservableFuture(future);

    future.then((value) {
      return this.articleRelatedList = value?.articles;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  void setArticleCategoryId(ArticleCategory articleCategory) {
    selectedArticleCategoryId = articleCategory.categoryId;
    selectedArticleList = articleCategory.articles;
  }

  @action
  Future setArticleDetail(String title, String content) async {
    return this.selectedArticle = ArticleDetail(
        title: title,
        date: "",
        imageUrl: "",
        content: content,
        tag: "",
        tagDesc: "");
  }

  @action
  getSelectedArticleCategory() {}

  void dispose() {
    for (final d in _disposers) {
      d();
    }
    articleAllList = null;
    articleCategoryList = null;
    articleCategoryList = null;
    articleRelatedList = null;
    articleHorizontalList = null;
    articleSearchList = null;
  }

  void disposeSelectedArticle() {
    selectedArticle = null;
  }

  void disposeSearchArticle() {
    articleSearchList = null;
  }
}
