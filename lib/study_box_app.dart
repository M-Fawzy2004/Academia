import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/app_router.dart';
import 'package:study_box/core/theme/app_color.dart';

class StudyBoxApp extends StatelessWidget {
  const StudyBoxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'fontApp',
          brightness: Brightness.light,
          primaryColor: AppColors.primaryColor,
          scaffoldBackgroundColor: AppColors.grey,
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.grey,
            foregroundColor: AppColors.black,
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark,
            ),
          ),
        ),
        darkTheme: ThemeData(
          fontFamily: 'fontApp',
          brightness: Brightness.dark,
          primaryColor: AppColors.darkPrimaryColor,
          scaffoldBackgroundColor: AppColors.darkBackgroundColor,
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.darkBackgroundColor,
            foregroundColor: AppColors.white,
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light,
            ),
          ),
        ),
        themeMode: ThemeMode.system,
      ),
    );
  }
}
