import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fuseify/utils/Colors.dart';
import 'package:fuseify/utils/common.dart';
import 'package:fuseify/utils/panel.dart';

String profile = "kavinkumar";
String username = "kavin_craz";
String photo = "Facebook";

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

List<List<String>> followersList1 = [
  ["Photos", "20"],
  ["Followers", "50"],
  ["Follows", "30"]
];
List<List<String>> followersList2 = [
  ["Photos", "40"],
  ["Followers", "58"],
  ["Follows", "72"]
];
List<List<String>> followersList3 = [
  ["Photos", "25"],
  ["Followers", "20"],
  ["Follows", "30"]
];

class _HomeState extends State<Home> {
  final filters = [
    "Facebook",
    "Instagram",
    "Twitter",
  ];
  String selected = 'Chat';
  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      home: true,
      title: 'Fuseify',
      subtitle: 'Social dashboard',
      backgroundColor: Colors.white,
      children: <Widget>[
        SizedBox(height: 40),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: Row(
            children: <Widget>[
              Expanded(
                child: HomePanel(
                  label: 'Photos',
                  color: UIColors.softRed,
                  count: 65,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: HomePanel(
                  label: 'Follows',
                  color: Colors.blue,
                  count: 108,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: HomePanel(
                  label: 'Friends',
                  color: UIColors.softPurple,
                  count: 152,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Container(
          height: 80,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: padding),
            separatorBuilder: (_, __) => SizedBox(width: padding),
            itemCount: filters.length,
            itemBuilder: (context, index) {
              final option = filters[index];
              bool active = option == selected;
              final textColor =
                  active ? UIColors.yellowOrange : Colors.grey.shade500;
              final fontWeight = active ? FontWeight.bold : FontWeight.normal;
              return FilterChip(
                elevation: 0,
                selected: active,
                pressElevation: 0,
                showCheckmark: false,
                backgroundColor: Colors.white,
                selectedColor: Colors.orange.withOpacity(0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                onSelected: (s) {
                  setState(() {
                    selected = option;
                    profile = option;
                    photo = option;
                  });
                  print(selected);
                },
                label: Text(
                  option.toUpperCase(),
                  style: TextStyle(
                    color: textColor,
                    fontSize: 17,
                    fontWeight: fontWeight,
                    letterSpacing: 0.3,
                  ),
                ),
              );
            },
          ),
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              getMyProfile(context, profile, photo),
              getFollowersBar(context, photo)
            ],
          ),
        )
      ],
    );
  }
}

Widget getMyProfile(context, profile, photo) {
  return Container(
    height: 250,
    color: Color(0xfffbeeef),
    child: ClipRRect(
      borderRadius: BorderRadius.only(bottomRight: Radius.circular(100)),
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.white, Color(0xfffdf6f7)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: 15),
              height: 180,
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xfff6d2eb),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xfffae3f2),
                          blurRadius: 26,
                          spreadRadius: -21,
                          offset: Offset(0, 34)),
                    ],
                    borderRadius: BorderRadius.circular(65)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(65),
                  child: Image(
                    width: 130,
                    height: 130,
                    image: AssetImage("assets/${photo}.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              child: Text(
                profile,
                maxLines: 1,
                overflow: TextOverflow.fade,
                style: TextStyle(
                    color: Color(0xff6a515e),
                    fontSize: 29,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              child: Text(
                "@${username}",
                maxLines: 1,
                overflow: TextOverflow.fade,
                style: TextStyle(
                    color: Color(0xffc7abba),
                    fontSize: 19,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget getFollowersBar(context, photo) {
  List<dynamic> followersList;
  if (photo == "Facebook") {
    followersList = followersList1;
  } else if (photo == "Twitter") {
    followersList = followersList2;
  } else {
    followersList = followersList3;
  }
  print(followersList);
  print(followersList1);
  return Container(
    height: 150,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      gradient: LinearGradient(
          colors: [Colors.white, Color(0xfffdf6f7), Colors.white],
          stops: [0, .22, .1],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight),
    ),
    child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(100), bottomRight: Radius.circular(100)),
        child: Container(
          padding: const EdgeInsets.only(top: 40, left: 8, right: 8),
          color: Color(0xfffbeeef),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: followersList.toList().map((element) {
              print(element);
              return Column(
                children: <Widget>[
                  Text(
                    element[0],
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                        color: Color(0xffc7abba),
                        fontSize: 19,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    element[1],
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                        color: Color(0xff6a515e),
                        fontSize: 21,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              );
            }).toList(),
          ),
        )),
  );
}
