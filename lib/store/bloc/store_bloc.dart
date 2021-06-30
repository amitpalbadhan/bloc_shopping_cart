import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopping_cart/store/store.dart';

part 'store_event.dart';
part 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  List<Product> _store;
  List<Product> _cart;

  List<Product> get store => _store;
  List<Product> get cart => _cart;

  StoreBloc({required List<Product> store, required List<Product> cart})
      : _store = store,
        _cart = cart,
        super(StoreInitial(store: store, cart: cart));

  @override
  Stream<StoreState> mapEventToState(
    StoreEvent event,
  ) async* {
    if (event is AddProductToCart) {
      yield* _mapAddProductToState(event);
    } else if (event is RemoveProductFromCart) {
      yield* _mapRemoveProductToState(event);
    } else if (event is ClearCart) {
      yield* _mapClearCartToState(event);
    }
  }

  Stream<StoreState> _mapAddProductToState(AddProductToCart product) async* {
    _cart.add(product.product);
    _store.remove(product.product);
    _store.sort((a, b) => a.title.compareTo(b.title));
    _cart.sort((a, b) => a.title.compareTo(b.title));
    yield AddedProductToCart();
    yield StoreInitial(store: _store, cart: _cart);
  }

  Stream<StoreState> _mapRemoveProductToState(
      RemoveProductFromCart product) async* {
    _store.add(product.product);
    _cart.remove(product.product);
    _store.sort((a, b) => a.title.compareTo(b.title));
    _cart.sort((a, b) => a.title.compareTo(b.title));
    yield RemovedProductFromCart();
    yield StoreInitial(store: _store, cart: _cart);
  }

  Stream<StoreState> _mapClearCartToState(ClearCart clear) async* {
    _store = [..._store, ..._cart];
    _cart = [];
    _store.sort((a, b) => a.title.compareTo(b.title));
    yield RemovedProductFromCart();
    yield StoreInitial(store: _store, cart: _cart);
  }
}
