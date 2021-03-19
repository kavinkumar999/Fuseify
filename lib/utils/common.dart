import 'package:flutter/material.dart';
import 'package:fuseify/bloc/post/post_bloc.dart';
import 'package:fuseify/views/intro.dart';
import 'package:fuseify/views/post.dart';
import 'package:fuseify/views/scheduledpost.dart';
import 'package:http/http.dart';

import 'Colors.dart';

const double padding = 30;

Widget badge(int count) {
  return Container(
    padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
    decoration: BoxDecoration(
      color: Colors.red,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(
      count.toString(),
      style: TextStyle(
        color:Colors.white,
        fontSize: 20,
      ),
    ),
  );
}

class PageScaffold extends StatelessWidget {
  final bool home;
  final String title;
  final String subtitle;
  final Widget badge;
  final List<Widget> children;
  final Color backgroundColor;

  PageScaffold({
    this.home = false,
    @required this.title,
    this.subtitle,
    this.badge,
    this.children = const <Widget>[],
    this.backgroundColor,
  });

  final Column menuIcon = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(color: Colors.black, height: 2.5, width: 14),
      SizedBox(height: 5),
      Container(color: Colors.black, height: 2.5, width: 24)
    ],
  );

  void navigate(context, String res) {
    print("press");
    if (res == "post")
    {
      
    Navigator.push(context, MaterialPageRoute(builder: (context) => Post(),));



    }
    else if (res =="scheduledpost")
    {

      Navigator.push(context, MaterialPageRoute(builder: (context) => Notifications(),));

    }

    else{
      Navigator.pop(context);

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(padding, 30, padding, 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: () => {
                      if(home){
                          navigate(context, "scheduledpost")
                      }
                      else{
                        navigate(context, "res")
                      }
                      

                    },
                    child: home
                        ? Icon(Icons.notifications_active)
                        : Icon(
                            Icons.chevron_left,
                            color: UIColors.navyBlue,
                            size: 30,
                          ),
                  ),
                  InkWell(
                    onTap: () => navigate(context, "post"),
                    child: Icon(Icons.add_circle,size: 50,)
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  SizedBox(height: 40),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: padding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 38,
                            color: UIColors.navyBlue,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                          ),
                        ),
                        SizedBox(width: 20),
                        badge ?? SizedBox(),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  if (subtitle != null)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: padding),
                      child: Text(
                        subtitle,
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ...children,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
