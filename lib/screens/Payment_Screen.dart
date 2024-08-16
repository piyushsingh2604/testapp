import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:testapp/Screens/HomeScreen.dart';
import 'package:testapp/screens/CartScreen.dart';

class Payment_screen extends StatelessWidget {
  final List<CartItem> cartItems;
  Payment_screen({required this.cartItems});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: 250,
                width: 300,
                child: cartItems.isEmpty
                    ? Center(child: Text("No data Found"))
                    : ListView.builder(
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          final item = cartItems[index];
                          return ListTile(
                            title: Text(item.name),
                            subtitle: Text(item.amount.toString()),
                          );
                        },
                      )),
            Divider(
              indent: 10,
              endIndent: 10,
              color: Colors.grey[200],
              height: 5,
              thickness: 6,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 15),
              child: Text(
                "Payment method",
                style: TextStyle(fontSize: 12, color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 25),
              child: Text(
                "Cash on delivery",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Gap(40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ));
                    },
                    child: Text(
                      "Pay",
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
