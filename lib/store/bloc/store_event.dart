part of 'store_bloc.dart';

abstract class StoreEvent extends Equatable {
  const StoreEvent();

  @override
  List<Object> get props => [];
}

class AddProductToCart extends StoreEvent {
  final Product product;

  const AddProductToCart({required this.product});
}

class RemoveProductFromCart extends StoreEvent {
  final Product product;

  const RemoveProductFromCart({required this.product});
}

class ClearCart extends StoreEvent {
  const ClearCart();
}
