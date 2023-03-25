import 'package:grouu/data/network/constants/endpoints.dart';
import 'package:grouu/data/network/dio_client.dart';
import 'package:grouu/data/network/rest_client.dart';
import 'package:grouu/models/article/article.dart';
import 'package:grouu/models/base/base_response.dart';

class ArticleApi {
  final DioClient _dioClient;

  ArticleApi(this._dioClient);

  Future<BaseResponse<ArticleList>> getArticleList() async {
    try {
      final response = await _dioClient.get(Endpoints.getArticleList);
      return BaseResponse.fromJson(
        response,
        (data) {
          return ArticleList.fromJson(data as List<dynamic>);
        },
      );
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<BaseResponse<ArticleDetailList>> getArticleDetail(String slug) async {
    try {
      final response = await _dioClient.get(
        Endpoints.getArticleDetail,
        queryParameters: {'slug': slug},
      );
      return BaseResponse.fromJson(
        response,
        (data) {
          return ArticleDetailList.fromJson(data as List<dynamic>);
        },
      );
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<BaseResponse<ArticleList>> getArticleSearch(String keyword) async {
    try {
      final response = await _dioClient.get(
        Endpoints.getArticleSearch,
        queryParameters: {'keyword': keyword},
      );
      return BaseResponse.fromJson(
        response,
        (data) {
          return ArticleList.fromJson(data as List<dynamic>);
        },
      );
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<BaseResponse<ArticleList>> getArticleHorizontal() async {
    try {
      final response = await _dioClient.get(
        Endpoints.getArticleHorizontal,
        queryParameters: {'limit': 10},
      );
      return BaseResponse.fromJson(
        response,
        (data) {
          return ArticleList.fromJson(data as List<dynamic>);
        },
      );
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<BaseResponse<ArticleCategoryList>> getArticleCategory() async {
    try {
      final response = await _dioClient.get(
        Endpoints.getArticleCategory,
      );
      return BaseResponse.fromJson(
        response,
        (data) {
          return ArticleCategoryList.fromJson(data as List<dynamic>);
        },
      );
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<BaseResponse<ArticleList>> getArticleRelated(int categoryId) async {
    try {
      final response = await _dioClient.get(
        Endpoints.getArticleRelated,
        queryParameters: {"category_id": categoryId},
      );
      return BaseResponse.fromJson(
        response,
        (data) {
          return ArticleList.fromJson(data as List<dynamic>);
        },
      );
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
