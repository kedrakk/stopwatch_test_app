import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestLimitAttempPage extends StatefulWidget {
  const TestLimitAttempPage({ Key? key }) : super(key: key);

  @override
  _TestLimitAttempPageState createState() => _TestLimitAttempPageState();
}

class _TestLimitAttempPageState extends State<TestLimitAttempPage> {
  String? endTime;
  int? count;
  String? timeDiff;

  @override
    void initState() {
      getData();
      super.initState();
    }

  getData()async{
    await getAttempCount();
    await getEndTime();
    if(timeDiff!=""&&timeDiff=="0"){
      await setAttempCount(0);
      await storeEndTime("");
      await getAttempCount();
      await getEndTime();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Limit Login Attemp"),),
      body: Container(
        child: Column(children: [
          _requestButton(),
          _infoWidget(endTime!=null?"end time $endTime":"no end time"),
          _infoWidget(count!=null?"count $count":"no count yet"),
          _infoWidget(timeDiff!=null?"time difference $timeDiff":"no time diff yet"),
        ],),
      ),
    );
  }

  Widget _requestButton(){
    return TextButton(
      onPressed: ()async{
        if(count==0){
          await setAttempCount(count!+1);
          await storeEndTime(DateTime.now().add(Duration(minutes:5 )).toString());
        }
        else if(count!<5){
          await setAttempCount(count!+1);
        }
        else{
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Too many attempts\nAttempts $count\nTry Again in $timeDiff"),
            duration: Duration(seconds: 1),)
          );
        }
        await getData();
      }, 
      child: Text("Request Via Email")
    );
  }

  Widget _infoWidget(String data){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Text(data),
    );
  }

  setAttempCount(int? _count)async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    sharedPreferences.setString("attemp", _count!.toString());
  }

  getAttempCount()async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    if(sharedPreferences.getString("attemp")!=null&&sharedPreferences.getString("attemp")!=""){
      count=int.parse(sharedPreferences.getString("attemp")!);
    }else{
      count=0;
    }
    if(mounted) setState(() {});
  }

  getEndTime()async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    if(sharedPreferences.getString("endtime")!=null&&sharedPreferences.getString("endtime")!=""){
      endTime=sharedPreferences.getString("endtime").toString();
      checkTimeDifference(DateTime.now(), DateTime.parse(endTime!));
    }else{
      endTime="0";
      timeDiff="0";
    }
    if(mounted) setState(() {});
  }

  storeEndTime(String endTime)async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    sharedPreferences.setString("endtime", endTime);
  }

  checkTimeDifference(DateTime currentTime,DateTime endTime){
    if(endTime.isAfter(currentTime)){
      timeDiff=endTime.difference(currentTime).toString();
    }
    else{
      timeDiff="0";
    }
  }

}