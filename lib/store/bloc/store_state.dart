part of 'store_bloc.dart';

abstract class StoreState extends Equatable {
  const StoreState();

  @override
  List<Object> get props => [];
}

class StoreInitial extends StoreState {
  final List<Product> store;
  final List<Product> cart;

  const StoreInitial({required this.store, required this.cart}) : super();
}

class AddedProductToCart extends StoreState {
  const AddedProductToCart() : super();
}

class RemovedProductFromCart extends StoreState {
  const RemovedProductFromCart() : super();
}
