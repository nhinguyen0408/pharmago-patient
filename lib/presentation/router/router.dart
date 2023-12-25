import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'router.gr.dart';

@injectable
@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
    // ========== Authentication ===========
    AutoRoute(page: LoginRoute.page), 
    AutoRoute(page: RegisterRoute.page),
    AutoRoute(page: VerifyAccountRoute.page),

    // Home Page
    AutoRoute(page: HomeRoute.page),

    // Health
    AutoRoute(page: HealthRecordRoute.page),

    // Drugstore
    AutoRoute(page: DrugstoreRoute.page),
    AutoRoute(page: DrugstoreDetailRoute.page),

    //Personal
    AutoRoute(page: PersionalRoute.page),
  ];
}