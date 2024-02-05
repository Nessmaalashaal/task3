import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  List data = [];
  bool loding = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "show data",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
          ),
          centerTitle: true,
          backgroundColor: Colors.white54,
        ),
        body: ListView(children: [
          Container(
              height: 50,
              alignment: Alignment.topCenter,
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(15)),
              child: InkWell(
                child: Text(
                  "Click to show",
                  style: TextStyle(fontSize: 30, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                onTap: () async {
                  loding = true;
                  setState(() {});
                  var respo = await get(
                      Uri.parse("https://jsonplaceholder.typicode.com/posts"));
                  var respobody = jsonDecode(respo.body);
                  data.addAll(respobody);
                  loding = false;
                  setState(() {});
                },
              )),
          if (loding)
            Center(
              child: CircularProgressIndicator(),
            ),
          ...List.generate(
              data.length,
              (index) => Card(
                    child: ListTile(
                      title: Text("${data[index]['title']}"),
                      subtitle: Text("${data[index]['body']}"),
                    ),
                  ))
        ]));
  }
}
