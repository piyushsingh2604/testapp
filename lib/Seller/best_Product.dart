import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:testapp/Screens/HomeScreen.dart';
import 'package:testapp/widgets/Colors.dart';

class BestSeller extends StatefulWidget {
  const BestSeller({super.key});

  @override
  State<BestSeller> createState() => _BestSellerState();
}

class _BestSellerState extends State<BestSeller> {
  TextEditingController name = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController dis = TextEditingController();
  File? _image;
  final picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _uploadData() async {
    if (_image == null) return;

    try {
      // Upload image to Firebase Storage
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('Best_products_image')
          .child('${DateTime.now().millisecondsSinceEpoch}.jpg');
      await storageRef.putFile(_image!);
      final imageUrl = await storageRef.getDownloadURL();

      // Save data to Firestore
      CollectionReference collref =
          FirebaseFirestore.instance.collection("best_products");
      await collref.add({
        'name': name.text,
        'dis': dis.text,
        'amount': amount.text,
        'image_url': imageUrl,
      });
    } catch (e) {
      print('Error uploading data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: name,
              decoration: InputDecoration(hintText: "name"),
            ),
            Gap(20),
            TextField(
              keyboardType: TextInputType.number,
              controller: amount,
              decoration: InputDecoration(hintText: "amount"),
            ),
            Gap(20),
            TextField(
              controller: dis,
              decoration: InputDecoration(hintText: "dis"),
            ),
            Gap(20),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick Image'),
            ),
            if (_image != null) ...[
              Gap(20),
              Image.file(_image!),
            ],
            Gap(40),
            ElevatedButton(
              onPressed: () {
                _uploadData();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ));
              },
              child: Text("Add"),
            ),
          ],
        ),
      ),
    );
  }
}
