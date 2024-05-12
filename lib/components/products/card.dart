
import 'dart:convert';

import 'package:app_products_guillermo/api.dart';
import 'package:app_products_guillermo/components/cards/default.dart';
import 'package:app_products_guillermo/models/product.dart';
import 'package:flutter/material.dart';

class CardProduct extends StatefulWidget {
  final Product product;

  const CardProduct({
    super.key,
    required this.product
  });

  @override
  State<CardProduct> createState() => _CardProductState();
}

class _CardProductState extends State<CardProduct> {

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

  void _showSuccessMessage(msg) {

    final snackBar = SnackBar(
      content: Text(msg),
      backgroundColor: Colors.green,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _showErrorMessage(msg) {

    final snackBar = SnackBar(
      content: Text(msg),
      backgroundColor: Colors.red,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _addToCart() async {
    Object data = {
      'product_id': widget.product.id
    };
    var result = await ApiFetch().post(data, 'cart/add');
    var body = json.decode(result.body);

    if(body['cart'] != null) {
      _showSuccessMessage(body['message']);
    } else {
      _showErrorMessage(body['message']);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return  Padding(
      padding: EdgeInsets.all(10) ,
      child: DefaultCard(
        borderRadius: 10,
        elevation: 10,
        color: Colors.white,
        child: Column(
          children: [
            Image(image: NetworkImage(widget.product.urlImage)),
            Container(
              padding: EdgeInsets.only(left: 10, bottom: 10),
              child: Column(
                children: [
                  Text(
                    widget.product.name,
                    style: titleStyle,
                  ),
                  Text(
                    widget.product.description,
                    style: descStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 10),
                      Text(
                        '\$${widget.product.price}',
                        style: priceStyle,
                      ),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          backgroundColor: theme.colorScheme.primary
                        ),
                        onPressed: _addToCart, 
                        icon: Icon(
                          Icons.add,
                          color: theme.colorScheme.onPrimary,
                        ),
                        label: Text(
                          "Add",
                          style: TextStyle(
                            color: theme.colorScheme.onPrimary
                          ),

                        )
                        
                      ),
                      SizedBox(width: 10),
                    ],
                  )
                ],
                
              ),
            )
          ]
        ),
      ),
    );
  }
}