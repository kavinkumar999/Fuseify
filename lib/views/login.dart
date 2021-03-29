import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fuseify/bloc/authenticate/authenticate_bloc.dart';
import 'package:fuseify/views/home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController api = TextEditingController();
  TextEditingController secret = TextEditingController();

 
  

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey ,
      body: BlocListener<AuthenticateBloc, AuthenticateState>(
        listener: (context, authstate) {
          if (authstate is AuthenticateFailed) {
             Fluttertoast.showToast(
              msg: "Invalid Data!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);

          }
          if(authstate is AuthenticateNullError){
            Fluttertoast.showToast(
              msg: "Please enter the value!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);

          }
          if(authstate is AuthenticateAuthenticated){
           Fluttertoast.showToast(
              msg: "Login Sucessfully!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
            Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Home(),
            ),
          );

          }
        },
        child: Container(
          color: Colors.white,
          height: height,
          width: width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                    height: height * 0.30,
                    width: width,
                    child: Image.asset("assets/login.jpg",
                    ),
                  ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                  child: TextField(
                    controller: api,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.api),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        labelText: "Api Key",
                        hintText: "api"),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                  child: TextField(
                    controller: secret,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.vpn_key),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        labelText: "Api Secret",
                        hintText: "secret"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                  child: ButtonTheme(
                    height: 50,
                    minWidth: 200,
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      elevation: 15,
                      child: Text(
                        "Login",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () {
                        String _api = api.text.toString().trim();
                        String _secret = secret.text.toString().trim();
                       if (_api == "" || _secret == ""){
                          BlocProvider.of<AuthenticateBloc>(context)..add(LoginFailedNull());
                        }
                        else{
                            BlocProvider.of<AuthenticateBloc>(context)
                          ..add(LoginInitiated(_api, _secret));
                        }
                        

                      },
                    ),
                  ),
                ),
                Container(
                  child: Image.asset(
                    "assets/login_bottom.png",
                    width: width * 4,
                    alignment: Alignment.bottomRight,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
