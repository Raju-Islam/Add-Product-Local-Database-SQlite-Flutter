// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:product_app_demo/db/db_sqlite.dart';
import 'package:product_app_demo/model/productModel.dart';

class ProductDatailsPage extends StatefulWidget {
  final int id;
  ProductDatailsPage({required this.id});

  @override
  _ProductDatailsPageState createState() => _ProductDatailsPageState();
}

class _ProductDatailsPageState extends State<ProductDatailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product"),
      ),
      body: FutureBuilder(
        future: DBSqlite.getProductById(widget.id),
        builder: (context, AsyncSnapshot<Product> snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.file(File(snapshot.data!.imagePath.toString(),),fit: BoxFit.cover,height: 200,width: double.infinity,),
                  SizedBox(height: 10,),
                  
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Align(
                      alignment: Alignment.topLeft,
                      child: Wrap(
                        children: [
                          Row(
                            children: [
                              Text('Product Name : ',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                              Text(snapshot.data!.name.toString(),style: TextStyle(fontSize: 18,))
                            ],
                          )
                        ],
                      )),
                    ),
                    SizedBox(height: 10,),
                     Align(
                    alignment: Alignment.topLeft,
                    child: Text(' Catgory: ${snapshot.data!.catgory.toString()} ',style: TextStyle(fontSize: 20),)),
                    SizedBox(height: 10,),
                    Align(
                    alignment: Alignment.topLeft,
                    child: Text(' Post Date: ${snapshot.data!.date.toString()} ',style: TextStyle(fontSize: 20),)),

                ],
              ),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Failed to fatch data"),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
