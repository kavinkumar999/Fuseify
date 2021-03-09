import 'package:flutter/material.dart';
import 'package:fuseify/utils/Colors.dart';
import 'package:fuseify/utils/common.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final filters = ["All Post"];
  String currentFilter = "All Post";

  final images = [
    'assets/posts/3.jpg',
    'assets/posts/5.jpg',
    'assets/posts/1.jpg',
    'assets/posts/4.jpg',
    'assets/posts/3.jpg',
    'assets/posts/5.jpg',
    'assets/posts/1.jpg',
    'assets/posts/3.jpg',
    'assets/posts/4.jpg',
  ];

  Widget item({String image}) {
    return GestureDetector(
      onTap: () {
        print(image);
      },
          child: Container(
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(image, height: 70, width: 70, fit: BoxFit.cover),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Hi, I m kavin kumar from Computer science and Engineering ! :)"',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Text('2 hours ago', style: TextStyle(color: Colors.black))
                ],
              ),
            ),
            SizedBox(width: 40),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: PageScaffold(
        backgroundColor: Colors.white,
        title: 'Posts',
        badge: badge(12),
        children: <Widget>[
          // Padding(
          //   padding: EdgeInsets.all(padding),
          //   child: TextField(
          //     decoration: InputDecoration(
          //       filled: true,
          //       fillColor: UIColors.s,
          //       contentPadding: EdgeInsets.all(20),
          //       prefixIcon: Icon(
          //         Icons.search,
          //         color: UIColors.navyBlue,
          //         size: 26,
          //       ),
          //       hintText: 'Search for name',
          //       hintStyle: TextStyle(fontSize: 20, color: Colors.grey.shade400),
          //       border: UnderlineInputBorder(
          //         borderSide: BorderSide.none,
          //         borderRadius: BorderRadius.circular(12),
          //       ),
          //     ),
          //   ),
          // ),
          Container(
            height: 20,
            margin: EdgeInsets.fromLTRB(padding, 15, padding, 20),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              separatorBuilder: (_, __) => SizedBox(width: 40),
              itemBuilder: (context, index) {
                final filter = filters[index];
                bool active = currentFilter == filter;
                return Text(
                  filter.toUpperCase(),
                  style: TextStyle(
                    color: active ? UIColors.navyBlue : Colors.grey.shade400,
                    fontSize: 18,
                    letterSpacing: 0.4,
                  ),
                );
              },
            ),
          ),
          SingleChildScrollView(
                      child: Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.fromLTRB(42, 50, 42, 42),
              decoration: BoxDecoration(
                color: UIColors.softPurple,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(40),
                ),
              ),
              child: ListView.separated(
                shrinkWrap: true,
                // primary: false,
                separatorBuilder: (_, __) => SizedBox(height: 46),
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return item(image: images[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
