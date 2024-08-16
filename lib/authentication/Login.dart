import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:testapp/authentication/Verification.dart';
import 'package:testapp/widgets/Colors.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController phoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            "X",
            style: TextStyle(
                fontWeight: FontWeight.w600, color: Colors.black, fontSize: 15),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 120,
            width: 130,
            child: Image.asset(
              'assets/images/Number_image.png',
              fit: BoxFit.cover,
            ),
          ),
          const Gap(30),
          const Center(
              child: Text(
            "Please enter your mobile number",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          )),
          const Center(
              child: Text(
            "You’ll receive a 4 digit code",
            style: TextStyle(
                fontSize: 13, fontWeight: FontWeight.w400, color: Colors.grey),
          )),
          const Center(
              child: Text(
            "to verify next",
            style: TextStyle(
                fontSize: 13, fontWeight: FontWeight.w400, color: Colors.grey),
          )),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
            child: SizedBox(
              height: 48,
              width: MediaQuery.of(context).size.width,
              child: TextField(
                controller: phoneNumber,
                decoration: const InputDecoration(
                  labelText: "Mobile",
                  labelStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 13),
                  //  prefix: Text("+91"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
            child: InkWell(
              onTap: () async {
                await FirebaseAuth.instance.verifyPhoneNumber(
                    verificationCompleted: (PhoneAuthCredential credential) {},
                    verificationFailed: (FirebaseAuthException ex) {},
                    codeSent: (String verificationid, int? resendToken) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Verification(
                              verificationid: verificationid,
                            ),
                          ));
                    },
                    codeAutoRetrievalTimeout: (Verificationid) {},
                    phoneNumber: phoneNumber.text.toString());
              },
              child: Container(
                decoration: BoxDecoration(
                    color: buttonColor, borderRadius: BorderRadius.circular(5)),
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: const Center(
                  child: Text(
                    "CONTINUE",
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
