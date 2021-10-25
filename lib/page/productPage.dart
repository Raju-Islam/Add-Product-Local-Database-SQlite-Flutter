// ignore_for_file: file_names, prefer_const_constructors, prefer_const_constructors_in_immutables
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:product_app_demo/db/db_sqlite.dart';
import 'package:product_app_demo/model/productModel.dart';
import 'package:product_app_demo/utils/product_utils.dart';

class ProductPage extends StatefulWidget {
  ProductPage({
    Key? key,
  }) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final _globalkey = GlobalKey<FormState>();
  Product product = Product(e);
  String category = 'Electrinics';
  // ignore: prefer_typing_uninitialized_variables
  var date;
  // ignore: prefer_typing_uninitialized_variables
  var imagePath;

  void _pickDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((dateTime) {
      setState(() {
        date = DateFormat('dd/MM/yyy').format(dateTime!);
        product.date = date;
      });
    });
  }

  void _pickImage() async {
    // ignore: deprecated_member_use
    PickedFile? pickedFile =
        await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      imagePath = pickedFile!.path.toString();
    });
    product.imagePath = imagePath;
    // ImagePicker().getImage(source: ImageSource.camera).then((file) {
    //   setState(() {
    //     imagePath = File(file!.path);
    //     product.imagePath = imagePath;
    //   });
    // });
  }

  void _saveProduct() {
    if (_globalkey.currentState!.validate()) {
      _globalkey.currentState!.save();
      if (date == null) {
        return;
      }
      if (imagePath == null) {
        return;
      }
      print(product);
      DBSqlite.insertProduct(product).then((id) => {
        if(id>0){
        Navigator.pop(context), 
        }
        else{
          print('failed to save product'),
        }
      });
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Form(
          key: _globalkey,
          child: ListView(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'This feild must not be empty ';
                  }
                },
                onSaved: (value) {
                  product.name = value!;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 0),
                    ),
                    fillColor: Colors.grey.shade200,
                    contentPadding: EdgeInsets.all(20),
                    filled: true,
                    hintText: 'Product',
                    labelText: "Enter Product Name",
                    hintStyle: TextStyle(color: Colors.black54)),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'This feild must not be empty ';
                  }
                  if (double.parse(value) <= 0.0) {
                    return 'Prize should not be gatter then 0.0';
                  }
                  return null;
                },
                onSaved: (value) {
                  product.price = double.parse(value!);
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 0),
                    ),
                    fillColor: Colors.grey.shade200,
                    contentPadding: EdgeInsets.all(20),
                    filled: true,
                    hintText: 'Prize',
                    labelText: "Enter Product Prize",
                    hintStyle: TextStyle(color: Colors.black54)),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 8, right: 150),
                child: Container(
                  padding: EdgeInsets.only(left: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButton(
                      underline: SizedBox(),
                      icon: Icon(
                        Icons.arrow_drop_down,
                      ),
                      iconSize: 36,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      isExpanded: true,
                      iconEnabledColor: Colors.blue,
                      value: category,
                      onChanged: (value) {
                        setState(() {
                          category = value.toString();
                        });
                        product.catgory = category;
                      },
                      items: categoryList
                          .map((c) => DropdownMenuItem<String>(
                              value: c, child: Text(c)))
                          .toList()),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        _pickDate();
                      },
                      child: Text("Select Date")),
                  // ignore: prefer_if_null_operators
                  Text(date == null ? "No date chosen yet" : date)
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                      ),
                      child: imagePath == null
                          ? Center(
                              child: Text(
                              "Select Image",
                            ))
                          : Image.file(
                              File(imagePath!),
                              fit: BoxFit.cover,
                            )),
                  Column(children: [
                    TextButton.icon(
                        onPressed: () {
                          _pickImage();
                        },
                        icon: Icon(Icons.camera),
                        label: Text("Take Photo")),
                  ])
                ],
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    maximumSize: Size(200, 50),
                    minimumSize: Size(200, 50),
                    // ignore: unnecessary_new
                    shape: new RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                onPressed: () {
                  _saveProduct();
                },
                child: Text("Save"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
