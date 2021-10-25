// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:product_app_demo/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CartItems extends StatelessWidget {
  const CartItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Item'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<CartPorvider>(context,listen: false).removeAll();
              },
              icon: Icon(Icons.clear))
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: Consumer<CartPorvider>(
                  builder: (context, provider, child) => ListView.builder(
                      itemCount: provider.itemCount,
                      itemBuilder: (context, index) => ListTile(
                            title:
                                Text(provider.cartItems[index].name.toString()),
                            trailing: Chip(
                                label: Text(
                                    'TK.${provider.cartItems[index].price}')),
                          )))),
          Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              color: Colors.blue,
              child: Consumer<CartPorvider>(
                builder: (context, value, child) => Text(
                  'Total price : ${value.totalprice}',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
