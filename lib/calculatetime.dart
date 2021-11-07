import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CaluclateTimePage extends StatefulWidget {
  const CaluclateTimePage({ Key? key }) : super(key: key);

  @override
  _CaluclateTimePageState createState() => _CaluclateTimePageState();
}

class _CaluclateTimePageState extends State<CaluclateTimePage> {
  DateTime? currentDate;
  DateTime? destiDate;
  Duration? dateDiff;
  DateTime? updatedCurrentDate;
  int count=0;

  @override
  void initState() {
    getStoredDate();
    super.initState();
  }

  getStoredDate()async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    String? storedDate=preferences.getString("storedtime");
    if(storedDate!=null&&storedDate!=""){
      currentDate=DateTime.parse(storedDate);
      destiDate=currentDate!.add(Duration(minutes: 5));
      Timer.periodic(Duration(seconds: 1), (Timer t) =>calAvailableTime());
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('MM/dd/yyyy hh:mm:ss').format(dateTime);
  }

  calAvailableTime(){
    setState(() {
      updatedCurrentDate=DateTime.now();
      dateDiff=destiDate!.difference(updatedCurrentDate!);
    });
  }

  storedData()async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    preferences.setString("storedtime", DateTime.now().toString());
    _showMessage("Stored key success");
  }

  _showMessage(String msg){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculate Time"),
      ),
      body: dateDiff==null?TextButton(
        onPressed: (){
          if(count<=5){
            count++;
            _showMessage("$count times request");
          }
          else if(count==5){
            storedData();
          }
          else{
            _showMessage("Request Limits reached");
            getStoredDate();
          }
        }, 
        child: Text("Request Email")
      ):Column(children: [
        Text("start date:"+_formatDateTime(currentDate!)),SizedBox(height: 20,),
        Text("end date:"+_formatDateTime(destiDate!)),SizedBox(height: 20,),
        Text("Difference:"+dateDiff!.toString())
      ],),
    );
  }
}