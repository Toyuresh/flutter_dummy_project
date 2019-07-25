import 'package:flutter/material.dart';

class Bmi extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    return BmiState();
  }
}

class BmiState extends State<Bmi>
{

  final TextEditingController _ageController = new TextEditingController();
  final TextEditingController _heightController = new TextEditingController();
  final TextEditingController _weightController = new TextEditingController();
  String _result ;
  String _resultReading = "" ;

  void handleBmiLogic()
  {
    setState(() {
      _result = _calculateBmiIndex(_ageController.text,_heightController.text,_weightController.text);
    });
  }


  String _calculateBmiIndex(String age, String height, String weight)
  {
    if(age.isEmpty || height.isEmpty  || weight.isEmpty)
    {
      _resultReading = ""; 
      return "";
    }
    double _height = double.parse(height) * 0.3048;
    double _bmi = double.parse(weight)/(_height *_height);
    if(_bmi < 18.5)
    {
      _resultReading = "Underweight!";
    }
    else if(_bmi >= 18.5 && _bmi < 25)
    {
      _resultReading = "Great Shape!";
    }
    else if(_bmi >= 25 && _bmi < 30)
    {
      _resultReading = "Overweight!";
    }
    else if(_bmi >= 30)
    {
      _resultReading = "Obsesity!";
    }
    return _bmi.toString();
  }
  


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "BMI",
          style: new TextStyle(
              color: Colors.black,
              fontSize:19.4,
              fontWeight: FontWeight.w500,
          ),),
          centerTitle: true,
          backgroundColor: Colors.redAccent.shade100, 
      ),

      body: new Container(
        alignment: Alignment.topCenter,
          child:ListView(
          padding: const EdgeInsets.all(2.5),
          children: <Widget>[
            new Image.asset(
            'images/bmilogo.png',
                height: 133.0,
                width: 200.0,
            ),
              
            new Container(
              margin: const EdgeInsets.all(3.0),
              alignment: Alignment.center,
              color: Colors.blueGrey.shade100,
              child: new Column(
                children: <Widget>[
                  new TextField(
                    controller: _ageController,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                      labelText: 'Age',
                      hintText: 'Please Enter Your Age',
                      icon: new Icon(Icons.person_outline),
                    ),
                  ),

                  new TextField(
                    controller: _heightController,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                      labelText: 'Height in feet',
                      hintText: 'Please Enter Your Height',
                      icon: new Icon(Icons.insert_chart)
                    ),
                  ),

                  new TextField(
                    controller: _weightController,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                      labelText: 'Weight in lb',
                      hintText: 'Please Enter Your Weight',
                      icon: new Icon(Icons.storage),
                    ),
                  ),
                
                    new Container(
                          margin: const EdgeInsets.only(left:38.0),
                          child: new RaisedButton(
                            onPressed: handleBmiLogic,
                            color: Colors.redAccent,
                            child: new Text("Calculate",
                            style: new TextStyle(color: Colors.white,
                            fontSize:16.9)),
                          ),
                        ),

                ],
              ),    
            ),
            new Container(
              margin: const EdgeInsets.all(4.5),
              alignment: Alignment.bottomCenter,
              child:new Column(
              children: <Widget>[
                  new Padding(padding: new EdgeInsets.all(1.6)),
                  //Result Text
                  new Text(
                    "$_result".isEmpty ? "" : "Your BMI: " + "$_result",
                    style: new TextStyle(
                      color: Colors.lightBlueAccent.shade700,
                      fontSize:19.4,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  new Text(
                    "$_resultReading".isEmpty ?  "" : "$_resultReading",
                    style: new TextStyle(
                      color: Colors.pinkAccent.shade700,
                      fontSize:19.4,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),  
            

          ],
        ),
      )
    );
  }
  
}