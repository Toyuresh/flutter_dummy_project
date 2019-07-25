import 'package:flutter/material.dart';
import '../ui/routing2.dart';

class Routing extends StatefulWidget {
  @override
  _RoutingState createState() => _RoutingState();
}

class _RoutingState extends State<Routing> {

  var _nameFieldController = new TextEditingController();

  Future _goToNextScreen(BuildContext context) async{
    Map results = await Navigator.of(context).push(
      new MaterialPageRoute (
        builder: (BuildContext context){
          return new NextScreen(name: _nameFieldController.text);
        }
      )
    );
    if(results !=null &&results.containsKey("info"))
    {
      //print(results['info'].toString());
      _nameFieldController.text = results['info'].toString();
    }
    else
    {
      print('Nothing!');
    }
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          'FirstScreen',
        ),
        centerTitle:  true,
        backgroundColor: Colors.greenAccent,
      ),

      body: new ListView(
        children: <Widget>[
          new ListTile(
            title: new TextField(
            controller: _nameFieldController,
            decoration: new InputDecoration(
              labelText: 'Enter your name',
            ),
          ),),

          new ListTile(
            title: new RaisedButton(
              child: new Text("Send to Next Screen"),
                onPressed: (){
                  _goToNextScreen(context);
                },
            ),
          ),          
        ],
          
      )
      
    );
  }
}