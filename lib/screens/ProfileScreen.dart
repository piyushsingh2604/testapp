import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testapp/authentication/Login.dart';
import 'package:testapp/screens/My_ProfileScreen.dart';
import 'package:testapp/widgets/Colors.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = "";
  String email = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadinfo();
  }

  Future<void> loadinfo() async {
    SharedPreferences prefe = await SharedPreferences.getInstance();
    setState(() {
      name = prefe.getString("namekey") ?? "";
      email = prefe.getString("emailkey") ?? "";
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: bgcolor,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 20,
              color: Colors.black,
            )),
        title: Text(
          "Profile",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontSize: 18,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 100,
            width: MediaQuery.of(context).size.width,
            color: bgcolor,
            child: Stack(
              children: [
                Positioned(
                  top: 5,
                  left: 10,
                  child: Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(100)),
                  ),
                ),
                Positioned(
                    top: 20,
                    left: 100,
                    child: Text(
                      name.isEmpty ? "name" : name,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 17),
                    )),
                Positioned(
                    top: 47,
                    left: 100,
                    child: Text(
                      email.isEmpty ? "Email" : email,
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ))
              ],
            ),
          ),
          Gap(20),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyProfile(),
                  ));
            },
            child: ListTile(
              leading: Icon(Icons.person_4_outlined, color: Colors.grey),
              title: Text(
                "My Profile",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              leading: Icon(Icons.settings, color: Colors.grey),
              title: Text(
                "Settings",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              leading: Icon(Icons.notifications_none, color: Colors.grey),
              title: Text(
                "Notifications",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              leading: Icon(Icons.history_rounded, color: Colors.grey),
              title: Text(
                "Transaction History",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              leading:
                  Icon(Icons.chat_bubble_outline_rounded, color: Colors.grey),
              title: Text(
                "FAQ",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              leading: Icon(Icons.info_outline_rounded, color: Colors.grey),
              title: Text(
                "About app",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Gap(50),
          InkWell(
            onTap: () {},
            child: ListTile(
              leading: Icon(Icons.logout_outlined, color: Colors.grey),
              title: Text(
                "Logout",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
