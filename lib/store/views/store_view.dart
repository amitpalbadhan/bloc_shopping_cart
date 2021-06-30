import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/store/bloc/store_bloc.dart';

class Store extends StatelessWidget {
  const Store({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreBloc, StoreState>(
      builder: (context, state) {
        return GridView.count(
          crossAxisCount: 4,
          children: BlocProvider.of<StoreBloc>(context)
              .store
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
                                BlocProvider.of<StoreBloc>(context)
                                    .add(AddProductToCart(product: product));
                              },
                              child: Text('Add To Cart'),
                            )
                          ],
                        ),
                      ),
                    ),
                  ))
              .toList(),
        );
      },
    );
  }
}
