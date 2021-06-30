import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/store/bloc/store_bloc.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreBloc, StoreState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Cart'),
          ),
          body: CartSection(),
        );
      },
    );
  }
}

class CartSection extends StatefulWidget {
  const CartSection({Key? key}) : super(key: key);

  @override
  _CartSectionState createState() => _CartSectionState();
}

class _CartSectionState extends State<CartSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 10),
        Text(
          'Total: \$' + getTotal().toStringAsFixed(2),
          style: TextStyle(fontSize: 20.0),
        ),
        SizedBox(height: 10),
        TextButton(
          onPressed: () {
            BlocProvider.of<StoreBloc>(context).add(ClearCart());
          },
          child: Text('Clear Cart'),
        ),
        SizedBox(height: 10),
        Expanded(
          child: GridView.count(
            crossAxisCount: 4,
            children: BlocProvider.of<StoreBloc>(context)
                .cart
                .map((product) => Card(
                      margin: EdgeInsets.all(32.0),
                      child: SizedBox(
                        width: 300,
                        height: 300,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.network(
                                product.image,
                                height: 150,
                                width: 150,
                                fit: BoxFit.cover,
                              ),
                              Text(product.title),
                              Text('\$${product.price}'),
                              Text(product.description),
                              TextButton(
                                onPressed: () {
                                  BlocProvider.of<StoreBloc>(context).add(
                                      RemoveProductFromCart(product: product));
                                },
                                child: Text('Remove From Cart'),
                              )
                            ],
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }

  double getTotal() {
    double total = 0;
    BlocProvider.of<StoreBloc>(context).cart.forEach((element) {
      total += element.price;
    });
    return total;
  }
}
