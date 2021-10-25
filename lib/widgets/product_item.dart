// ignore_for_file: unnecessary_new, prefer_const_constructors, duplicate_ignore, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:product_app_demo/db/db_sqlite.dart';
import 'package:product_app_demo/model/productModel.dart';
import 'package:product_app_demo/page/product_details_page.dart';
import 'package:product_app_demo/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatefulWidget {
  final Product product;
  final Function callback;
  ProductItem({required this.product, required this.callback});

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  late CartPorvider cartPorvider;
  @override
  void didChangeDependencies() {
    cartPorvider = Provider.of<CartPorvider>(context);
    super.didChangeDependencies();
  }

  void _update() {
    var value = widget.product.isFavorite! ? 0 : 1;
    DBSqlite.updateisFav(widget.product.id!, value).then((value) {
      setState(() {
        widget.product.isFavorite = !widget.product.isFavorite!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Dismissible(
      direction: DismissDirection.endToStart,
      background: Container(
        margin: EdgeInsets.symmetric(horizontal: 7, vertical: 5),
        color: Colors.red,
        child: Center(
          child: Icon(
            Icons.delete,
            size: 64,
            color: Colors.white,
          ),
        ),
      ),
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text("Delete ${widget.product.name} ?"),
                  content: Wrap(
                    children: [
                      Text("Are you sure to delete this product?"),
                      Text("You cannot undo this operation!")
                    ],
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Text("Cancel")),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: Text("Ok"))
                  ],
                ));
      },
      onDismissed: (direction) {
        DBSqlite.deleteProduct(widget.product.id!)
            .then((_) => widget.callback()(direction));
      },
      key: UniqueKey(),
      child: InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDatailsPage(
                id: widget.product.id!,
              ),
            )),
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 7, vertical: 5),
          child: Column(
            children: [
              Image.file(
                File(widget.product.imagePath.toString()),
                fit: BoxFit.cover,
                height: 180,
                width: double.infinity,
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  widget.product.name.toString(),
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Text(
                "Tk. ${widget.product.price.toString()}",
                style: TextStyle(fontSize: 14),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: _update,
                        icon: Icon(widget.product.isFavorite!
                            ? Icons.favorite
                            : Icons.favorite_border_sharp)),
                    cartPorvider.cartItems.contains(widget.product)
                        ? Icon(Icons.done)
                        : IconButton(
                            onPressed: () {
                              cartPorvider.addToCart(widget.product);
                            },
                            icon: Icon(Icons.add_shopping_cart)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
