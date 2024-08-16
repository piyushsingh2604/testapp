import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testapp/Screens/HomeScreen.dart';
import 'package:testapp/screens/Payment_Screen.dart';

class CartItem {
  final String name;
  final double amount;
  int quantity;

  CartItem({
    required this.name,
    required this.amount,
    this.quantity = 1,
  });

  double get total => amount * quantity;
}

class CartScreen extends StatelessWidget {
  final List<CartItem> cartItems;
  final Function(String) onRemove;

  CartScreen({
    required this.cartItems,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cart")),
      body: cartItems.isEmpty
          ? Center(child: Text("Cart is empty"))
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text(
                      "Amount: \$${item.amount.toStringAsFixed(2)} x ${item.quantity} = \$${item.total.toStringAsFixed(2)}"),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_circle_outline),
                    onPressed: () {
                      onRemove(item.name);
                    },
                  ),
                );
              },
            ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total: \$${cartItems.fold(0.0, (sum, item) => sum + item.total).toStringAsFixed(2)}",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Payment_screen(
                            cartItems: cartItems,
                          ),
                        ));
                  },
                  child: Text("Buy"))
            ],
          ),
        ),
      ),
    );
  }
}
