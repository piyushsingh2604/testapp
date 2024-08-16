import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:testapp/Screens/HomeScreen.dart';
import 'package:testapp/widgets/Colors.dart';
//import 'package:custom_otp_textfield/custom_otp_textfield.dart';

class Verification extends StatefulWidget {
  final String verificationid;
  const Verification({super.key, required this.verificationid});
  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  TextEditingController otp = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Column(
        children: [
          Container(
            height: 150,
            width: 150,
            child: Image.asset(
              'assets/images/Verification.png',
              fit: BoxFit.cover,
            ),
          ),
          const Gap(30),
          const Center(
              child: Text(
            "Verify Phone",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          )),
          const Center(
              child: Text(
            "Code is sent to 8094508485",
            style: TextStyle(
                fontSize: 13, fontWeight: FontWeight.w400, color: Colors.grey),
          )),
          //  CustomOTPTextField(
          //       deviceWidth: MediaQuery.of(context).size.width,
          //       textEditingController: otp,
          //       boxSize: 70,
          //       inputBorder: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(12),
          //         borderSide: BorderSide(color: Colors.lightBlueAccent,width: 5),
          //       ),
          //       cursorColor: Colors.blue,
          //       otpLength: 5,
          //       textStyle: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
          //       spaceBetweenTextFields: 10,
          //       cursorHeight: 40,
          //     ),

          Gap(20),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Didn’t receive the code?",
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey),
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Request Again",
                      style: TextStyle(
                          color: buttonColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w400),
                    )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: InkWell(
              onTap: () async {
                try {
                  PhoneAuthCredential credential = PhoneAuthProvider.credential(
                      verificationId: widget.verificationid,
                      smsCode: otp.text.toString());
                  FirebaseAuth.instance
                      .signInWithCredential(credential)
                      .then((value) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ));
                  });
                } catch (ex) {
                  log(ex.toString() as num);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color: buttonColor, borderRadius: BorderRadius.circular(5)),
                height: 56,
                width: MediaQuery.of(context).size.width,
                child: const Center(
                  child: Text(
                    "VERIFY AND CONTINUE",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
