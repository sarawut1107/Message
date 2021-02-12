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

  Future<void> _deleteMessage() async {
    DataFileProcess dataFile = DataFileProcess();
    List<Map> dataList = [];
    dataList.remove((Element) => Element['id'] == selectedID.toString());
    
    String dataStr = await dataFile.readData();
    var jsondata = jsonEncode(dataList);
    if (jsondata.length !=0) {
      dataFile.writeData(jsondata.toString());
    } else{
      dataFile.writeData('{}');
    }

  

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
        _deleteMessage();
      },
      child: Text("Delete Message"),
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