import 'package:dio/dio.dart';

class NetworkException implements Exception {
  final DioException dioException;

  NetworkException({required this.dioException});
}
