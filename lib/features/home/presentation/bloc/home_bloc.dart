import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sprint1/core/usecase/usecase.dart';
import 'package:sprint1/features/home/data/model/product.dart';
import 'package:sprint1/features/home/domain/use_case/get_products.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetProducts getProducts;

  HomeBloc(this.getProducts) : super(HomeState.initial()) {
    print('HomeBloc created');
    on<FetchProducts>(_onFetchProducts);
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<AddToWishlist>(_onAddToWishlist);
    on<RemoveFromWishlist>(_onRemoveFromWishlist);
    add(const FetchProducts());
  }

  Future<void> _onFetchProducts(FetchProducts event, Emitter<HomeState> emit) async {
    print("bloc - FetchProducts event received");
    emit(state.copyWith(isLoading: true));
    try {
      final products = await getProducts(NoParams());
      emit(state.copyWith(
        isLoading: false,
        products: products,
        errorMessage: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }

  void _onAddToCart(AddToCart event, Emitter<HomeState> emit) {
    print('Adding ${event.product.name} to cart');
    final updatedCart = List<Product>.from(state.cartItems)..add(event.product);
    emit(state.copyWith(cartItems: updatedCart));
    print('Cart updated. Total items: ${updatedCart.length}');
  }

  void _onRemoveFromCart(RemoveFromCart event, Emitter<HomeState> emit) {
    print('Removing ${event.product.name} from cart');
    final updatedCart =
        state.cartItems.where((item) => item.id != event.product.id).toList();
    emit(state.copyWith(cartItems: updatedCart));
    print('Cart updated. Total items: ${updatedCart.length}');
  }

  void _onAddToWishlist(AddToWishlist event, Emitter<HomeState> emit) {
    print('Adding ${event.product.name} to wishlist');
    final updatedWishlist = List<Product>.from(state.wishlistItems)..add(event.product);
    emit(state.copyWith(wishlistItems: updatedWishlist));
    print('Wishlist updated. Total items: ${updatedWishlist.length}');
  }

  void _onRemoveFromWishlist(RemoveFromWishlist event, Emitter<HomeState> emit) {
    print('Removing ${event.product.name} from wishlist');
    final updatedWishlist =
        state.wishlistItems.where((item) => item.id != event.product.id).toList();
    emit(state.copyWith(wishlistItems: updatedWishlist));
    print('Wishlist updated. Total items: ${updatedWishlist.length}');
  }
}