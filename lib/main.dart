import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Joke(),
    ),
  );
}

class Joke extends StatefulWidget {
  const Joke({Key? key}) : super(key: key);

  @override
  State<Joke> createState() => _JokeState();
}

class _JokeState extends State<Joke> {
  var crated;
  var update;
  var values;

  Future getJoke() async {
    http.Response response =
        await http.get(Uri.parse("https://api.chucknorris.io/jokes/random"));
    var results = jsonDecode(response.body);
    setState(() {
      crated = results["created_at"];
      update = results["updated_at"];
      values = results["value"];
    });
  }

  @override
  void initState() {
    super.initState();
    getJoke();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text("Let's Laugh"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              height: 70,
              width: 300,
              color: Colors.green,
              child: Text(
                "Created: ${crated != null ? crated.toString() : "Loading"}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              height: 150,
              width: 300,
              color: Colors.teal,
              child: Text(
                "Joke: ${values != null ? values.toString() : "Loading"}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              height: 70,
              width: 300,
              color: Colors.blue,
              child: Text(
                "Updated: ${update != null ? update.toString() : "Loading"}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 60,
            ),
            ElevatedButton(
              onPressed: () {
                getJoke();
              },
              child: Text("Fetch My Laugh"),
            ),
          ],
        ),
      ),
    );
  }
}
