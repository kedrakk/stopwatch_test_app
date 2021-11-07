import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class RequestEmailFiveMInutesPage extends StatefulWidget {
  const RequestEmailFiveMInutesPage({ Key? key }) : super(key: key);

  @override
  _RequestEmailFiveMInutesPageState createState() => _RequestEmailFiveMInutesPageState();
}

class _RequestEmailFiveMInutesPageState extends State<RequestEmailFiveMInutesPage> {

  DateTime? currentDate;
  DateTime? destiDate;
  Duration? dateDiff;
  DateTime? updatedCurrentDate;
  int count=0;

  storedTimeData()async{
    currentDate=DateTime.now();
    SharedPreferences preferences=await SharedPreferences.getInstance();
    preferences.setString("reqtime", currentDate!.toString());
    destiDate=currentDate!.add(Duration(minutes: 5));
    Timer.periodic(Duration(seconds: 1), (Timer t) =>calAvailableTime());
  }

  getStoredDate()async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    if(preferences.getString("reqtime")!=null&&preferences.getString("reqtime")!=""){
      currentDate=DateTime.parse(preferences.getString("reqtime")!);
      destiDate=currentDate!.add(Duration(minutes: 5));
      Timer.periodic(Duration(seconds: 1), (Timer t) =>calAvailableTime());
    }
  }

  calAvailableTime(){
    if(destiDate==updatedCurrentDate){
      
    }
    else{
      setState(() {
        updatedCurrentDate=DateTime.now();
        dateDiff=destiDate!.difference(updatedCurrentDate!);
      });
    }
  }

  removeStoredData()async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    preferences.setString("reqtime", "");
    Timer.periodic(Duration(seconds: 1), (Timer t) =>calAvailableTime());
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('MM/dd/yyyy hh:mm:ss').format(dateTime);
  }

  @override
    void initState() {
      getStoredDate();
      super.initState();
    }

  _showMessage(String msg){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Email Request Timer"),),
      body: Container(
        child: Column(children: [
          TextButton(onPressed: (){
            if(count==0&&dateDiff!=null&&(dateDiff!.inHours>0&&dateDiff!.inMinutes>0&&dateDiff!.inSeconds>0)){
              count++;
              storedTimeData();
            }else{
              _showMessage("Too many attempts!!!");
            }
          }, child: Text("Request Email")),
          SizedBox(height: 10,),
          currentDate!=null?Text("Current Date:"+_formatDateTime(currentDate!)):Text(""),
          SizedBox(height: 10,),
          updatedCurrentDate!=null?Text("Updated Current Date:"+_formatDateTime(updatedCurrentDate!)):Text(""),
          SizedBox(height: 10,),
          dateDiff!=null?Text("Date Difference:"+dateDiff!.toString()):Text(""),
          SizedBox(height: 10,),
          destiDate!=null?Text("DestiDate Date:"+_formatDateTime(destiDate!)):Text(""),
          
        ],),
      ),
    );
  }
}