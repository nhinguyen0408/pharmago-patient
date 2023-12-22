import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../shared/constants/pref_key.dart';
import '../../shared/constants/storage/shared_preference.dart';
import '../di/di.dart';
import '../router/router.dart';
import '../router/router.gr.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appRouter = getIt.get<AppRouter>();

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('vi_VN', null);

    return MaterialApp.router(
      useInheritedMediaQuery: true,
      builder: (context, child) {
        final MediaQueryData data = MediaQuery.of(context);

        return MediaQuery(
          data: data.copyWith(textScaleFactor: 1.0),
          child: child ?? const SizedBox.shrink(),
        );
      },
      // routerConfig: _appRouter.config(),
      routerDelegate: _appRouter.delegate(
        initialRoutes: _mapRouteToPageRouteInfo(),
        // navigatorObservers: () => [AppNavigatorObserver()],
      ),
      routeInformationParser: _appRouter.defaultRouteParser(),
      // title: UiConstants.materialAppTitle,
      // color: UiConstants.taskMenuMaterialAppColor,
      // themeMode: state.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      // theme: lightTheme,
      // darkTheme: darkTheme,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Inter'),
      // localeResolutionCallback: (Locale? locale, Iterable<Locale> supportedLocales) =>
      //     supportedLocales.contains(locale)
      //         ? locale
      //         : const Locale(LocaleConstants.defaultLocale),
      // locale: Locale(state.languageCode.localeCode),
      // supportedLocales: S.delegate.supportedLocales,
      // localizationsDelegates: const [
      //   S.delegate,
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
    );
  }

  List<PageRouteInfo> _mapRouteToPageRouteInfo() {
    final token = AppSharedPreference.instance.getValue(PrefKeys.token);
    if (token == null) {
      return [const LoginRoute()];
    } else {
      return [const HomeRoute()];
    }
  }
}
