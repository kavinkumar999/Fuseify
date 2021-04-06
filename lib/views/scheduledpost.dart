import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuseify/bloc/stack/stack_bloc.dart';
import 'package:fuseify/utils/Colors.dart';
import 'package:fuseify/utils/common.dart';
import 'package:fuseify/views/post.dart';

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
        color: Colors.white,
        fontSize: 20,
      ),
    ),
  );
}

void navigate(context, String res) {
  print("press");
  if (res == "post") {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Post(),
        ));
  } else if (res == "scheduledpost") {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Notifications(),
        ));
  } else {
    Navigator.pop(context);
  }
}

List<dynamic> arr;
class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications>  {
  final filters = ["All Posted", "Facebook", "Twitter", "Instagram"];
  String currentFilter = "All Posted";
  // BlocProvider.of<PostBloc>(context)..add(PostProvision(value));

  List images = [
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

  Widget item({String image,String caption,double hours}) {
    int _hour = hours.toInt();
    return GestureDetector(
      onTap: () {
        print(image);
      },
      child: Container(
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child:
                  Image.asset(image, height: 70, width: 70, fit: BoxFit.cover),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '$caption',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Text('$_hour'+' hours ago', style: TextStyle(color: Colors.black))
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
    BlocProvider.of<StackBloc>(context)..add(Stackimage());

   return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            bottom: false,
            child: BlocConsumer<StackBloc, StackState>(
              listener: (context, state) {
                if(state is Imagelist){
                  arr = state.a;
                }
                // TODO: implement listener
              },
              builder: (context, state) {
                if(state is Imagelist){
                  arr = state.a;
                  print(arr);
                }
                if (state is Allpost) {
                  currentFilter = "All Posted";
                }
                if (state is Facebook) {
                  // images = ["assets/connect.jpg"];
                  currentFilter = "Facebook";
                }
                if (state is Twitter) {
                  currentFilter = "Twitter";
                }
                if (state is Instagram) {
                  currentFilter = "Instagram";
                }

                return Column(
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
                                navigate(context, "res")
                            },
                            child: Icon(
                              Icons.chevron_left,
                              color: UIColors.navyBlue,
                              size: 30,
                            ),
                          ),
                          InkWell(
                              onTap: () => navigate(context, "post"),
                              child: Icon(
                                Icons.add_circle,
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
                                  "Post",
                                  style: TextStyle(
                                    fontSize: 38,
                                    color: UIColors.navyBlue,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                                SizedBox(width: 20),
                                // badge ?? SizedBox(),
                                badge(arr.length),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: 20,
                            margin:
                                EdgeInsets.fromLTRB(padding, 15, padding, 20),
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: filters.length,
                              separatorBuilder: (_, __) => SizedBox(width: 40),
                              itemBuilder: (context, index) {
                                final filter = filters[index];
                                bool active = currentFilter == filter;
                                return GestureDetector(
                                  onTap: () {

                                    print(filter);
                                    BlocProvider.of<StackBloc>(context)
                                      ..add(Mediaoption(filter));
                                  },
                                  child: Container(
                                    child: Text(
                                      filter.toUpperCase(),
                                      style: TextStyle(
                                        color: active
                                            ? UIColors.navyBlue
                                            : Colors.grey.shade400,
                                        fontSize: 18,
                                        letterSpacing: 0.4,
                                      ),
                                    ),
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
                                separatorBuilder: (_, __) =>
                                    SizedBox(height: 46),
                                itemCount: arr.length == null ? 0:arr.length,
                                itemBuilder: (context, index) {
                                  if(currentFilter == "Facebook"){
                                    if(arr[index][3] == 0){
                                      return SizedBox();
                                    }
                                    return  item(image: images[index],caption: arr[index][1],hours: arr[index][6]);


                                  }
                                  if(currentFilter == "Instagram"){
                                    if(arr[index][4] == 0){
                                      return SizedBox();
                                    }
                                    return  item(image: images[index],caption: arr[index][1],hours: arr[index][6]);


                                  }
                                  if(currentFilter == "Twitter"){
                                     if(arr[index][5] == 0){
                                      return SizedBox();
                                    }
                                    return  item(image: images[index],caption: arr[index][1],hours: arr[index][6]);

                                  }
                                  return  item(image: images[index],caption: arr[index][1],hours: arr[index][6]);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            )),
      ),
    );

    
  }
}
