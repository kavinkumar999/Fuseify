import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuseify/bloc/post/post_bloc.dart';
import 'package:fuseify/utils/Colors.dart';
import 'package:fuseify/utils/customdialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fuseify/utils/common.dart';

class Post extends StatefulWidget {
  @override
  _PostState createState() => _PostState();
}

File _image;

class _PostState extends State<Post> {
  final picker = ImagePicker();

  TextEditingController _controller = new TextEditingController();
  Future getImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  int selection = 1;
  int posttime = 0;
  bool future = false;


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<PostBloc, PostState>(
          listener: (context, state) {
            if(state is Futureselection){
              future = state.option;
            }
            
            if (state is Postimage) {
              selection = 1;
            }
            if (state is Posttext) {
              selection = 2;
            }
            // TODO: implement listener
          },
          builder: (context, state) {
            String imgname;
            
            // if(state is Uploadstarted){
            //   return Center(child: Scaffold(
            //     backgroundColor: Colors.transparent,
            //     body: Center(child: CircularProgressIndicator())));
            // }
            if (state is Postimage) {
              return SafeArea(
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
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.chevron_left,
                                size: 50,
                              )),
                          InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.cancel,
                                size: 50,
                              )),
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
                                  "Create a Post",
                                  style: TextStyle(
                                    fontSize: 38,
                                    color: UIColors.navyBlue,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  Radio(
                                    value: 1,
                                    groupValue: selection,
                                    onChanged: (value) {
                                      selection = value;
                                      BlocProvider.of<PostBloc>(context)
                                        ..add(PostProvision(value));
                                    },
                                  ),
                                  Text("Image")
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                    value: 2,
                                    groupValue: selection,
                                    onChanged: (value) {
                                      selection = value;
                                      BlocProvider.of<PostBloc>(context)
                                        ..add(PostProvision(value));
                                    },
                                  ),
                                  Text("Text")
                                ],
                              )
                            ],
                          ),
                          Container(
                            height: height * 0.40,
                            width: width,
                            child: _image == null
                                ? Icon(
                                    Icons.photo,
                                    size: 100,
                                  )
                                : Image.file(_image),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              FloatingActionButton(
                                heroTag: "1",
                                onPressed: getImage,
                                tooltip: "Pick Image",
                                child: Icon(Icons.add_a_photo),
                              ),
                              FloatingActionButton(
                                onPressed: () {
                                  setState(() {
                                    _image = null;
                                  });
                                },
                                heroTag: "2",
                                tooltip: "Cancel",
                                child: Icon(Icons.cancel),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              height: 200,
                              // decoration: BoxDecoration(
                              //   // border: Border.all(color: Colors.black),
                              //   // borderRadius: BorderRadius.circular(10),
                              // ),
                              color: Color(0xffeeeeee),
                              padding: EdgeInsets.all(10.0),
                              child: new ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxHeight: 200.0,
                                ),
                                child: new Scrollbar(
                                  child: new SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    reverse: true,
                                    child: SizedBox(
                                      height: 190.0,
                                      child: new TextField(
                                        controller: _controller,
                                        maxLines: 100,
                                        decoration: new InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Add your caption here',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),  Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Checkbox(value: future, onChanged: (value)  {
                                print("text");
                                if(future){
                                  setState(() {
                                    future = false;
                                  });
                                }
                                else{
                                  setState(() {
                                    future= true;
                                  });
                                }
                                //  BlocProvider.of<PostBloc>(context)..add(Futurepost(future));

                                
                              },),
                              Text("Future Post",style: TextStyle(fontSize: 20),),

                            ],

                        ),
                          ),
                          future ? Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                IconButton(icon: Icon(Icons.remove), onPressed: () {
                                  setState(() {
                                    posttime = posttime - 1;
                                  });
                                },),
                                
                                Text("$posttime"),
                                IconButton(icon: Icon(Icons.add), onPressed: () {
                                  setState(() {
                                    posttime = posttime + 1;
                                  });
                                },),
                                Text("Hrs"),

                              ],
                            ),
                          ) : SizedBox(),
                        SizedBox(
                          height: 20,
                        ),
                          Container(
                            // width: 50,
                            padding: EdgeInsets.only(
                                left: width * 0.25, right: width * 0.25),
                            // height: 50,
                            child: FlatButton(
                              // elevation: 15,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              onPressed: () => {
                                imgname = _image.path.split("/").last,
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return CustomDialogBox(
                                        basee64: base64Encode(
                                            _image.readAsBytesSync()),
                                        imagename: imgname,
                                        text: _controller.text,
                                        img: true,
                                      );
                                    }),

                                // BlocProvider.of<PostBloc>(context)..add(UploadingEvent(base64Encode(_image.readAsBytesSync()),imgname,_controller.text)),
                              },
                              color: Colors.pink,
                              child: Text(
                                'Upload',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 200,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            if (state is Posttext) {
              return SafeArea(
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
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.chevron_left,
                                size: 50,
                              )),
                          InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.cancel,
                                size: 50,
                              )),
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
                                  "Create a Post",
                                  style: TextStyle(
                                    fontSize: 38,
                                    color: UIColors.navyBlue,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  Radio(
                                    value: 1,
                                    groupValue: selection,
                                    onChanged: (value) {
                                      selection = value;
                                      BlocProvider.of<PostBloc>(context)
                                        ..add(PostProvision(value));
                                    },
                                  ),
                                  Text("Image")
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                    value: 2,
                                    groupValue: selection,
                                    onChanged: (value) {
                                      selection = value;
                                      BlocProvider.of<PostBloc>(context)
                                        ..add(PostProvision(value));
                                    },
                                  ),
                                  Text("Text")
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              height: 200,
                              color: Color(0xffeeeeee),
                              padding: EdgeInsets.all(10.0),
                              child: new ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxHeight: 200.0,
                                ),
                                child: new Scrollbar(
                                  child: new SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    reverse: true,
                                    child: SizedBox(
                                      height: 190.0,
                                      child: new TextField(
                                        controller: _controller,
                                        maxLines: 100,
                                        decoration: new InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Add your caption here',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ), Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Checkbox(value: future, onChanged: (value)  {
                                print("text");
                                if(future){
                                  setState(() {
                                    future = false;
                                  });
                                }
                                else{
                                  setState(() {
                                    future= true;
                                  });
                                }
                                //  BlocProvider.of<PostBloc>(context)..add(Futurepost(future));

                                
                              },),
                              Text("Future Post",style: TextStyle(fontSize: 20),),

                            ],

                        ),
                          ),
                          future ? Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                IconButton(icon: Icon(Icons.remove), onPressed: () {
                                  setState(() {
                                    posttime = posttime - 1;
                                  });
                                },),
                                
                                Text("$posttime"),
                                IconButton(icon: Icon(Icons.add), onPressed: () {
                                  setState(() {
                                    posttime = posttime + 1;
                                  });
                                },),
                                Text("Hrs"),

                              ],
                            ),
                          ) : SizedBox(),
                        SizedBox(
                          height: 20,
                        ),
                          Container(
                            // width: 50,
                            padding: EdgeInsets.only(
                                left: width * 0.25, right: width * 0.25),
                            // height: 50,
                            child: FlatButton(
                              // elevation: 15,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              onPressed: () => {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return CustomDialogBox(
                                        basee64: "base",
                                        imagename: "imgname",
                                        text: _controller.text,
                                        img: false,
                                      );
                                    }),

                                // BlocProvider.of<PostBloc>(context)..add(UploadingEvent(base64Encode(_image.readAsBytesSync()),imgname,_controller.text,true,true,true)),
                              },
                              color: Colors.pink,
                              child: Text(
                                'Upload',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 200,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return SafeArea(
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
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.chevron_left,
                              size: 50,
                            )),
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.cancel,
                              size: 50,
                            )),
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
                                "Create a Post",
                                style: TextStyle(
                                  fontSize: 38,
                                  color: UIColors.navyBlue,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Radio(
                                  value: 1,
                                  groupValue: selection,
                                  onChanged: (value) {
                                    selection = value;
                                    BlocProvider.of<PostBloc>(context)
                                      ..add(PostProvision(value));
                                  },
                                ),
                                Text("Image")
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                  value: 2,
                                  groupValue: selection,
                                  onChanged: (value) {
                                    selection = value;
                                    BlocProvider.of<PostBloc>(context)
                                      ..add(PostProvision(value));
                                  },
                                ),
                                Text("Text")
                              ],
                            )
                          ],
                        ),
                        Container(
                          height: height * 0.40,
                          width: width,
                          child: _image == null
                              ? Icon(
                                  Icons.photo,
                                  size: 100,
                                )
                              : Image.file(_image),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            FloatingActionButton(
                              heroTag: "1",
                              onPressed: getImage,
                              tooltip: "Pick Image",
                              child: Icon(Icons.add_a_photo),
                            ),
                            FloatingActionButton(
                              onPressed: () {
                                setState(() {
                                  _image = null;
                                });
                              },
                              heroTag: "2",
                              tooltip: "Cancel",
                              child: Icon(Icons.cancel),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            height: 200,
                            // decoration: BoxDecoration(
                            //   // border: Border.all(color: Colors.black),
                            //   // borderRadius: BorderRadius.circular(10),
                            // ),
                            color: Color(0xffeeeeee),
                            padding: EdgeInsets.all(10.0),
                            child: new ConstrainedBox(
                              constraints: BoxConstraints(
                                maxHeight: 200.0,
                              ),
                              child: new Scrollbar(
                                child: new SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  reverse: true,
                                  child: SizedBox(
                                    height: 190.0,
                                    child: new TextField(
                                      controller: _controller,
                                      maxLines: 100,
                                      decoration: new InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Add your caption here',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                         Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Checkbox(value: future, onChanged: (value)  {
                                print("text");
                                if(future){
                                  setState(() {
                                    future = false;
                                  });
                                }
                                else{
                                  setState(() {
                                    future= true;
                                  });
                                }
                                //  BlocProvider.of<PostBloc>(context)..add(Futurepost(future));

                                
                              },),
                              Text("Future Post",style: TextStyle(fontSize: 20),),

                            ],

                        ),
                          ),
                          future ? Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                IconButton(icon: Icon(Icons.remove), onPressed: () {
                                  setState(() {
                                    posttime = posttime - 1;
                                  });
                                },),
                                
                                Text("$posttime"),
                                IconButton(icon: Icon(Icons.add), onPressed: () {
                                  setState(() {
                                    posttime = posttime + 1;
                                  });
                                },),
                                Text("Hrs"),

                              ],
                            ),
                          ) : SizedBox(),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          // width: 50,
                          padding: EdgeInsets.only(
                              left: width * 0.25, right: width * 0.25),
                          // height: 50,
                          child: FlatButton(
                            // elevation: 15,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            onPressed: () => {
                              imgname = _image.path.split("/").last,
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CustomDialogBox(
                                      basee64: base64Encode(
                                          _image.readAsBytesSync()),
                                      imagename: imgname,
                                      text: _controller.text,
                                      img: true,
                                      future: future,
                                      hrs: posttime,
                                    );
                                  }),

                              // BlocProvider.of<PostBloc>(context)..add(UploadingEvent(base64Encode(_image.readAsBytesSync()),imgname,_controller.text)),
                            },
                            color: Colors.pink,
                            child: Text(
                              'Upload',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 200,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}

Widget topicon(context) {
  Padding(
    padding: EdgeInsets.fromLTRB(padding, 30, padding, 6),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.chevron_left,
              size: 50,
            )),
        InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.cancel,
              size: 50,
            )),
      ],
    ),
  );
}

Widget heading() {
  Padding(
    padding: EdgeInsets.symmetric(horizontal: padding),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Create a Post",
          style: TextStyle(
            fontSize: 38,
            color: UIColors.navyBlue,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
        ),
      ],
    ),
  );
}
