// ignore_for_file: file_names, prefer_const_constructors, duplicate_ignore, empty_statements
import 'package:flutter/material.dart';
import 'package:product_app_demo/db/db_sqlite.dart';
import 'package:product_app_demo/model/productModel.dart';
import 'package:product_app_demo/page/productPage.dart';
import 'package:product_app_demo/widgets/product_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void refresh(){
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          centerTitle: true,
          actions: [
             IconButton(onPressed: (){
               Navigator.pushNamed(context, '/cartItemPage');
             }, 
             icon: Icon(Icons.shopping_cart)),

            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductPage(),
                      )).then((_) {
                    setState(() {});
                  });
                },
                icon: Icon(Icons.add))
          ],
        ),
        body: FutureBuilder(
          future: DBSqlite.getAllProduct(),
          builder: (context, AsyncSnapshot<List<Product>> snapshot) {
            if (snapshot.hasData) {
              return GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children:
                    snapshot.data!.map((e) => ProductItem(product: e,callback: refresh,)).toList(),
              );
            }
            if (snapshot.hasError) {
              // ignore: prefer_const_constructors
              return Center(
                child: Text('failed to fetch data'),
              );
            }
            // ignore: prefer_const_constructors
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
