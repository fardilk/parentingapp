import 'package:grouu/data/network/apis/article/article_api.dart';
import 'package:grouu/data/network/apis/authentication/authentication_api.dart';
import 'package:grouu/data/network/apis/posts/post_api.dart';
import 'package:grouu/data/network/dio_client.dart';
import 'package:grouu/data/network/rest_client.dart';
import 'package:grouu/data/repository/auth_repository.dart';
import 'package:grouu/data/repository/repository.dart';
import 'package:grouu/data/sharedpref/shared_preference_helper.dart';
import 'package:grouu/data/sqlite/db/database.dart';
import 'package:grouu/di/module/local_module.dart';
import 'package:grouu/di/module/network_module.dart';
import 'package:grouu/stores/article/article_store.dart';
import 'package:grouu/stores/children/children_store.dart';
import 'package:grouu/stores/error/error_store.dart';
import 'package:grouu/stores/form/form_store.dart';
import 'package:grouu/stores/growth/growth_store.dart';
import 'package:grouu/stores/home/home_store.dart';
import 'package:grouu/stores/language/language_store.dart';
import 'package:grouu/stores/milestone/milestone_store.dart';
import 'package:grouu/stores/post/post_store.dart';
import 'package:grouu/stores/preference/preference_store.dart';
import 'package:grouu/stores/theme/theme_store.dart';
import 'package:grouu/stores/user/user_store.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:grouu/stores/vaccine/vaccine_store.dart';
import 'package:http/http.dart';
import 'package:sembast/sembast.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  getIt.registerSingleton(AppDatabase());

  // factories:-----------------------------------------------------------------
  getIt.registerFactory(() => ErrorStore());
  // getIt.registerFactory(() => FormStore());

  // async singletons:----------------------------------------------------------
  getIt.registerSingletonAsync<Database>(() => LocalModule.provideDatabase());
  getIt.registerSingletonAsync<SharedPreferences>(
      () => LocalModule.provideSharedPreferences());

  // singletons:----------------------------------------------------------------
  getIt.registerSingleton(
      SharedPreferenceHelper(await getIt.getAsync<SharedPreferences>()));
  getIt.registerSingleton<Dio>(
      NetworkModule.provideDio(getIt<SharedPreferenceHelper>()));
  getIt.registerSingleton(DioClient(getIt<Dio>()));
  getIt.registerSingleton(RestClient());

  // api's:---------------------------------------------------------------------
  getIt.registerSingleton(PostApi(getIt<DioClient>(), getIt<RestClient>()));
  getIt.registerSingleton(ArticleApi(getIt<DioClient>()));
  getIt.registerSingleton(AuthenticationApi(getIt<DioClient>()));

  // repository:----------------------------------------------------------------
  getIt.registerSingleton(Repository(
    getIt<SharedPreferenceHelper>(),
    getIt<ArticleApi>(),
  ));

  getIt.registerSingleton(AuthRepository(
    getIt<SharedPreferenceHelper>(),
    getIt<AuthenticationApi>(),
  ));

  // stores:--------------------------------------------------------------------
  getIt.registerSingleton(LanguageStore(getIt<Repository>()));
  getIt.registerSingleton(PostStore(getIt<Repository>()));
  getIt.registerSingleton(ThemeStore(getIt<Repository>()));
  getIt.registerSingleton(UserStore(
    getIt<Repository>(),
    getIt<AuthRepository>(),
  ));
  getIt.registerSingleton(FormStore(
    getIt<Repository>(),
    getIt<AuthRepository>(),
  ));
  getIt.registerSingleton(GrowthStore());
  getIt.registerSingleton(VaccineStore());
  getIt.registerSingleton(MilestoneStore());
  getIt.registerSingleton(PreferenceStore());
  getIt.registerSingleton(ChildrenStore());
  getIt.registerSingleton(ArticleStore(getIt<Repository>()));
  getIt.registerSingleton(HomeStore());
}
