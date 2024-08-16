import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:testapp/widgets/Colors.dart';

class AboutProduct extends StatefulWidget {
  String name;
  String dis;
  String amount;
  String getimage;

  AboutProduct(
      {required this.name,
      required this.amount,
      required this.dis,
      required this.getimage});

  @override
  State<AboutProduct> createState() => _AboutProductState();
}

class _AboutProductState extends State<AboutProduct> {
  bool isfav = true;
  bool isfavColor = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: Stack(
        children: [
          // Product detail container
          Container(
            height: 700,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(top: 400, left: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.amount,
                      style: TextStyle(
                          color: Colors.pink[300],
                          fontWeight: FontWeight.w700,
                          fontSize: 20),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0, left: 3),
                      child: Text(
                        widget.name,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 3,
                        top: 15,
                      ),
                      child: Text(
                        "Made in",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 3,
                        top: 5,
                      ),
                      child: Text(
                        "India",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 11,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 3,
                        top: 15,
                      ),
                      child: Text(
                        "Description",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 3, top: 5, right: 30),
                      child: Text(
                        widget.dis,
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Gap(100)
                  ],
                ),
              ),
            ),
            color: bgcolor,
          ),
          // image container
          Expanded(
              child: Container(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 290),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 22,
                        color: Colors.white,
                      )),
                  Gap(110),
                  Text(
                    "Product",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 17),
                  )
                ],
              ),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(widget.getimage), fit: BoxFit.cover),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(35),
              ),
            ),
            height: 380,
          )),
          // Fav Icon container
          Positioned(
            top: 365,
            left: 290,
            child: Container(
              height: 35,
              width: 35,
              child: Center(
                child: IconButton(
                    onPressed: () {
                      setState(() {
                        isfav = !isfav;
                        isfavColor = !isfavColor;
                      });
                    },
                    icon: Icon(
                      isfav ? Icons.favorite_border : Icons.favorite,
                      color: isfavColor ? Colors.grey : Colors.pink,
                      size: 20,
                    )),
              ),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    blurRadius: 5, color: Color.fromARGB(131, 158, 158, 158))
              ], color: bgcolor, borderRadius: BorderRadius.circular(50)),
            ),
          ),
          // Buy button
          Positioned(
            top: 630,
            child: Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: buttonColor,
                      blurRadius: 15,
                      spreadRadius: -5,
                    )
                  ],
                  color: bgcolor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35))),
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 25, right: 25, top: 20),
                    child: Container(
                      child: Center(
                        child: Text(
                          "Buy Now",
                          style: TextStyle(color: bgcolor),
                        ),
                      ),
                      height: 45,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: buttonColor,
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
