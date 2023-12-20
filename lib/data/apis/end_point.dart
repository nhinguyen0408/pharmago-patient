import 'package:injectable/injectable.dart';
import '../../env/env_config.dart';

@injectable
class Api {
  static String key = 'CHTH';
  static String test = 'my'; // my || on
  static String prod = 'on';

  static String urlGMS = 'https://maps.googleapis.com/maps/api';

  static String baseURL =  EnvironmentConfig.BASE_URL_HTTP;

  static String login = '$baseURL/account/v1/login';
  static String register = '$baseURL/account/v1/register';
  static String verify = '$baseURL/account/v1/verify';

  static String address = '$baseURL/address/v1';
  static String company = '$baseURL/company/v1';
  static String product = '$baseURL/product/v1';

  static String forgotPassword = '$baseURL/account/api/forgot_password/';
  static String verifyPassword = '$baseURL/account/api/verify_forgot/';
  static String resetPassword = '$baseURL/account/api/resetpassword/';
  static String resetOtp = '$baseURL/account/api/reset_otp/';
  static String changePassword = '$baseURL/account/api/changepassword/';
  static String storeInfo = '$baseURL/account/api/account/';
  static String businessType = '$baseURL/shop/api/bussinesstype/';
  static String bankList = '$baseURL/bank/api/bank/';
  static String checkCard = '$baseURL/bank/api/checkcard/';
  static String province = '$baseURL/location/v2/api/province/';
  static String district = '$baseURL/location/v2/api/district/';
  static String ward = '$baseURL/location/v2/api/ward/';
  static String updateStatusAccount = '$baseURL/account/api/admin/updatestatusaccount/';

  static String refreshToken =
      '$baseURL/micro-account/account/api/refresh_token';

  static String customer = '$baseURL/customer/api/customer/';

  static String category = '$baseURL/product/api';
  static String brand = '$baseURL/product/api/productbrand/';
  static String group = '$baseURL/product/api/productgroup/';


  // Product
  static String productDetail = '$baseURL/product/api/productdetail/';
  static String unit = '$baseURL/product/api/unit/';
  static String packaging = '$baseURL/product/api/packaging/';
  static String productBrand = '$baseURL/product/api/productbrand/';
  static String productScan = '$baseURL/product/api/scanproduct';

  // Warehouse
  static String inventoryVoucher = '$baseURL/warehouse/api/inventory_voucher/';

  // static String productCreate =
  //     '$baseURL/micro-product-$env/product/api/create_product';
  static String productCategory = '$baseURL/product/api/productcategory/';
  static String productGroup = '$baseURL/product/api/productgroup/';

  // variant
  static String variant = '$baseURL/product/api/variant/';
  static String variantWarehouse = '$baseURL/warehouse/api/variant_warehouse/';
  static String variantScan = '$baseURL/product/api/scanvariant/';
  static String variantDetail = '$baseURL/product/api/variant/';
  static String variantPromotion = '$baseURL/product/api/variantwithpromotion/';

  // order
  static String order = '$baseURL/order/api/ordercompany/';
  static String orderSystem = '$baseURL/order/api/ordersystem/';
  static String orderCount = '$baseURL/order/api/countorder/';
  static String orderSystemUpdateStatus =
      '$baseURL/order/api/updatestatusordersystem/';
  static String orderUpdateStatus =
      '$baseURL/order/api/updatestatusorder/';
  static String orderQRCodePayment = '$baseURL/order/api/order/qrcodepayment/';
  static String orderSystemCancel = '$baseURL/order/api/cancelordersystem/';

  // card bank
  static String card = '$baseURL/bank/api/card/';

  // card company
  static String checkCodeCompany = '$baseURL/company/api/checkcompany/';
  static String addCompany = '$baseURL/company/api/accountcompany/';

  // promotion
  static String promotionType= '$baseURL/promotion/api/typediscount/';
}
