import 'package:flutter/material.dart';
import 'package:testapp/screens/ProfileScreen.dart';
import 'package:testapp/widgets/Colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController gender = TextEditingController();

  String _name = "";
  String _email = "";
  String _number = "";
  String _address = "";
  String _gender = "";

  Future<void> saveinfo() async {
    final prefe = await SharedPreferences.getInstance();
    await prefe.setString("namekey", name.text);
    await prefe.setString("emailkey", email.text);
    await prefe.setString("addresskey", address.text);
    await prefe.setString("numberkey", number.text);
    await prefe.setString("genderkey", gender.text);

    setState(() {
      _name = name.text;
      _email = email.text;
      _number = number.text;
      _address = address.text;
      _gender = gender.text;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadinfo();
  }

  Future<void> loadinfo() async {
    final prefe = await SharedPreferences.getInstance();
    setState(() {
      _name = prefe.getString("namekey") ?? "";
      _email = prefe.getString("emailkey") ?? "";
      _number = prefe.getString("numberkey") ?? "";
      _address = prefe.getString("addresskey") ?? "";
      _gender = prefe.getString("genderkey") ?? "";
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
          "My Profile",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.edit))],
      ),
      body: Stack(children: [
        Container(
          height: 800,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 130,
                  width: MediaQuery.of(context).size.width,
                  color: bgcolor,
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                          color: buttonColor,
                          borderRadius: BorderRadius.circular(100)),
                      height: 100,
                      width: 100,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  child: Text(
                    "Basic Detail",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10),
                  child: Text(
                    "Full name",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 21, right: 20, top: 5),
                  child: Container(
                    height: 45,
                    child: TextField(
                      controller: name,
                      decoration: InputDecoration(
                          hintText: _name.isEmpty ? "Enter Name" : _name,
                          border: OutlineInputBorder()),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 15),
                  child: Text(
                    "E-mail",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 21, right: 20, top: 5),
                  child: Container(
                    height: 45,
                    child: TextField(
                      controller: email,
                      decoration: InputDecoration(
                          hintText: _email.isEmpty ? "Enter Email" : _email,
                          border: OutlineInputBorder()),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10),
                  child: Text(
                    "Gender",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 21, right: 20, top: 5),
                  child: Container(
                    height: 45,
                    child: TextField(
                      controller: gender,
                      decoration: InputDecoration(
                          hintText: _gender.isEmpty ? "Enter Gender" : _gender,
                          border: OutlineInputBorder()),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10),
                  child: Text(
                    "Mobile Number",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 21, right: 20, top: 5),
                  child: Container(
                    height: 45,
                    child: TextField(
                      controller: number,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          hintText:
                              _number.isEmpty ? "Enter Phone Number" : _number,
                          border: OutlineInputBorder()),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10),
                  child: Text(
                    "Address",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 21, right: 20, top: 5, bottom: 200),
                  child: Container(
                    height: 100,
                    child: TextField(
                      controller: address,
                      maxLines: 50,
                      autocorrect: true,
                      decoration: InputDecoration(
                          hintText:
                              _address.isEmpty ? "Enter Address" : _address,
                          border: OutlineInputBorder()),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 550,
          child: InkWell(
            onTap: Checkinfo,
            child: Container(
              decoration: BoxDecoration(
                  color: bgcolor,
                  boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10)]),
              height: 280,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 25),
                    child: Container(
                      child: Center(
                        child: Text(
                          "Save",
                          style: TextStyle(color: bgcolor),
                        ),
                      ),
                      height: 45,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: buttonColor,
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }

  void Checkinfo() {
    var Nvalue = name.text;
    var Evalue = email.text;
    var Gvalue = gender.text;
    var Mvalue = number.text;
    var Avalue = address.text;

    if (Nvalue.isEmpty) {
      setState(() {
        _name = "Enter your name";
      });
    } else if (Evalue.isEmpty) {
      setState(() {
        _email = "Enter your Email";
      });
    } else if (Gvalue.isEmpty) {
      setState(() {
        _gender = "Enter your gender";
      });
    } else if (Mvalue.isEmpty) {
      setState(() {
        _number = "Enter your Number";
      });
    } else if (Avalue.isEmpty) {
      setState(() {
        _address = "Enter your address";
      });
    } else {
      CollectionReference collref =
          FirebaseFirestore.instance.collection("info");
      collref.add({
        'name': name.text,
        'email': email.text,
        'address': address.text,
        'gender': gender.text,
        'number': number.text
      });
      saveinfo();
    }
  }
}
