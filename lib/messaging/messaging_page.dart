import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:two/Main_Page/Main_view.dart';
//import 'package:main_page/main.dart';

final ThemeData androidTheme = new ThemeData(
  primarySwatch: Colors.blue,
  accentColor: Colors.green,
);

const String defaultUserName = "الاسم و الشهرة ";

void main() => runApp(new Messaging());

class Messaging extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) {
    return new MaterialApp(
      title: "Chat Application",
      theme: androidTheme,
      home: new Chat(),
    );
  }
}

class Chat extends StatefulWidget {
  @override
  State createState() => new ChatWindow();
}

class ChatWindow extends State<Chat> with TickerProviderStateMixin {
  final List<Msg> _messages = <Msg>[];
  final TextEditingController _textController = new TextEditingController();
  bool _isWriting = false;

  @override
  Widget build(BuildContext ctx) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("المياوم"),
        centerTitle: true,
        elevation: 6.0,
        actions: <Widget>[
          new IconButton(
            //alignment: Alignment.centerRight,
            icon: Icon(Icons.arrow_forward),
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MainView();
              }));
            },
          ),
        ],
//        Theme.of(ctx).platform == TargetPlatform.iOS ? 0.0 : 6.0,
      ),
      body: new Column(children: <Widget>[
        new Flexible(
            child: new ListView.builder(
          itemBuilder: (_, int index) => _messages[index],
          itemCount: _messages.length,
          reverse: true,
          padding: new EdgeInsets.all(6.0),
        )),
        new Divider(height: 1.0),
        new Container(
          child: _buildComposer(),
          decoration: new BoxDecoration(color: Theme.of(ctx).cardColor),
        ),
      ]),
    );
  }

  Widget _buildComposer() {
    return new IconTheme(
      data: new IconThemeData(color: Theme.of(context).accentColor),
      child: new Container(
          margin: const EdgeInsets.symmetric(horizontal: 9.0),
          child: new Row(
            children: <Widget>[
              new Container(
                  margin: new EdgeInsets.symmetric(horizontal: 3.0),
                  child: //Theme.of(context).platform == TargetPlatform.iOS
//                      ? new CupertinoButton(
//                      child: new Text("Submit"),
//                      onPressed: _isWriting ? () => _submitMsg(_textController.text)
//                          : null
//                  ):
                      new IconButton(
                    icon: new Icon(Icons.arrow_back),
                    onPressed: _isWriting
                        ? () => _submitMsg(_textController.text)
                        : null,
                  )),
              new Flexible(
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  child: new TextField(
                    textAlign: TextAlign.right,
                    controller: _textController,
                    onChanged: (String txt) {
                      setState(() {
                        _isWriting = txt.length > 0;
                      });
                    },
                    onSubmitted: _submitMsg,
                    decoration: new InputDecoration.collapsed(
                        hintText: "أكتب شيئا لتصل رسالتك"),
                  ),
                ),
              )
            ],
          ),
          decoration: //Theme.of(context).platform == TargetPlatform.iOS
              //? new BoxDecoration(
              //border:
              //new Border(top: new BorderSide(color: Colors.brown))) :
              null),
    );
  }

  void _submitMsg(String txt) {
    _textController.clear();
    setState(() {
      _isWriting = false;
    });
    Msg msg = new Msg(
      txt: txt,
      animationController: new AnimationController(
          vsync: this, duration: new Duration(milliseconds: 800)),
    );
    setState(() {
      _messages.insert(0, msg);
    });
    msg.animationController.forward();
  }

  @override
  void dispose() {
    for (Msg msg in _messages) {
      msg.animationController.dispose();
    }
    super.dispose();
  }
}

class Msg extends StatelessWidget {
  Msg({this.txt, this.animationController});
  final String txt;
  final AnimationController animationController;

  @override
  Widget build(BuildContext ctx) {
    return new SizeTransition(
      sizeFactor: new CurvedAnimation(
          parent: animationController, curve: Curves.easeOut),
      axisAlignment: 0.0,
      child: new Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          textDirection: TextDirection.rtl,
          textBaseline: TextBaseline.alphabetic,
          children: <Widget>[
            new Container(
              margin: const EdgeInsets.only(right: 18.0),
              child: new CircleAvatar(child: new Text(defaultUserName[0])),
            ),
            new Expanded(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  new Text(defaultUserName,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: new DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                        margin: EdgeInsets.fromLTRB(4, 2, 4, 2),
                        child: Text(
                          txt,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
