import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:html_editor_enhanced/html_editor.dart';

class RoundedPageDart extends StatefulWidget {
  const RoundedPageDart({ Key? key }) : super(key: key);

  @override
  _RoundedPageDartState createState() => _RoundedPageDartState();
}

class _RoundedPageDartState extends State<RoundedPageDart> {
  String rawIcon='{"name":"IconDataBrands","codePoints":"0xe057"}';

 List<dynamic> iconTypeList=[ IconDataBrands,IconDataDuotone,IconDataLight,IconDataProperty,IconDataRegular,IconDataSolid,IconDataThin];
  HtmlEditorController _controller=HtmlEditorController();

  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(title: Text("Rounded Text"),
        elevation: 6.0,
        shape: ContinuousRectangleBorder(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(90.0),topRight: Radius.circular(90.0),
        ),),
        actions: [
          IconButton(
            onPressed: (){
              var a=jsonDecode(rawIcon);
              print(a["name"]);
              print(a.toString());
            },
            icon: Icon(Icons.close)
          )
        ],
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Column(
            children: [
              Center(child: Text("Hello")),
              FaIcon(FontAwesomeIcons.seedling),
              HtmlEditor(
                controller: _controller,
                htmlEditorOptions: HtmlEditorOptions(
                  hint: "Your text here...",
                ),   
                otherOptions: OtherOptions(
                  height: 400,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}