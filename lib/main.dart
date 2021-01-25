import 'package:flutter/material.dart';
import 'util/utils.dart' as util;
import 'package:weather_app/locationPage.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/location': (context) => LocationPage(),
      },
      debugShowCheckedModeBanner: true,
      title: 'simple weather app',
      themeMode: ThemeMode.system,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var temp;
  var currently;

  Future getWeather() async {
    http.Response response = await http.get(
        'http://api.openweathermap.org/data/2.5/weather?q=${util.defaultCity} &appid=${util.appId}&units=metric');
    var result = jsonDecode(response.body);
    setState(() {
      this.temp = result['main']['temp'];
      this.currently = result['weather']['0']['main'];
    });
  }

  @override
  void initState() {
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/sunny.jpg"), fit: BoxFit.cover),
        ),
        child: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 45, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.location_city,
                      size: 50,
                    ),
                    onPressed: () {}),
                IconButton(
                    icon: Icon(
                      Icons.location_city,
                      size: 50,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/location');
                    })
              ],
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                  temp != null ? temp.toString() + '\u00B0' : 'Loading...',
                  style: tempStyle()),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: Text('test', style: tempStyle()),
            ),
          ),
        ]),
      ),
    );
  }
}

TextStyle tempStyle() {
  return TextStyle(color: Colors.white, fontSize: 40);
}
