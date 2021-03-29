
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuseify/bloc/authenticate/authenticate_bloc.dart';
import 'package:fuseify/bloc/post/post_bloc.dart';
import 'package:fuseify/bloc/post_provision/post_provision_bloc.dart';
import 'package:fuseify/bloc/stack/stack_bloc.dart';
import 'package:fuseify/views/intro.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized(); 
  runApp(MultiBlocProvider(

    providers: [
      BlocProvider(create: (context) => AuthenticateBloc()),
      BlocProvider(create: (context) => PostBloc()),
      BlocProvider(create: (context) => PostProvisionBloc()),
      BlocProvider(create: (context) => StackBloc()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      color: Colors.white,
      theme: ThemeData(
        fontFamily: 'ProductSans',
      ),
      home: Starter(),
    );
  }
}

class Starter extends StatefulWidget {
  Starter({Key key}) : super(key: key);

  @override
  _StarterState createState() => _StarterState();
}

class _StarterState extends State<Starter> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroPage(),
    );
  }
}
