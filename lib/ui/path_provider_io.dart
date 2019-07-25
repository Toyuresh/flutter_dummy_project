import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PathProviderIO extends StatefulWidget {
  @override
  _PathProviderIOState createState() => _PathProviderIOState();
}

class _PathProviderIOState extends State<PathProviderIO> {


  @override
  Widget build(BuildContext context) {
    var _enterDataField = new TextEditingController();
    String _savedData= "nothing..";

    // _loadSavedData() async{
    //   SharedPreferences preferences = await SharedPreferences.getInstance();

    //   setState((){
    //     if(preferences.getString('data')!=null && preferences.getString('data').isNotEmpty)
    //     {
    //     _savedData = preferences.getString("data");
    //     }
    //     else{
    //       _savedData = "Empty Sp";
    //     }
    //   });
    // }
    
    _saveMessage(String message) async{
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('data', message);   //Key : value

    }

    // @override
    // void initState()
    // {
    //   super.initState();

    //   _loadSavedData();
    // }



 

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Read/Write'),
        centerTitle: true,
        backgroundColor: Colors.greenAccent.shade100,
      ),
      body: new Container(
        padding: const EdgeInsets.all(13.4),
        alignment: Alignment.topCenter,
        child: new ListTile(
          title: new TextField(
            controller: _enterDataField,
            decoration: new InputDecoration(
              labelText: "Write Something"
            ),
          ),
          subtitle: new FlatButton(
            onPressed: (){
              _saveMessage(_enterDataField.text);
              // //save to file
              // writeData(_enterDataField.text);
            },
            child: new Column(
              children: <Widget>[
                new Text('Save Data'),
                new Padding(padding: new EdgeInsets.all(14.5),),
                new Text(_savedData),


                // new FutureBuilder(
                //   future: readData(),
                //   builder: (BuildContext context, AsyncSnapshot<String> data){
                //     if(data.hasData != null)
                //     {
                //       return new Text(
                //         data.data.toString(),
                //         style: new TextStyle(
                //           color: Colors.blueAccent.shade700,
                //         ),
                //       );
                //     }else{
                //       return new Text("NO DATA SAVED");
                //     }
                //   },
                // ),
              ],
            )
          ),
        )
      )      
    );
  }
}

  Future<String> get _localPath async{
  final directory = await getApplicationDocumentsDirectory();  //home/directory:text
  return directory.path;
  }

  Future<File> get _localFile async{
    final path = await _localPath;
    return new File('$path/data.txt');  //home/directory/data.txt
  }

  //Write and read from our file
  Future<File> writeData(String message) async{
    final file = await _localFile;

    //write to file
    return file.writeAsString('$message');
  }

  Future<String> readData() async{
    try{
      final file = await _localFile;

      //Read
      String data = await file.readAsString();

      return data;
    }catch(e)
    {
      return "Nothing Saved yet! ";
    }
  }
