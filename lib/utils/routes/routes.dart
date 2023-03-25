import 'package:grouu/ui/articles/articles.dart';
import 'package:grouu/ui/articles/articles_search.dart';
import 'package:grouu/ui/growth/add_growth.dart';
import 'package:grouu/ui/growth/growth_dashboard.dart';
import 'package:grouu/ui/growth/growth_history.dart';
import 'package:grouu/ui/home/home.dart';
import 'package:grouu/ui/milestones/milestone_detail.dart';
import 'package:grouu/ui/notification/notification_screen.dart';
import 'package:grouu/ui/onboarding/onboarding.dart';
import 'package:grouu/ui/profile/account_info.dart';
import 'package:grouu/ui/profile/change_password.dart';
import 'package:grouu/ui/profile/child_info_add.dart';
import 'package:grouu/ui/profile/child_info_edit.dart';
import 'package:grouu/ui/profile/delete_account.dart';
import 'package:grouu/ui/profile/help_support.dart';
import 'package:grouu/ui/profile/preference.dart';
import 'package:grouu/ui/profile/privacy_policy.dart';
import 'package:grouu/ui/register/register.dart';
import 'package:grouu/ui/register/widgets/child_info.dart';
import 'package:grouu/ui/register/widgets/growth_info.dart';
import 'package:grouu/ui/register/widgets/parents_info.dart';
import 'package:grouu/ui/register/widgets/preference.dart';
import 'package:grouu/ui/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:grouu/ui/vaccine/add_vaccination.dart';
import 'package:grouu/ui/vaccine/detail_vaccination.dart';
import 'package:grouu/ui/vaccine/edit_vaccination.dart';
import 'package:grouu/ui/vaccine/search_vaccine.dart';
import 'package:grouu/ui/vaccine/vaccine_screen.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String growth_dashboard = '/growth_dashboard';
  static const String growth_history = '/growth_history';
  static const String notification = '/notification';
  static const String preferences = '/preferences';
  static const String help_support = '/help_support';

  static const String privacy_policy = '/privacy_policy';
  static const String account_info = '/account_info';
  static const String delete_account = '/delete_account';
  static const String child_info_edit = '/child_info_edit';
  static const String child_info_add = '/child_info_add';
  static const String register_parent_info = '/register_parent_info';
  static const String register_child_info = '/register_child_info';
  static const String register_growth_info = '/register_growth_info';
  static const String register_preference = '/register_preference';
  static const String change_password = '/change_password';
  static const String vaccine = '/vaccine';
  static const String add_growth = '/add_growth';
  static const String add_vaccination = '/add_vaccination';
  static const String detail_vaccination = '/detail_vaccination';
  static const String edit_vaccination = '/edit_vaccination';
  static const String search_vaccination = '/search_vaccination';
  static const String milestone_detail = '/milestone_detail';
  static const String article_search = '/article_search';
  static const String article_home = '/article_home';

  static final routes = <String, WidgetBuilder>{
    splash: (BuildContext context) => SplashScreen(),
    onboarding: (BuildContext context) => Onboadring(),
    //login: (BuildContext context) => LoginScreen(),
    register: (BuildContext context) => RegisterScreen(),
    register_parent_info: (BuildContext context) => ParentsInfo(),
    register_child_info: (BuildContext context) => ChildInfo(),
    register_growth_info: (BuildContext context) => GrowthInfo(),
    register_preference: (BuildContext context) => RegisterPreference(),
    home: (BuildContext context) => HomeScreen(),
    growth_dashboard: (BuildContext context) => GrowthDashboard(),
    growth_history: (BuildContext context) => GrowthHistory(),
    notification: (BuildContext context) => NotificationScreen(),
    preferences: (BuildContext context) => PreferenceScreen(),
    help_support: (BuildContext context) => HelpSupportScreen(),
    privacy_policy: (BuildContext context) => PrivacyScreen(),
    change_password: (BuildContext context) => ChangePasswordScreen(),
    account_info: (BuildContext context) => AccountInfo(),
    delete_account: (BuildContext context) => DeleteAccount(),
    child_info_edit: (BuildContext context) => ChildInfoEdit(),
    child_info_add: (BuildContext context) => ChildInfoAdd(),
    vaccine: (BuildContext context) => VaccineScreen(),
    add_growth: (BuildContext context) => AddGrowthScreen(),
    add_vaccination: (BuildContext context) => AddVaccinationScreen(),
    detail_vaccination: (BuildContext context) => DetailVaccinationScreen(),
    edit_vaccination: (BuildContext context) => EditVaccinationScreen(),
    search_vaccination: (BuildContext context) => SearchVaccineScreen(),
    milestone_detail: (BuildContext context) => MilestoneDetailScreen(),
    article_search: (BuildContext context) => ArticleSearch(),
    article_home: (BuildContext context) => ArticlesScreen(),
  };
}
