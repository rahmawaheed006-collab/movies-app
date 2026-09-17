import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class MoviesApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://movies-api.accel.li/api/v2',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  Future<List<String>> fetchPosterUrls({int limit = 12}) async {
    try {
      final response = await _dio.get('/list_movies.json', queryParameters: {
        'limit': limit,
        'sort_by': 'download_count',
      });

      final movies = response.data['data']['movies'] as List<dynamic>? ?? [];

      if (movies.isEmpty && kDebugMode) {
        // ignore: avoid_print
        print('⚠️ MoviesApiService: API returned an empty movies list. Full response: ${response.data}');
      }

      return movies
          .map((movie) => movie['large_cover_image'] as String?)
          .whereType<String>()
          .toList();
    } catch (e, stackTrace) {
      if (kDebugMode) {
        // ignore: avoid_print
        print('❌ MoviesApiService error: $e');
        print(stackTrace);
      }
      return [];
    }
  }
}