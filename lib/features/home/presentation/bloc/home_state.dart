import 'package:equatable/equatable.dart';
import 'package:sprint1/features/home/data/model/product.dart';

class HomeState extends Equatable {
  final bool isLoading;
  final List<Product> products;
  final String? errorMessage;
  final List<Product> cartItems;

  HomeState({
    required this.isLoading,
    required this.products,
    this.errorMessage,
    required this.cartItems,
  });

  factory HomeState.initial() => HomeState(
        isLoading: false,
        products: [],
        errorMessage: null,
        cartItems: [],
      );

  HomeState copyWith({
    bool? isLoading,
    List<Product>? products,
    String? errorMessage,
    List<Product>? cartItems,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      products: products ?? this.products,
      errorMessage: errorMessage ?? this.errorMessage,
      cartItems: cartItems ?? this.cartItems,
    );
  }

  @override
  List<Object?> get props => [isLoading, products, errorMessage, cartItems];
}