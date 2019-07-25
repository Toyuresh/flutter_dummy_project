import 'dart:convert';

import 'package:flutter/material.dart';
import '../utils/utils.dart' as util;
import 'dart:async';
import 'package:http/http.dart' as http;
import '../ui/Climatic1.dart';


class Climatic extends StatefulWidget {
  @override
  _ClimaticState createState() => _ClimaticState();
}

class _ClimaticState extends State<Climatic> {
  
  String _cityEntered = util.defaultCity;

  TextStyle _cityStyle()
  {
    return new TextStyle(
      color: Colors.white,
      fontSize: 22.9,
      fontStyle: FontStyle.italic,
    );
  }

  TextStyle _tempStyle()
  {
    return new TextStyle(
      color: Colors.white,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 49.9,
    );
  }

  TextStyle _extraData()
  {
    return new TextStyle(
      color: Colors.white70,
      fontStyle: FontStyle.normal,
      fontSize: 17.0,
    );
  }

  void showStuff() async{
   Map _data = await getWeather(util.appId, util.defaultCity);
    print(_data.toString());
  }

  Future<Map> getWeather(String appId, String city) async{
    String apiUrl = "http://api.openweathermap.org/data/2.5/weather?q=$_cityEntered&appid=${util.appId}&units=metric";

    http.Response response = await http.get(apiUrl);

    return json.decode(response.body);
  }

  Future _goToNextScreen(BuildContext context) async{
    Map results = await Navigator.of(context).push(
      new MaterialPageRoute(builder:(BuildContext context){
        return new ChangeCity();
      })
    );
     if( results != null && results.containsKey('enter'))
     {
       //debugPrint(results['enter'].toString());
       _cityEntered = results['enter'];
     }
  }

  Widget updateTempWidget(String city)
  {
 
     return new FutureBuilder(
       future: getWeather(util.appId, city == null ? util.defaultCity : city),
        
       builder:(BuildContext context, AsyncSnapshot<Map> snapshot)
       {
         //where we get all of the json data, we setup widgets etc.
         if(snapshot.hasData)
         {
           Map content = snapshot.data;
           return new Container(
             child: new ListView(
               children: <Widget>[
                 new ListTile(
                   title: new Text(
                     content['main'] == null ? "" : content['main']['temp'].toString() + "°C",
                     style: new TextStyle(
                       fontSize: 49.9,
                       fontStyle: FontStyle.normal,
                       color: Colors.white,
                       fontWeight: FontWeight.w500,
                     ),
                   ),
                   subtitle: new ListTile(
                     title: new Text(
                       content['main'] == null ? "" :
                       "Humidity: ${content['main']['humidity'].toString()}\n"
                       "Min: ${content['main']['temp_min'].toString()} °C\n"
                       "Max: ${content ['main']['temp_max'].toString()} °C",
                       style: _extraData(),
                     )
                   ),
                 )
               ],
             )
           );
         }else{
            return new Container();
         }

       },
     );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          'Klimatic',
          style: _cityStyle(),
        ),
        centerTitle: true,
        backgroundColor: Colors.redAccent.shade100,
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.menu),
            onPressed: (){ _goToNextScreen(context); },
          ),
        ],
      ),
      
      body: new Stack(
        children: <Widget>[
          new Center(
            child: new Image.asset(
              'images/umbrella.png',
              width: 490.0,
              height: 1200.0,
              fit: BoxFit.fill,
            ),
          ),
          new Container(
            alignment: Alignment.topRight,
            margin: const EdgeInsets.fromLTRB(0.0, 10.9, 20.9,0.0),
            child: new Text('${_cityEntered == null ? util.defaultCity: _cityEntered}',
            style: _tempStyle(),
            ),
          ),

          new Container(
            alignment: Alignment.center,
            child: new Image.asset(
              'images/light_rain.png',
            ),
          ),

          new Container(
            margin: const EdgeInsets.fromLTRB(39.0, 310.0, 0.0, 0.0),
            alignment: Alignment.center,
            child: updateTempWidget(_cityEntered),
          ),
        ],
      )
    );
  }

}