import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(Page1());
}

class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  List<dynamic> planetList = [];

  @override
  void initState() {
    super.initState();
    fetchPlanets();
  }

  void fetchPlanets() async {
    final response = await http.get(Uri.parse('http://localhost:3003/planets'));

    if (response.statusCode == 200) {
      setState(() {
        planetList = json.decode(response.body);
      });
    } else {
      print('Failed to load planets');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow,
          title: Text(
            "النظام الشمسي",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: planetList.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: planetList.length,
                itemBuilder: (context, index) {
                  final planet = planetList[index];
                  return Card(
                    margin: EdgeInsets.all(8.0),
                    elevation: 5.0,
                    child: ListTile(
                      title: Text(planet['name'],
                          style: TextStyle(fontSize: 20.0)),
                      subtitle: Text(
                        "إمالة: ${planet['tilt']}°, يوم: ${planet['day']} ساعة, سنة: ${planet['year']} يوم",
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
