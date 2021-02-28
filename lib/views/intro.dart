import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fuseify/utils/Colors.dart';
import 'package:fuseify/views/home.dart';

double progressvalue = 0.25;

class IntroPage extends StatefulWidget {
  IntroPage({Key key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final _controller = PageController(viewportFraction: 0.88);

  static Radius radius = Radius.circular(115);

  List<String> imageNames = [
    "instagram",
    "facebook",
    "twitter",
    "linkedin",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white24,
      height: MediaQuery.of(context).size.height,
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [/*Color(0xfff2c8d0), Color(0xfff4cdd9)*/UIColors.grey,UIColors.grey],
                ),
              ),
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 269,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(left: 40, right: 60, top: 70),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [-.1, 1],
                          colors: [
                            // Colors.black,
                            // Colors.black,
                            // Color(0xffffffff),
                            // Color(0xfffcf4f6),
                            UIColors.grey,
                            UIColors.grey
                           
                          ],
                        ),
                        borderRadius: BorderRadius.only(bottomRight: radius)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: Text(
                            
                            'Connect Socially',
                            maxLines: 2,
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                                fontSize: 40,
                                // fontFamily: 'ProductSans',
                                fontWeight: FontWeight.w700,
                                // fontStyle: FontStyle.italic,
                                color: Colors.blueAccent), 
                          ),
                        ),
                        Center(
                                                  child: Container(
                            width: 100,
                            height: 80,
                            child: Image(
                              height: 100,
                              width: 100,
                              image: AssetImage("assets/Framer.png"),)
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * .30),
                    height: MediaQuery.of(context).size.height,
                    color: Color(0xfffcf4f6),
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [.4, 1],
                            colors: [
                              // Color(0xfff2c8d0),
                              // Colors.blue,
                              // Colors.lightBlue,
                              UIColors.grey,
                              UIColors.grey


                              // Color(0xfff4cdd9),
                              // Colors.green
                            ],
                          ),
                          borderRadius: BorderRadius.only(topLeft: radius)),
                      child: Column(
                        children: <Widget>[
                          const SizedBox(height: 95),
                          Expanded(
                            flex: 2,
                            child: Container(
                              child: PageView.builder(
                                itemCount: 4,
                                physics: AlwaysScrollableScrollPhysics(),
                                controller: _controller,
                                
                                onPageChanged: (index1) {
                                
                                  setState(() {
                                    if(index1 == 0){
                                    progressvalue = 0.25;
                                    }
                                    else if(index1 == 1){
                                      progressvalue = 0.50;
                                    }
                                    else if(index1 == 2){
                                      progressvalue = 0.75;
                                    }
                                    else if(index1 == 3){
                                      progressvalue = 1.0;
                                    }
                                  });
                                },
                                itemBuilder: (BuildContext context, int index) {
                                  
                                  return ClipRRect(
                                    
                                    borderRadius: BorderRadius.circular(30),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          print("Image Clicked");
                                        });
                                      },
                                      child: Image(
                                        image: AssetImage(
                                            "assets/${imageNames[index]}.png"),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 140,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    if(progressvalue == 0.25){
                                      _controller.jumpToPage(1);
                                      }
                                      else if(progressvalue == 0.50){
                                      _controller.jumpToPage(2);
                                      }
                                      else if(progressvalue == 0.75){
                                      _controller.jumpToPage(3);
                                      }
                                    else if(progressvalue == 1)
                                    {
                                      print(progressvalue);
                                      Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Home()),
                                    );

                                    }
                                    
                                    
                                  },
                                  child: Stack(children: [
                                    Align(
                                    alignment: Alignment.center,
                                      child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.white
                                      ),
                                      child: Icon(Icons.arrow_forward,color: Colors.black, size: 30)),
                                  ),
                                  Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: 53,
                                    width: 53,
                                    child: CircularProgressIndicator(
                                      value: progressvalue,
                                      valueColor: AlwaysStoppedAnimation(Colors.red),
                                      
                                      // backgroundColor: Colors.purple,
                                      )),

                                )

                                  ],),
                                  
                                  
                                ),
                                
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}