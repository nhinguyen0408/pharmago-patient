import 'package:pharmago_patient/data/models/base/response.dart';
import 'package:pharmago_patient/presentation/views/cart/data/models/cart_model.dart';
import 'package:pharmago_patient/presentation/views/cart/data/models/cart_payload_model.dart';

abstract class CartRepository {
  Future<BaseResponseModel<List<CartModel>>> getCart();
  Future<BaseResponseModel<CartModel?>> addCart({ required CartPayloadModel data });
  Future<BaseResponseModel<CartModel?>> deleteCart({ required CartPayloadModel data });
}