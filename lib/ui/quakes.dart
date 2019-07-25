import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Quake extends StatefulWidget{
  final Map _data;

  Quake(this._data);

  @override
  State<StatefulWidget> createState() {
    return QuakeState(_data);
  }

}

class QuakeState extends State<Quake>
{
  Map _data;
 List _features;

  void _showOnTapMessage(BuildContext context, String message)
  {
    var alert = new AlertDialog(
      title: new Text('Quakes'),
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

    showDialog(context: context, builder: (context) => alert);
  }

  QuakeState(this._data){
    _features = _data['features'];
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Quake", 
          style: new TextStyle(
            color: Colors.cyan.shade100,
            fontSize: 18.20,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black54,
      ),

      body: new Center(
       child: new ListView.builder(
         itemCount: _features.length,
         padding: const EdgeInsets.all(13.0),
         itemBuilder: (BuildContext context,int position){

             if(position.isOdd) return new Divider(
               color: Colors.white,
             );

             final index = position ~/ 2;

              var format = new DateFormat.yMMMd("en_US").add_jm();

             var _date = format.format(new DateTime.fromMicrosecondsSinceEpoch(_features[index]['properties']['time']*1000, isUtc: true));

           return new ListTile(
             title: new Text("At: $_date",
              style: new TextStyle(
                fontSize: 13.9,
                   color: Colors.white,
                   ),    
                ),
              subtitle: new Text("${_features[index]['properties']['place']}",
                style: new TextStyle(
                  fontSize: 13.4,
                  color: Colors.white,
                  fontStyle: FontStyle.italic),
                  ),
                  leading: new CircleAvatar(
                backgroundColor: Colors.greenAccent,  
                child: new Text("${_features[index]['properties']['mag']}",
                style: new TextStyle(
                  fontSize: 19.4,
                  color: Colors.black87)
                  ,),
                  ),
                  onTap: (){
                      _showOnTapMessage(context, "${_features[index]['properties']['title']}");
                    },
            ); 
         },
       ), 
      ),
      backgroundColor: Colors.blueGrey.shade700,
    );
  }
  
}