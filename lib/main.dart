// ignore_for_file: file_names, prefer_const_constructors, duplicate_ignore
import 'package:flutter/material.dart';
import 'package:product_app_demo/page/cart_itemPage.dart';
import 'package:product_app_demo/page/homePage.dart';
import 'package:product_app_demo/providers/cart_provider.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartPorvider(),
        
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes:{
          '/':(context)=>HomePage(),
          '/cartItemPage':(context)=>CartItems(),
        },
        
      ),
    );
  }
}