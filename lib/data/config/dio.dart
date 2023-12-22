import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../shared/constants/pref_key.dart';
import '../../shared/constants/storage/shared_preference.dart';
import '../apis/end_point.dart';
import 'dio_logger.dart';

@injectable
class BaseDio {
  // khởi tạo biến
  Dio? _instance;

  //method for getting dio instance
  Dio dio() {
    _instance = createDioInstance();
    return _instance!;
  }

  Dio createDioInstance() {
    late Dio dio;
    final token = AppSharedPreference.instance.getValue(PrefKeys.token);
    if (token == null) {
      dio = Dio(
        BaseOptions(
          headers: {
            'Content-Type': 'application/json',
            'accept': 'application/json',
          },
        ),
      );
    } else {
      dio = Dio(
        BaseOptions(
          headers: {
            'authorization': 'Token $token',
            'content-Type': 'application/json',
            'accept': 'application/json',
          },
        ),
      );
    }

    // (dio.httpClientAdapter as HttpClientAdapter).createHttpClient = () =>
    //   HttpClient()
    //     ..badCertificateCallback =
    //         (X509Certificate cert, String host, int port) => true;

    // dio.options.connectTimeout = 5;
    // dio.options.receiveTimeout = 5;
    dio.interceptors.clear();
    dio.interceptors.addAll([
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers.forEach((key, value) {
            print('$key: $value');
          });
          // print(AppSharedPreference.instance.getValue(PrefKeys.TOKEN));
          // print(AppSharedPreference.instance.getValue(PrefKeys.TOKEN_REFRESH));
          return handler.next(options);
        },
        onResponse: (response, handler) {
          //on success it is getting called here
          return handler.next(response);
        },
        onError: (error, handler) async {
          print(error);
          if (error.response?.statusCode == 401 ||
              error.response?.statusCode == 403) {
            // final accessToken = await _getNewToken();

            // // Cập nhật token trong bộ nhớ đệm
            // _saveTokenToStorage(accessToken);

            // // Thử lại yêu cầu gốc
            // final RequestOptions requestOptions = error.requestOptions;
            // final opts = Options(method: requestOptions.method);
            // dio.options.headers['Authorization'] = 'Token $accessToken';
            // dio.options.headers['Accept'] = '*/*';
            // final response = await dio.request(
            //   requestOptions.path,
            //   options: opts,
            //   cancelToken: requestOptions.cancelToken,
            //   onReceiveProgress: requestOptions.onReceiveProgress,
            //   data: requestOptions.data,
            //   queryParameters: requestOptions.queryParameters,
            // );
            // handler.resolve(response);
          } else {
            handler.next(error);
          }
        },
      ),
      PrettyDioLogger(requestBody: true)
    ]);
    return dio;
  }

  Future<String> _getNewToken() async {
    try {
      final payload = {
        'refresh':
            '${AppSharedPreference.instance.getValue(PrefKeys.tokenRefresh)}'
      };
      final res = await Dio(
        BaseOptions(
          headers: {
            'Content-Type': 'application/json',
            'accept': 'application/json',
          },
        ),
      ).post(Api.refreshToken, data: payload);
      return res.data['access'];
    } catch (e) {
      throw Exception('err : $e');
    }
  }

  void _saveTokenToStorage(String token) {
    AppSharedPreference.instance.setValue(PrefKeys.token, token);
  }

// var dio = Dio(
//   BaseOptions(
//     headers: {
//       "authorization":
//           "Token ${AppSharedPreference.instance.getValue(PrefKeys.TOKEN)}",
//       "content-Type": "application/json",
//       "accept": "application/json",
//     },
//   ),
// );
}
