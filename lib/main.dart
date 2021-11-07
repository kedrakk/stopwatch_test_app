import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stopwatch_app/testlimitattemp.dart';
import 'package:stopwatch_app/testroundedtopPage.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
    statusBarColor: Colors.black
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: RoundedPageDart(),
    );
  }
}

class Splash extends StatelessWidget {
  const Splash({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Splash"),
        actions: [
          IconButton(icon: Icon(Icons.class_), onPressed: (){
            var a=DateTime.now().add(Duration(minutes: 3)).isAfter(DateTime.now());
            print(a.toString());
          })
        ],
      ),
      body: Center(child: TextButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>TestLimitAttempPage()));
      }, child: Text("go to new page")),),
    );
  }
}