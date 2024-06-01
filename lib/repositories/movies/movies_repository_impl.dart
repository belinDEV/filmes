import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:using_dio/core/dio/custom_dio.dart';
import 'package:using_dio/core/exceptions/repository_exception.dart';
import 'package:using_dio/models/movies.dart';
import 'movies_repository.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  @override
  Future<Movies> findPopularMovies() async {
    try {
      final dio = CustomDio();
      final result = await dio.auth().get('/movie/popular');
      debugPrint('CustomDio Result: ${result.data}');
      return Movies.fromMap(result.data);
    } on DioException catch (e, s) {
      log('Error findPopularMovies:', error: e, stackTrace: s);
      throw RepositoryException();
    }
  }

  @override
  Future<Movies> findTopRatedMovies() async {
    try {
      final dio = CustomDio();
      final result = await dio.auth().get('/movie/top_rated');
      debugPrint('CustomDio Result: ${result.data}');
      return Movies.fromMap(result.data);
    } on DioException catch (e, s) {
      log('Error findTopRatedMovies:', error: e, stackTrace: s);
      throw RepositoryException();
    }
  }
}
