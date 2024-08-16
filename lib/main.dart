import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:testapp/authentication/Login.dart';
import 'package:testapp/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testapp/screens/HomeScreen.dart';
import 'package:testapp/widgets/Colors.dart';
import 'package:testapp/widgets/Explore_Widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ButtonClickScreen(),
    );
  }
}

class ButtonClickScreen extends StatefulWidget {
  @override
  _ButtonClickScreenState createState() => _ButtonClickScreenState();
}

class _ButtonClickScreenState extends State<ButtonClickScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _handleButtonClick() async {
    // Add a document to the 'buttonClicks' collection
    await _firestore.collection('buttonClicks').add({
      'timestamp': FieldValue.serverTimestamp(),
    });

    // Listen to the changes in the 'buttonClicks' collection
    _firestore.collection('buttonClicks').snapshots().listen((snapshot) {
      if (snapshot.docs.length > 1) {
        print("add");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Button Click Tracker'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _handleButtonClick,
          child: Text('Click Me'),
        ),
      ),
    );
  }
}

class WidgetTest extends StatefulWidget {
  const WidgetTest({super.key});

  @override
  State<WidgetTest> createState() => _WidgetTestState();
}

class _WidgetTestState extends State<WidgetTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [],
      ),
    );
  }
}

// app home image url
// https://www.freepik.com/free-vector/furniture-shopping-app-interface_9926578.htm#query=mobile%20app%20template&position=7&from_view=keyword&track=ais_user&uuid=96724688-c80c-4c3d-8984-7027f62a3edc

class Fetchdata extends StatefulWidget {
  const Fetchdata({Key? key}) : super(key: key);

  @override
  State<Fetchdata> createState() => _FetchdataState();
}

class _FetchdataState extends State<Fetchdata> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fetch Data from Firestore'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("info").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            var docs = snapshot.data!.docs;
            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index) {
                var data = docs[index].data() as Map<String, dynamic>;
                return ListTile(
                  title: Text(data["name"] ?? "No Name"),
                );
              },
            );
          } else {
            return Center(
              child: Text("No data available"),
            );
          }
        },
      ),
    );
  }
}

//firebase image and data function

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//             onPressed: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => exseller(),
//                   ));
//             },
//             icon: Icon(Icons.add)),
//         title: Text('Explore Products'),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('Explore_products')
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }

//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }

//           final products = snapshot.data?.docs ?? [];

//           return ListView.builder(
//             itemCount: products.length,
//             itemBuilder: (context, index) {
//               final product = products[index];
//               final data = product.data() as Map<String, dynamic>;
//               final name = data['name'];
//               final amount = data['amount'];
//               final dis = data['dis'];
//               final imageUrl =
//                   data.containsKey('image_url') ? data['image_url'] : null;

//               return ListTile(
//                 leading: imageUrl != null
//                     ? Image.network(imageUrl)
//                     : Icon(Icons.image),
//                 title: Text(name),
//                 subtitle: Text('Amount: $amount\nDescription: $dis'),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// class exseller extends StatefulWidget {
//   const exseller({super.key});

//   @override
//   State<exseller> createState() => _exsellerState();
// }

// class _exsellerState extends State<exseller> {
//   TextEditingController name = TextEditingController();
//   TextEditingController amount = TextEditingController();
//   TextEditingController dis = TextEditingController();
//   File? _image;
//   final picker = ImagePicker();

//   Future<void> _pickImage() async {
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);

//     setState(() {
//       if (pickedFile != null) {
//         _image = File(pickedFile.path);
//       } else {
//         print('No image selected.');
//       }
//     });
//   }

//   Future<void> _uploadData() async {
//     if (_image == null) return;

//     try {
//       // Upload image to Firebase Storage
//       final storageRef = FirebaseStorage.instance
//           .ref()
//           .child('product_images')
//           .child('${DateTime.now().millisecondsSinceEpoch}.jpg');
//       await storageRef.putFile(_image!);
//       final imageUrl = await storageRef.getDownloadURL();

//       // Save data to Firestore
//       CollectionReference collref =
//           FirebaseFirestore.instance.collection("Explore_products");
//       await collref.add({
//         'name': name.text,
//         'dis': dis.text,
//         'amount': amount.text,
//         'image_url': imageUrl,
//       });
//     } catch (e) {
//       print('Error uploading data: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: bgcolor,
//       appBar: AppBar(
//         leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: Icon(
//               Icons.arrow_back,
//               color: Colors.black,
//             )),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             TextField(
//               controller: name,
//               decoration: InputDecoration(hintText: "name"),
//             ),
//             Gap(20),
//             TextField(
//               controller: amount,
//               decoration: InputDecoration(hintText: "amount"),
//             ),
//             Gap(20),
//             TextField(
//               controller: dis,
//               decoration: InputDecoration(hintText: "dis"),
//             ),
//             Gap(20),
//             ElevatedButton(
//               onPressed: _pickImage,
//               child: Text('Pick Image'),
//             ),
//             if (_image != null) ...[
//               Gap(20),
//               Image.file(_image!),
//             ],
//             Gap(40),
//             ElevatedButton(
//               onPressed: _uploadData,
//               child: Text("Add"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
