import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:testapp/Seller/Explore_Product.dart';
import 'package:testapp/Seller/best_Product.dart';
import 'package:testapp/screens/FavScreen.dart';
import 'package:testapp/screens/Notification_Screen.dart';
import 'package:testapp/screens/ProfileScreen.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({super.key});

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Gap(30),
          // ProfileScreen(),
          InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExploreSeller(),
                    ));
              },
              child: ListTile(
                title: Text("Explore Product"),
              )),
          Gap(0),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BestSeller(),
                  ));
            },
            child: ListTile(
              title: Text("Best Product"),
            ),
          ),
          Gap(0),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotificationScreen(),
                  ));
            },
            child: ListTile(
              title: Text("Notifications"),
            ),
          ),
          Gap(0),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavScreen(),
                  ));
            },
            child: ListTile(
              title: Text("Fav"),
            ),
          ),
        ],
      ),
    );
  }
}
