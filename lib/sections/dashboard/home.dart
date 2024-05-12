import 'dart:convert';

import 'package:app_products_guillermo/api.dart';
import 'package:app_products_guillermo/components/products/card.dart';
import 'package:app_products_guillermo/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DashboardHomeSection extends StatefulWidget {
  @override
  State<DashboardHomeSection> createState() => _DashboardHomeSectionState();
}

class _DashboardHomeSectionState extends State<DashboardHomeSection> {

  bool _getting = false;

  List _productList = [];

  @override
  void initState() {
    _getProducts();
    super.initState();
  }

  _showMessage(msg) {

    final snackBar = SnackBar(
      content: Text(msg),
      backgroundColor: Colors.red,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _getProducts() async {

    setState(() {
      _getting = true;
    });

    var result = await ApiFetch().get({}, 'products');

    var body = json.decode(result.body);
    if(body['data'] != null) {
        _productList = body['data'];
    } else {
      _showMessage(body['message'] ?? "Default Message");
    }

    setState(() {
      _getting = false;
    });  
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if(_getting) {
      return SafeArea(
        child: Container(
          color: theme.colorScheme.primaryContainer,
          child: Center(
            child: CircularProgressIndicator(
              color: theme.colorScheme.primary
            ),
          ),
        ),
      );
    }


    // for(var i = 0; i <= 50; i++) {
    //   var product = Product(
    //       urlImage: 'https://concepto.de/wp-content/uploads/2019/11/producto-e1572738586616-800x400.jpg',
    //       id: i + 1,
    //       name: "Name for product $i",
    //       price: i + 100,
    //       description: "Description asdsa das d sad sa dsa d sad sa dsa d sad sa",

    //   );
    //   products.add(CardProduct(product: product));
    // }

    var pageTitle = _productList.isNotEmpty ? 'Available Products' : 'There are no products available';

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: theme.colorScheme.primaryContainer,
        child: Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      pageTitle,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Divider(),
                    ..._productList.map<Widget>((prod) {
                      Product product = Product(
                        id: prod['id'],
                        urlImage: prod['img'],
                        name: prod['name'],
                        description: prod['description'],
                        price: prod['price']
                      );
                      return CardProduct(product: product);
                    })
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}