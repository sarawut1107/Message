import 'dart:convert';

import 'package:FileProcess/fileprocess.dart';
import 'package:FileProcess/welcome.dart';
import 'package:flutter/material.dart';

class DeleteMessage extends StatefulWidget {
  DeleteMessage({Key key, this.id}) : super(key: key);

  final String id;

  @override
  _DeleteMessageState createState() => _DeleteMessageState();
}

class _DeleteMessageState extends State<DeleteMessage> {
  String messageStr = '';

  Future<void> _addMessage() async {
    DataFileProcess dataFile = DataFileProcess();
    List<Map> dataList = [];

    //Exist data
    String dataStr = await dataFile.readData();
    var dataJson = jsonDecode(dataStr);
    for (var item in dataJson) {
      Map<String, dynamic> dataMap = {
        'id': item['id'],
        'msg': item['msg'],
      };
      dataList.add(dataMap);
    }

    //New data
    Map<String, dynamic> dataMap = {
      'id': '0',
      'msg': messageStr,
    };

    dataList.add(dataMap);

    var dataJson_new = jsonEncode(dataList);
    dataFile.writeData(dataJson_new.toString());

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MyHomePage(title: 'File Process')));
  }

  @override
  Widget build(BuildContext context) {
    TextField _message = TextField(
      decoration: InputDecoration(hintText: 'Enter message'),
      onChanged: (value) {
        messageStr = value;
      },
    );

    RaisedButton _addButton = RaisedButton(
      onPressed: () {
        _addMessage();
      },
      child: Text("Add Message"),
      color: Colors.pink,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Delete Message"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            _message,
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[_addButton],
            ),
          ],
        ),
      ),
    );
  }
}
