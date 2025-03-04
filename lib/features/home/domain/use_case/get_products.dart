 // Adjust the import path to match your project
import 'package:sprint1/core/usecase/usecase.dart';
import 'package:sprint1/features/home/data/model/product.dart';

import '../repository/product_repository.dart';

class GetProducts implements UseCase<List<Product>, NoParams> {
  final ProductRepository repository;

  GetProducts(this.repository);

  @override
  Future<List<Product>> call(NoParams params) async {
    return await repository.getProducts();
  }
}