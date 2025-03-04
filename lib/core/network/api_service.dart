import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:sprint1/app/constants/api_endpoints.dart';
import 'package:sprint1/core/network/dio_error_interceptor.dart';
import 'package:sprint1/features/home/data/model/product.dart';

class ApiService {
  final Dio _dio;

  Dio get dio => _dio;

  ApiService(this._dio) {
    _dio
      ..options.baseUrl = ApiEndpoints.baseUrl
      ..options.connectTimeout = ApiEndpoints.connectionTimeout
      ..options.receiveTimeout = ApiEndpoints.receiveTimeout
      ..interceptors.add(DioErrorInterceptor())
      ..interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true))
      ..options.headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };
  }

  Future<List<Product>> fetchProducts() async {
    try {
      print('Trying to fetch products from ${dio.options.baseUrl}products');
      final response = await dio.get('/products');
      print('Got response status: ${response.statusCode}');
      print('Got response data: ${response.data}');

      if (response.statusCode != 200) {
        throw Exception(
            'Failed to fetch products: Status code ${response.statusCode}');
      }

      if (response.data is! List) {
        throw Exception(
            'Unexpected response format: Expected a List, got ${response.data.runtimeType}');
      }

      final List<dynamic> data = response.data;
      print(
          'Raw response images: ${data.map((json) => json['image']).toList()}');
      print('Raw response full: ${data.map((json) => json).toList()}');

      final products = data.map((json) {
        try {
          return Product.fromJson(json);
        } catch (e) {
          print('Error parsing product JSON: $json\nError: $e');
          rethrow;
        }
      }).toList();

      print('Parsed products: ${products.map((p) => {
            'name': p.name,
            'image': p.image,
            'imageUrl': p.imageUrl
          }).toList()}');
      return products;
    } on DioException catch (e) {
      print('Dio error fetching products: ${e.message}');
      if (e.response != null) {
        print('Error response data: ${e.response?.data}');
        print('Error status code: ${e.response?.statusCode}');
      }
      throw Exception('Failed to load products: ${e.message}');
    } catch (e, stackTrace) {
      print('Unexpected error fetching products: $e\nStackTrace: $stackTrace');
      throw Exception('Failed to load products: $e');
    }
  }
}
