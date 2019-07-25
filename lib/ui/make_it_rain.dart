import 'package:flutter/material.dart';

class MakeItRain extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {

    return new MakeItRainState();
  }
  
}

class MakeItRainState extends State<MakeItRain>
{
  int _moneyCounter = 0;

  var _color1 = Colors.blue;




  void _rainMoney()
  {
    //Important - setState is called each time we need to update the UI
    setState((){
      _moneyCounter = _moneyCounter + 100;

        if(_moneyCounter > 500)
          {
            _color1 = Colors.red;
          }
    });

   
  }
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Make It Rain!"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: new Container(
        child: new Column(
          children: <Widget>[
            //title
            new Center(
            child:new Text("Get Rich!",
            style: new TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w400,
              fontSize: 29.9
            ),),
            ),
            
            new Expanded(child: new Center(
              child: new Text("\$$_moneyCounter",
              style: new TextStyle(
                color: _color1,
                fontSize: 46.9,
                fontWeight: FontWeight.w800
              ),),
            )),

            new Expanded(
              child: new Center(
                child: new FlatButton(
                  color: Colors.lightBlue,
                  textColor: Colors.white70,
                  onPressed:_rainMoney,
                  child: new Text("Let It Rain!",
                  style: new TextStyle(
                    fontSize: 20.0 
                  )
                  )
                )
              )
            ) 
          ]
        )
      )
    );
  }

}