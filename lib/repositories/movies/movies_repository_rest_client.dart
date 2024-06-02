import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:using_dio/core/exceptions/repository_exception.dart';
import 'package:using_dio/core/rest_client/rest_client.dart';
import 'package:using_dio/models/movies.dart';
import 'movies_repository.dart';

class MoviesRepositoryRestClient implements MoviesRepository {
  final RestClient _restClient;

  MoviesRepositoryRestClient({
    required RestClient restClient,
  }) : _restClient = restClient;

  @override
  Future<Movies> findPopularMovies() async {
    try {
      final result = await _restClient.auth().get('/movie/popular');
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
      final result = await _restClient.auth().get('/movie/top_rated');
      return Movies.fromMap(result.data);
    } on DioException catch (e, s) {
      log('Error findTopRatedMovies:', error: e, stackTrace: s);
      throw RepositoryException();
    }
  }
}
