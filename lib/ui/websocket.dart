import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';


class WsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = "WebSocket Demo";
    return MaterialApp(
      title: title,
      home: WsHomePage(
        title: title,
        channel: IOWebSocketChannel.connect('ws://ancient-journey-20699.herokuapp.com'),
      ),
    );
  }
}


class WsHomePage extends StatefulWidget {
  final String title;
  final WebSocketChannel channel;

  WsHomePage({Key key,@required this.title, @required this.channel})
    : super(key: key);

  @override
  _WsHomePageState createState() => _WsHomePageState();
}

class _WsHomePageState extends State<WsHomePage> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Form(
              child: TextFormField(
                controller: _controller,
                decoration: InputDecoration(labelText: 'Send a message'),
              ),
            ),

            StreamBuilder(
              stream: widget.channel.stream,
              builder:(context, snapshot)
              {
                print(snapshot.data);
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Text(snapshot.hasData ? '${snapshot.data}' : ''),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send Message',
        child: Icon(Icons.send),
      ),    //This trailing comma make auto-formatting nicer for build methods.
    );
  }
  void _sendMessage()
  {
    if(_controller.text.isNotEmpty)
    {
      widget.channel.sink.add(_controller.text);
    }
  }

  @override
  void dispose()
  {
    widget.channel.sink.close();
    super.dispose();
  }
}