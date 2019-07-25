import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


class JsonParse extends StatefulWidget
{

  @override
  State<StatefulWidget> createState() {
    return JsonPraseState();
  }
}

class JsonPraseState extends State<JsonParse> 
{
  Map _data;

  void _showOnTapMessage(BuildContext context, String message)
  {
    var alert = new AlertDialog(
      title: new Text('App'),
      content: new Text(message),
      actions: <Widget>[
        new FlatButton(
          onPressed: (){
              Navigator.pop(context);
              },
          child: new Text('Ok'),
        )
      ],
    );

    showDialog(context: context, builder:(context)=>alert);
  }

  showData() async{
    _data = await getJson();
  }

  Future<Map> getJson() async
{
  String apiUrl = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson";

  http.Response response = await http.get(apiUrl);

  return json.decode(response.body);
}

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title:new Text(
          'Json Parse'),
          centerTitle: true,
          backgroundColor: Colors.amberAccent.shade100,        
      ),
      body: new Center(
        child: new ListView.builder(
          itemCount: _data.length,
          padding: const EdgeInsets.all(16.0),
          itemBuilder: (BuildContext context, int position)
          {
            final index  = position ~/2;  //we are diving position by 2
            // and returning an integer result

            if(position.isOdd) return new Divider();
            return new ListTile(
              title: new Text("${_data[position]['title']}",
              style: new TextStyle(fontSize: 13.9),),
              subtitle: new Text("${_data[position]['body']}",
                style: new TextStyle(
                  fontSize: 13.4,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic),
              ),
              leading: new CircleAvatar(
                backgroundColor: Colors.greenAccent,  
                child: new Text("${_data[index]['id']}",
                style: new TextStyle(
                  fontSize: 19.4,
                  color: Colors.deepOrangeAccent.shade100,)
                  ,),
                  ),
                  onTap: (){
                      _showOnTapMessage(context, "${_data[index]['title']}");
                    },
            );
          },
        ),
      )
    );
  }  
}
