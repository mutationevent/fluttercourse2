import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttercourceecommerce2/styles.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var data;
  int selectedTab = 0;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse('https://dummyjson.com/products?limit=10'));
    if (response.statusCode == 200) {
      setState(() {
        data = json.decode(response.body);
        print(data);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        //elevation: 0,
        //backgroundColor: Colors.white,
        //centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_none),
          )
        ],
        title: Text(
          'Discover',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
      body: data == null
          ? Text('loading...')
          : RefreshIndicator(
              color: Colors.black,
              onRefresh: fetchData,
              child: ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: data['limit'],
                itemBuilder: (context, index) {
                  return ProductItem(data['products'][index]);
                },
              ),
            ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            selectedTab = index;
          });
        },
        currentIndex: selectedTab,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border), label: 'Saved'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
        ],
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  dynamic product;

  ProductItem(this.product);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push('/product/${product['id']}');
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Placeholder(fallbackHeight: 100),
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Hero(
                    tag: 'product_${product['id']}',
                    child: Image.network(
                      //'https://images.pexels.com/photos/3965557/pexels-photo-3965557.jpeg?auto=compress&cs=tinysrgb&w=1600',
                      product['thumbnail'],
                      fit: BoxFit.cover,
                      height: 200,
                      width: double.infinity,
                    ),
                  ),
                ),
                Positioned(
                  right: 8,
                  top: 4,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.black,
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: Colors.white,
                      fixedSize: Size(40, 50),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 8),
            Text(
              '${product['title']}',
              style: productNameStyle(),
            ),
            SizedBox(height: 8),
            Text('${product['price']} MAD', style: productPriceStyle()),
          ],
        ),
      ),
    );
  }
}
