import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/helper/app_router.dart';
import 'package:study_box/core/localization/localization_manager.dart';
import 'package:study_box/core/theme/app_color.dart';
import 'package:study_box/l10n/app_localizations.dart' show AppLocalizations;

class StudyBoxApp extends StatefulWidget {
  const StudyBoxApp({super.key});

  @override
  State<StudyBoxApp> createState() => _StudyBoxAppState();
}

class _StudyBoxAppState extends State<StudyBoxApp> {
  Locale _locale = const Locale('en');

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('ar'),
        ],
        builder: (context, child) {
          final localizations = AppLocalizations.of(context);
          if (localizations != null) {
            LocalizationManager.instance.updateLocalizations(localizations);
          }
          return child!;
        },
        locale: _locale,
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
