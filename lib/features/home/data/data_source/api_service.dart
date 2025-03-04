// import 'package:dio/dio.dart';
// import 'package:sprint1/app/constants/api_endpoints.dart';

// import '../model/product.dart';

// class ApiService {
//   final Dio dio;

//   ApiService(this.dio) {
//     dio.options.baseUrl =
//         ApiEndpoints.baseUrl; // Should be "http://localhost:5000/api"
//   }

//   Future<List<Product>> fetchProducts() async {
//     try {
//       print(
//           'Trying to fetch products from ${dio.options.baseUrl}/products'); // Simple debug
//       final response = await dio.get('/products');
//       print('Got response: ${response.data}'); // See what the backend sends
//       final List<dynamic> data = response.data;
//       return data.map((json) => Product.fromJson(json)).toList();
//     } catch (e) {
//       print('Error fetching products: $e'); // See if there’s an error
//       throw Exception('Failed to load products: $e');
//     }
//   }
// }
