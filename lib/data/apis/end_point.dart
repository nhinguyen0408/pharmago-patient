import 'package:injectable/injectable.dart';
import '../../env/env_config.dart';

@injectable
class Api {
  static String key = 'CHTH';
  static String test = 'my'; // my || on
  static String prod = 'on';

  static String urlGMS = 'https://maps.googleapis.com/maps/api';

  static String baseURL =  EnvironmentConfig.BASE_URL_HTTP;

  static String login = '$baseURL/api/account/v1/login/';
  static String register = '$baseURL/api/account/v1/register/';
  static String activate = '$baseURL/api/account/v1/activate/';
  static String reSendOTP = '$baseURL/api/account/v1/re-send-otp/';
  static String persionalProfile = '$baseURL/api/account/v1/profile/';
  static String checkFieldExist = '$baseURL/api/account/v1/check-exist/';

  static String refreshToken = '$baseURL/api/account/v1/refreshToken';

  // Drugstore
  static String drugstoreList = '$baseURL/api/v1/workspaces/';

  // Product
  static String productList = '$baseURL/api/v1/products/';
  static String variantList = '$baseURL/api/v1/variants/';

  // Cart
  static String cart = '$baseURL/api/v1/cart-items/';

  // Address
  static String address = '$baseURL/v1/api/address/';
  static String province = '$baseURL/v1/api/province/';
  static String district = '$baseURL/v1/api/district/';
  static String ward = '$baseURL/v1/api/ward/';


  // Order
  static String order = '$baseURL/api/v1/orders/';
  static String updateStatusOrder = '$baseURL/api/v1/orders-status/';
  static String checkVariantInStock = '$baseURL/api/v1/check-order/';
}
