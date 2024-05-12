import 'dart:convert';

import 'package:app_products_guillermo/api.dart';
import 'package:app_products_guillermo/models/cart.dart';
import 'package:app_products_guillermo/models/product.dart';
import 'package:flutter/material.dart';

class DashboardCartSection extends StatefulWidget {
  @override
  State<DashboardCartSection> createState() => _DashboardCartSectionState();
}

class _DashboardCartSectionState extends State<DashboardCartSection> {
  bool _getting = false;


  final TextStyle titleStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );

  final TextStyle descStyle = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 15,
  );


  final TextStyle priceStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 25,
  );

  Cart _cart = Cart(
    id: 0,
    totalPrice: 0,
    list: []
  );
  dynamic _toRemove;

  @override
  void initState() {
    _getCart();
    super.initState();
  }

  void _showSuccessMessage(msg) {

    final snackBar = SnackBar(
      content: Text(msg),
      backgroundColor: Colors.green,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  _showErrorMessage(msg) {

    final snackBar = SnackBar(
      content: Text(msg),
      backgroundColor: Colors.red,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _getCart() async {

    setState(() {
      _getting = true;
    });


    var result = await ApiFetch().get({}, 'cart');

    var body = json.decode(result.body);
    if(body['data'] != null) {
        var cartData = body['data'];
        setState(() {
          _cart = Cart(
            id: cartData['id'],
            list: cartData['list'],
            totalPrice: cartData['total_price']
          );
        });
    } else {
      _showErrorMessage(body['message'] ?? "Default Message");
    }

    setState(() {
      _getting = false;
    });  
  }

  void _removeToCart(productId) async {
    setState(() {
      _toRemove = productId;
    });
    var result = await ApiFetch().delete({}, 'cart/$productId/remove');
    var body = json.decode(result.body);

    if(body['cart'] != null) {
        var cartData = body['cart'];
        setState(() {
          _cart = Cart(
            id: cartData['id'],
            list: cartData['list'],
            totalPrice: cartData['total_price']
          );
        });
        
      _showSuccessMessage(body['message']);
    } else {
      _showErrorMessage(body['message']);
    }
 
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

    if(_cart.list.isEmpty) {
      return SafeArea(
        child: Container(
          color: theme.colorScheme.primaryContainer,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("No added products")
              ],
            ),
          ),
        )
      );
    }

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: theme.colorScheme.primaryContainer,
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        "Total Price: ${_cart.totalPrice}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Divider(),
                      ..._cart.list.map<Widget>((prod) {
                          Product product = Product(
                            id: prod['id'],
                            urlImage: prod['img'],
                            name: prod['name'],
                            description: prod['description'],
                            price: prod['price']
                          );
                          return Padding(
                            padding: EdgeInsets.all(10),
                            child: Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(0))
                              ),
                              child: Column(
                                children: [
                                  Image(
                                    image: NetworkImage(product.urlImage),
                                    height: 200,
                                  ),

                                  Text(
                                    product.name,
                                    style: titleStyle,
                                  ),
                                  Text(
                                    product.description,
                                    style: descStyle,
                                  ),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(width: 10),
                                      Text(
                                        '\$${product.price}',
                                        style: priceStyle,
                                      ),
                                      ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(5)),
                                          ),
                                          backgroundColor: theme.colorScheme.error
                                        ),
                                        onPressed: _toRemove == product.id ? null : () {
                                          _removeToCart(product.id);
                                        }, 
                                        icon: Icon(
                                          Icons.remove,
                                          color: theme.colorScheme.onError,
                                        ),
                                        label: Text(
                                          "Remove",
                                          style: TextStyle(
                                            color: theme.colorScheme.onError
                                          ),

                                        )
                                        
                                      ),
                                      SizedBox(width: 10),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                      })
          
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
    
  }
}