import 'package:flutter/material.dart';
import 'package:fuseify/views/home.dart';
import 'package:fuseify/views/login.dart';

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
      color: Colors.white70,
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
                  colors: [Colors.white70, Colors.white70],
                ),
              ),
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [.4, 1],
                          colors: [Colors.white70, Colors.white70],
                        ),
                        borderRadius: BorderRadius.only(topLeft: radius)),
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: Container(
                            child: Image(
                              image: AssetImage("assets/mobile1.png"),
                              width: 250,
                              height: 250,
                            ),
                          ),
                        ),
                        const SizedBox(height: 55),
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: PageView.builder(
                              itemCount: 4,
                              physics: AlwaysScrollableScrollPhysics(),
                              controller: _controller,
                              onPageChanged: (index1) {
                                setState(() {
                                  if (index1 == 0) {
                                    progressvalue = 0.25;
                                  } else if (index1 == 1) {
                                    progressvalue = 0.50;
                                  } else if (index1 == 2) {
                                    progressvalue = 0.75;
                                  } else if (index1 == 3) {
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
                                      width: MediaQuery.of(context).size.width,
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
                                  if (progressvalue == 0.25) {
                                    _controller.jumpToPage(1);
                                  } else if (progressvalue == 0.50) {
                                    _controller.jumpToPage(2);
                                  } else if (progressvalue == 0.75) {
                                    _controller.jumpToPage(3);
                                  } else if (progressvalue == 1) {
                                    print(progressvalue);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()),
                                    );
                                  }
                                },
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: Colors.white70),
                                          child: Icon(Icons.arrow_forward,
                                              color: Colors.black, size: 30)),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                          height: 53,
                                          width: 53,
                                          child: CircularProgressIndicator(
                                            value: progressvalue,
                                            valueColor: AlwaysStoppedAnimation(
                                                Colors.red),
                                          )),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
