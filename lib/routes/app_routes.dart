import 'package:final_poject_sw_engineering/module/adminDashboard/admin_dashboard_screen.dart';
import 'package:final_poject_sw_engineering/module/home/home_screen.dart';
import 'package:final_poject_sw_engineering/module/mainNav/bottom_navbar.dart';
import 'package:final_poject_sw_engineering/module/noConnection/no_connection_screen.dart';
import 'package:final_poject_sw_engineering/module/profile/profile_screen.dart';
import 'package:final_poject_sw_engineering/module/register/register_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import '../module/login/login_screen.dart';
import '../module/mainSellerTabs/main_seller_screen.dart';


class AppRoutes {
  AppRoutes._();

  static final String splashScreen = '/';
  static final String homeScreen = '/homeScreen';
  static final String loginScreen = '/loginScreen';
  static final String registerScreen = '/registerScreen';
  static final String profileScreen = '/profileScreen';
  static final String bottomNavScreen = '/bottomNavScreen';
  static final String adminDashboardScreen = '/adminDashboardScreen';
  static final String sellerDashboard = '/sellerDashboard';
  static final String noConnectionScreen = '/noConnectionScreen';
  static final String complaintScreen = '/complaintScreen';





  static List<GetPage<dynamic>> get getPages => [
    GetPage(name: loginScreen, page: () => LoginScreen()),
    GetPage(name: registerScreen, page: () => RegisterScreen()),
    GetPage(name: homeScreen, page: () => HomeScreen()),
    GetPage(name: profileScreen, page: () => ProfileScreen()),
    GetPage(name: bottomNavScreen, page: () => BottomNavbarScreen()),
    GetPage(name: adminDashboardScreen, page: () => AdminDashboardScreen()),
    GetPage(name: sellerDashboard, page: () => MainSellerScreen()),
    GetPage(name: noConnectionScreen, page: () => NoConnectionScreen()),



    // GetPage(name: splashScreen, page: () => SplashScreen()),
  ];
}
