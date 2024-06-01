import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:using_dio/core/exceptions/repository_exception.dart';
import 'package:using_dio/core/dio/custom_dio.dart';
import 'package:using_dio/models/movies.dart';
import 'movies_repository.dart';

class MoviesRepositoryCustomDioImpl implements MoviesRepository {
  @override
  Future<Movies> findPopularMovies() async {
    try {
      final apiKey = dotenv.env['apiKey'] ?? '';
      final dio = CustomDio();
      final result = await dio.get(
        '/movie/popular',
        queryParameters: {
          'api_key': apiKey,
          'language': 'pt-BR',
        },
      );
      debugPrint('Timer: ${result.data['execution_time']}');
      return Movies.fromMap(result.data);
    } on DioException catch (e, s) {
      log('Error findPopularMovies:', error: e, stackTrace: s);
      throw RepositoryException();
    }
  }

  @override
  Future<Movies> findTopRatedMovies() async {
    try {
      final apiKey = dotenv.env['apiKey'] ?? '';
      final dio = CustomDio();
      final result = await dio.get(
        '/movie/top_rated',
        queryParameters: {
          'api_key': apiKey,
          'language': 'pt-BR',
        },
      );
      return Movies.fromMap(result.data);
    } on DioException catch (e, s) {
      log('Error findTopRatedMovies:', error: e, stackTrace: s);
      throw RepositoryException();
    }
  }
}
