import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class HomePage extends StatefulWidget {
  final String title;
  HomePage({Key key, @required this.title}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List usersData;
  bool isLoading = true;

  Future<String> getUserData() async {
    var response = await http.get(Uri.https('randomuser.me', 'api'));
    List data = jsonDecode(response.body)['results'];
    print(data);
    setState(() {
      this.usersData = data;
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
            child: isLoading
                ? CircularProgressIndicator()
                : ListView.builder(
                    itemCount: usersData == null ? 0 : usersData.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                          child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(20.0),
                            child: Image(
                              image: NetworkImage(
                                  usersData[index]['picture']['thumbnail']),
                              width: 70.0,
                              height: 70.0,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                  usersData[index]['name']['first'] +
                                      ' ' +
                                      usersData[index]['name']['last'],
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text("Phone: ${usersData[index]['phone']}"),
                                Text("Gender: ${usersData[index]['gender']}"),
                              ],
                            ),
                          )
                        ],
                      ));
                    })),
      ),
    );
  }
}
