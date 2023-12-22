import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';

import 'initializer/app_initializer.dart';
import 'presentation/app/my_app.dart';
import 'presentation/config/app_config.dart';
import 'shared/constants/storage/shared_preference.dart';
import 'shared/utils/log_utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await AppSharedPreference.instance.initSharedPreferences();
  await AppInitializer(AppConfig.getInstance()).init();
  await runZonedGuarded(_runMyApp, _reportError);
}

// Future<LoadInitialResourceOutput> _loadInitialResource() async {
//   final result = runCatching(
//     action: () =>
//         GetIt.instance.get<LoadInitialResourceUseCase>().execute(const LoadInitialResourceInput()),
//   );

//   return result.when(
//     success: (output) => output,
//     failure: (e) => const LoadInitialResourceOutput(),
//   );
// }

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

Future<void> _runMyApp() async {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

void _reportError(Object error, StackTrace stackTrace) {
  Log.e(error, stackTrace: stackTrace, name: 'Uncaught exception');

  // report by Firebase Crashlytics here
}
