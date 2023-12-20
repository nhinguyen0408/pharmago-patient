import 'package:injectable/injectable.dart';

@injectable
class EnvironmentConfig {
  // ignore: constant_identifier_names
  static const APP_NAME =
      String.fromEnvironment('DART_DEFINES_APP_NAME', defaultValue: 'Karate');
  // ignore: constant_identifier_names
  static const APP_SUFFIX = String.fromEnvironment('DART_DEFINES_APP_SUFFIX');
  // ignore: constant_identifier_names
  static const BASE_URL_HTTP = String.fromEnvironment('DART_DEFINES_BASE_URL_HTTP');
  // ignore: constant_identifier_names
  static const BASE_URL_GRPC = String.fromEnvironment('DART_DEFINES_BASE_URL_GRPC');
}
