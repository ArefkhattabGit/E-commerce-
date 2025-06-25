import 'package:final_poject_sw_engineering/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'app/app_colors.dart';
import 'app/app_config.dart';
import 'app/app_constatns.dart';
import 'di/app_bindings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await ScreenUtil.ensureScreenSize();
  await AppConfig.init();

  final token = AppConfig.getString(AppConstants.USER_TOKEN);
  final role = AppConfig.getString(AppConstants.USER_ROLE);

  print('===> token on startup: $token');
  print('===> role on startup: $role');

  runApp(MyApp(token: token, role: role));
}

class MyApp extends StatelessWidget {
  final String? token;
  final String? role;

  const MyApp({super.key, required this.token, required this.role});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: MediaQueryData.fromView(WidgetsBinding.instance.window).size.width > 600
          ? const Size(1200, 800) // Web/Desktop size
          : const Size(430, 932), // Mobile size
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.ltr, // Set the desired direction here
          child: GetMaterialApp(
            locale: const Locale('en'),
            theme: ThemeData(
              scaffoldBackgroundColor: AppColors.white,
              textTheme: Theme.of(context).textTheme.apply(
                fontSizeFactor: MediaQueryData.fromView(WidgetsBinding.instance.window).size.width > 600
                    ? 1.0
                    : 1.sp,
              ),
            ),
            debugShowCheckedModeBanner: false,
            title: 'Ecommerce',
            initialBinding: AppBindings(),
            initialRoute: token == null
                ? AppRoutes.loginScreen
                : role == 'admin'
                ? AppRoutes.adminDashboardScreen
                : role == 'seller'
                ? AppRoutes.sellerDashboard
                : AppRoutes.bottomNavScreen,
            getPages: AppRoutes.getPages,
          ),
        );
      },
    );
  }
}
