import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'router.gr.dart';

@injectable
@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [

    // ========== Authentication ===========
    // AutoRoute(page: WelcomeRoute.page),
    // AutoRoute(page: LoginRoute.page),
    // AutoRoute(page: RegisterRoute.page),
    // AutoRoute(page: VerifyAccountRoute.page),
    // AutoRoute(page: TypeAccountRoute.page),

    // // ========== Company
    // AutoRoute(page: CreateCompanyRoute.page),
    // AutoRoute(page: WorkSpaceRoute.page),

    // AutoRoute(page: HomeRoute.page),


    // // =========== Product ===========
    // AutoRoute(page: ProductDetailRoute.page),
    // AutoRoute(page: ProductCreateRoute.page),

    // // =========== Product ===========
    // AutoRoute(page: OrderCreateRoute.page)
  ];
}