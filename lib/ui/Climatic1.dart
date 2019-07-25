import 'package:flutter/material.dart';

class ChangeCity extends StatefulWidget {
  @override
  _ChangeCityState createState() => _ChangeCityState();
}

class _ChangeCityState extends State<ChangeCity> {
  var _cityFieldController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.redAccent.shade700,
        title: new Text("Change City"),
        centerTitle: true,
      ),
      body: new Stack(
        children: <Widget>[
          new Center(
            child: new Image.asset(
              'images/white_snow.png',
              width:490.0,
              height: 1000.0,
              fit:BoxFit.fill,
            ),
          ),

          new ListView(
            children: <Widget>[
              new ListTile(
                title: new TextField(
                  controller: _cityFieldController,
                  keyboardType: TextInputType.text,
                  decoration: new InputDecoration(
                    hintText: 'Enter City',
                  ),
            
                ),
              ),

              new ListTile(
                title: new FlatButton(
                  onPressed: (){
                    Navigator.pop(context, {
                      'enter' : _cityFieldController.text,
                    });
                  },
                  child: new Text("Get Weather"),
                ),
              )
            ],
          )     
        ],
      ),      
    );
  }
}