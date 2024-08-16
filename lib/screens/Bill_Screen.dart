import 'package:flutter/material.dart';
import 'package:testapp/screens/CartScreen.dart';

class Bill_Screen extends StatelessWidget {
  final List<CartItem> cartItems;
  Bill_Screen({required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              height: 200,
              width: 300,
              child: cartItems.isEmpty
                  ? Center(child: Text("Cart is empty"))
                  : ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final item = cartItems[index];
                        return ListTile(
                          title: Text(item.name),
                        );
                      }))
        ],
      ),
    );
  }
}
