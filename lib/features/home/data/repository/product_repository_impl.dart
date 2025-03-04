import 'package:sprint1/core/network/api_service.dart';
import 'package:sprint1/features/home/data/model/product.dart';
import 'package:sprint1/features/home/domain/repository/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ApiService apiService;

  ProductRepositoryImpl(this.apiService);

  @override
  Future<List<Product>> getProducts() async {
    try {
      final List<Product> apiProducts = await apiService.fetchProducts();
      // Preserve all fields from the API Product model
      return apiProducts.map((apiProduct) => Product(
        id: apiProduct.id,
        name: apiProduct.name,
        description: apiProduct.description,
        price: apiProduct.price,
        quantity: apiProduct.quantity,
        status: apiProduct.status,
        image: apiProduct.image,       // Include image
        imageUrl: apiProduct.imageUrl, // Include imageUrl
        createdAt: apiProduct.createdAt,
        updatedAt: apiProduct.updatedAt,
      )).toList();
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }
}