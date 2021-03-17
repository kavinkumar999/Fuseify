
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuseify/bloc/post/post_bloc.dart';

class CustomDialogBox extends StatefulWidget {
  final  String basee64 , imagename , text;
  // final Image img;

  const CustomDialogBox({Key key, this.basee64, this.imagename, this.text}) : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}
bool all = false;
bool facebook = false;
bool twitter = false;
bool instagram = false;

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: BlocConsumer<PostBloc, PostState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 20,top: 70 ,
               right: 20,bottom: 20
          ),
          margin: EdgeInsets.only(top: 50),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(color: Colors.black,offset: Offset(0,10),
              blurRadius: 10
              ),
            ]
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(value: all, onChanged: (value) {
                    setState(() {
                      if(all){
                        all = false;
                        facebook = false;
                        twitter = false;
                        instagram = false;
                      }
                      else{
                        all = true;
                        facebook = true;
                        twitter = true;
                        instagram = true;
                      }
                      // if(facebook)
                    });
                    
                  },),
                  Text("All")
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(value: facebook, onChanged: (value) {
                    setState(() {
                      // facebook = !value;
                      if(facebook){
                        facebook = false;
                      }
                      else{
                        facebook = true;
                      }

                    });
                  },),
                  Text("Facebook")
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(value: twitter, onChanged: (value) {
                    setState(() {
                      // twitter = !value;
                      if(twitter){
                        twitter = false;
                      }
                      else{
                        twitter = true;
                      }
                    });
                  },),
                  Text("Twitter")
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(value: instagram, onChanged: (value) {
                    setState(() {
                      // instagram = !value;
                      instagram = instagram == true ? false : true;

                    });
                    
                  },),
                  Text("Instagram")
                ],
              ),
              FlatButton(
                                // elevation: 15,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                onPressed: () => {
                                  BlocProvider.of<PostBloc>(context)..add(UploadingEvent(widget.basee64,widget.imagename,widget.text,facebook,instagram,twitter)),

                                },
                                color: Colors.pink,
                                child: Text(
                                  'Post',
                                  style: TextStyle(color: Colors.white, fontSize: 20),
                                ),
                              ),

              
            ],
          ),
        ),
        Positioned(
          left: 20,
            right: 20,
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(80)),
                  child: Image.asset(
                    "assets/mes.png",height: 600,width: 600,
                  ),
              ),
            ),
        ),
      ],
    );
        },
      )
      
    );
  }
}

