import 'package:college_chat/constants/colors.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  TextEditingController searchTextEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text('Search',
          style: TextStyle(
            color: WHITE,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        backgroundColor: VERY_DARK_BLUE,
      ),
    body: Container(
      child: Column(
        children: [
          Container(
            color: DARK_GREYISH_BLUE,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                      controller: searchTextEditingController,
                      style: TextStyle(
                        color: STRONG_CYAN,
                      ),
                      decoration: InputDecoration(
                      hintText: "search username...",
                      hintStyle: TextStyle(
                        color: WHITE,
                      ),
                      border: InputBorder.none,
                    ),
                    ),
                ),
                Container(
                  height: 40,
                  width: 40,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          VERY_DARK_BLUE,
                          DARK_GREYISH_BLUE
                        ]
                      ),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    padding: EdgeInsets.all(12.0),
                    child: Image.asset("assets/images/search_white.png")),
              ],
            ),
          )
        ],
      ),
    ),
    ),
    );
  }
}
