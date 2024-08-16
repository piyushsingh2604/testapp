import 'package:flutter/material.dart';
import 'package:testapp/screens/CartScreen.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 40,
            width: 250,

            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  blurRadius: 5,
                  color: Color.fromARGB(32, 158, 158, 158),
                  spreadRadius: 3.3,
                  offset: Offset(
                    1,
                    1.3,
                  ))
            ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
            // textfield
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  // search text
                  hintText: "Search",
                  hintStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 13),
                  // search icon
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: Colors.black,
                    size: 16,
                  )),
            ),
          ),
          IconButton(
              onPressed: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => CardScreen(),
                //     ));
              },
              icon: Icon(
                Icons.shopping_cart_outlined,
                color: Colors.black,
              ))
        ],
      ),
    );
  }
}
