import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'interceptors/auth_interceptor.dart';
import 'interceptors/time_execution_interceptor.dart';

class CustomDio extends DioForNative {
  static final _baseOptions = BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3/',
    connectTimeout: const Duration(seconds: 60),
    receiveTimeout: const Duration(seconds: 60),
  );

  CustomDio() : super(_baseOptions) {
    interceptors.addAll(
      [
        TimeExecutionInterceptor(),
        AuthInterceptor(),
        PrettyDioLogger(),
      ],
    );
  }

  CustomDio auth() {
    options.extra['auth_required'] = true;
    return this;
  }
}
