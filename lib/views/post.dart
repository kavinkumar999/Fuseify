import 'package:flutter/material.dart';
import 'package:fuseify/utils/common.dart';

class Post extends StatefulWidget {
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      home: true,
      title: 'Post it',
      subtitle: 'Social dashboard',
      backgroundColor: Colors.white,

      
    );
  }
}