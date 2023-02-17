import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttercourceecommerce2/styles.dart';
import 'package:http/http.dart' as http;

class ProductDetailsPage extends StatefulWidget {
  String? id;

  ProductDetailsPage({required this.id});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  var product;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http
        .get(Uri.parse('https://dummyjson.com/products/${widget.id}'));
    if (response.statusCode == 200) {
      setState(() {
        product = json.decode(response.body);
        print(product);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details ${widget.id}'),
      ),
      body: product == null
          ? Text('loading...')
          : SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Hero(
                      tag: 'product_${product['id']}',
                      child: Image.network(
                        //'https://images.pexels.com/photos/3965557/pexels-photo-3965557.jpeg?auto=compress&cs=tinysrgb&w=1600',
                        product['thumbnail'],
                        fit: BoxFit.cover,
                        //height: 650,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    height: 100,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: product['images'].length,
                      separatorBuilder: (context, index) {
                        return SizedBox(width: 8);
                      },
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            '${product['images'][index]}',
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  Text('${product['title']}', style: productNameStyle()),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.star_rounded,
                        color: Colors.orangeAccent,
                      ),
                      Text('Rating ${product['rating']}')
                    ],
                  ),
                  SizedBox(height: 8),
                  Text('${product['description']}',
                      style: productDescriptionStyle()),
                ],
              ),
            ),
      bottomNavigationBar: product == null
          ? Container(height: 0)
          : Container(
              height: 100,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(width: 1, color: Colors.black12),
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Price'),
                      Text('${product['price']} MAD',
                          style: productPrice2Style()),
                    ],
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    label: Text('Add to Cart'),
                    icon: Icon(Icons.shopping_cart_checkout_sharp),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black,
                      elevation: 0,
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      //fixedSize: Size(MediaQuery.of(context).size.width, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
