import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:testapp/screens/MoreProducts_Screen.dart';
import 'package:testapp/screens/ProfileScreen.dart';
import 'package:testapp/widgets/Best_Selling_Widget.dart';
import 'package:testapp/widgets/Drawer_Menu.dart';
import 'package:testapp/widgets/Explore_Widget.dart';
import 'package:testapp/widgets/Search_Bar_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const DrawerMenu(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(),
                      ));
                },
                child: Container(
                  height: 23,
                  width: 23,
                  decoration: BoxDecoration(
                      color: const Color(0xFF24293D),
                      borderRadius: BorderRadius.circular(5)),
                  child: const Center(
                    child: Icon(
                      Icons.person_rounded,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              )
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(20),
            // Search Widget
            SearchWidget(),
            // Explore widget
            Padding(
              padding: EdgeInsets.only(left: 15, top: 20, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Explore",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w800),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MoreProducts(),
                          ));
                    },
                    child: Text(
                      "more",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.red,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 25, top: 10, left: 5),
              child: Container(
                  height: 220,
                  width: MediaQuery.of(context).size.width,
                  child: ExploreWidget()),
            ),
            // Best Selling widget
            Padding(
              padding: EdgeInsets.only(left: 15, top: 25),
              child: Text(
                "Best Selling",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w800),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15, left: 5, right: 25),
              child: Container(
                  height: 300, child: Expanded(child: BestSellingWidget())),
            ),
          ],
        ),
      ),
    );
  }
}
