import 'package:sprint1/features/home/data/model/product.dart';

abstract class HomeEvent {
  const HomeEvent();
}

class FetchProducts extends HomeEvent {
  const FetchProducts();
}

class AddToCart extends HomeEvent {
  final Product product;

  const AddToCart(this.product);
}

class RemoveFromCart extends HomeEvent {
  final Product product;

  const RemoveFromCart(this.product);
}

class AddToWishlist extends HomeEvent {
  final Product product;

  const AddToWishlist(this.product);
}

class RemoveFromWishlist extends HomeEvent {
  final Product product;

  const RemoveFromWishlist(this.product);
}