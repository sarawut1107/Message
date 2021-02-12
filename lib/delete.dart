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
  DataFileProcess dataFile = DataFileProcess();
  List<Map> dataList = [];
  String selectedID;
  TextEditingController _controller;

  Future<void> _deleteMessage() async {
<<<<<<< HEAD
    dataList.removeWhere((element) => element['id'] == selectedID.toString());

    // ทำต่อเอง ให้ดูจากตัวอย่างทีให้ไว้

    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => MyHomePage(title: 'File Process')));
  }

  Future<String> _getFile(String id) async {
    String dataStr = await dataFile.readData();
    if (dataStr != 'fail' && dataStr != '{}' && dataList.length == 0) {
      var dataJSon;
      if (dataList.length == 0) {
        dataJSon = jsonDecode(dataStr);
        for (var item in dataJSon) {
          Map<String, dynamic> dataMap = {
            'id': item['id'],
            'msg': item['msg'],
          };
          dataList.add(dataMap);
=======
    DataFileProcess dataFile = DataFileProcess();
    List<Map> dataList = [];
    dataList.remove((Element) => Element['id'] == SelectedID.toString());

    String dataStr = await dataFile.readData();
    var jsondata = jsonEncode(dataList);
    if (jsondata.length !=0) {
      dataFile.writeData(jsondata.toString());
    } else{
      dataFile.writeData('{}');
    }

  
>>>>>>> e806751edab9a72fbe79ea9bb72990c02124d90d

          if (item['id'] == id) {
            setState(() {
              _controller = TextEditingController(text: item['msg']);
            });
          }
        }
      }
    }

    return 'success';
  }

  @override
  Widget build(BuildContext context) {
    selectedID = widget.id;

    TextField _message = TextField(
      decoration: InputDecoration(hintText: 'Enter message'),
      controller: _controller,
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
      body: FutureBuilder(
        future: _getFile(selectedID),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
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
            );
          } else {
            return Center(
              child: Column(
                children: <Widget>[
                  CircularProgressIndicator(),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}