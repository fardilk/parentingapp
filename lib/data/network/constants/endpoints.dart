import 'package:grouu/env/env.dart';

class Endpoints {
  Endpoints._();

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 30000;

  // booking endpoints
  static String getPosts = Constants.baseApi + "/posts";

  // authentication
  static String postLogin = Constants.baseAuthApi + "user/login";
  static String postRegister = Constants.baseAuthApi + "user/create";
  static String postVerifyEmail = Constants.baseAuthApi + "user/verify-email";
  static String postLogout = Constants.baseAuthApi + "user/logout";
  static String postVerifyOtp = Constants.baseAuthApi + "user/verify-otp";
  static String postForgotPassword =
      Constants.baseAuthApi + "user/forgot-password";
  static String postVerifyForgotOtp =
      Constants.baseAuthApi + "user/verify-forgot-otp";
  static String postUpdatePassword =
      Constants.baseAuthApi + "user/update-password";
  static String getAllUsers = Constants.baseAuthApi + "user";
  String getUserById(int id) => getAllUsers + id.toString();

  // articles
  static String getArticleList = "v1/get-listartikel";
  static String getArticleDetail = "v1/get-artikelslug";
  static String getArticleSearch = "v1/search-artikel";
  static String getArticleCategory = "v1/list-category-artikel";
  static String getArticleHorizontal = "v1/get-artikel-highlight";
  static String getArticleRelated = "v1/related-article";
  static String getArticleWeb = "artikel/";
}
