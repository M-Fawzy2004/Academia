import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_box/core/const/theme_manager.dart';
import 'package:study_box/core/helper/app_router.dart';
import 'package:study_box/core/localization/localization_manager.dart';
import 'package:study_box/l10n/app_localizations.dart' show AppLocalizations;

class StudyBoxApp extends StatefulWidget {
  const StudyBoxApp({super.key});

  @override
  State<StudyBoxApp> createState() => _StudyBoxAppState();
}

class _StudyBoxAppState extends State<StudyBoxApp> with WidgetsBindingObserver {
  Locale _locale = const Locale('ar');

  @override
  void initState() {
    super.initState();
    ThemeManager.instance.addListener(onThemeChanged);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    ThemeManager.instance.removeListener(onThemeChanged);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    if (ThemeManager.instance.currentTheme == AppThemeMode.system) {
      setState(() {});
    }
  }

  void onThemeChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ThemeManager.instance.getThemeMode();
    final lightTheme = ThemeManager.instance.getCurrentTheme();
    final darkTheme = ThemeManager.instance.getCurrentDarkTheme();
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
          Locale('fr'),
          Locale('es'),
        ],
        builder: (context, child) {
          final localizations = AppLocalizations.of(context);
          if (localizations != null) {
            LocalizationManager.instance.updateLocalizations(localizations);
          }
          return child!;
        },
        locale: _locale,
        theme: lightTheme,
        themeAnimationDuration: const Duration(milliseconds: 300),
        themeAnimationCurve: Curves.easeIn,
        darkTheme: darkTheme,
        themeMode: themeMode,
        key: ValueKey(
          themeMode.toString() + ThemeManager.instance.currentTheme.toString(),
        ),
      ),
    );
  }
}
