import 'package:flutter/material.dart';
import 'util/utils.dart' as util;
import 'package:weatherapp/locationPage.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:emojis/emojis.dart';
import 'package:emojis/emoji.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int temp;
  var currently;
  var localName;
  var localHumidity;
  String finalCityName;
  Future getWeather() async {
    http.Response response = await http.get(
        'http://api.openweathermap.org/data/2.5/weather?q=${util.defaultCity}&appid=${util.appId}&units=metric');
    var result = jsonDecode(response.body);
    setState(() {
      this.localHumidity = result['main']['humidity'];
      this.temp = result['main']['temp'];
      this.localName = result['sys'][1]['name'];
      this.currently = result['weather'][0]['description'];
    });
  }

  void updateUi() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            padding: EdgeInsets.only(left: 20, top: 10),
            icon: Icon(
              Icons.near_me,
              size: 50,
              color: Colors.white,
            ),
            onPressed: () {
              updateUi();
            }),
        actions: <Widget>[
          IconButton(
              padding: EdgeInsets.only(right: 45, top: 10),
              icon: Icon(
                Icons.location_city,
                size: 50,
                color: Colors.white,
              ),
              onPressed: () async {
                finalCityName = await Navigator.push(
                    context,
                    MaterialPageRoute<String>(
                        builder: (BuildContext context) => LocationPage()));
              }),
        ],
      ),
      body: Container(
        child: Stack(children: <Widget>[
          Image.asset(
            'images/sunny.jpg',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Container(
            color: Colors.black12,
          ),
          Container(
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.centerLeft,
            child: Row(
              children: <Widget>[
                temp == null
                    ? CircularProgressIndicator()
                    : Text(temp.toString() + '\u00B0' + weatherIcon(),
                        style: GoogleFonts.lato(
                          textStyle: tempStyle(),
                        )),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    temp == null ? 'Loading...' : weatherMessage(),
                    style: GoogleFonts.lato(
                      textStyle: tempStyle(),
                    ),
                    textAlign: TextAlign.end,
                  )),
            ),
          ),
        ]),
      ),
    );
  }

  // String _finalCityName() {
  //   if (finalCityName == null) {
  //     return '"loading city name"';
  //   } else {
  //     return finalCityName;
  //   }
  // }

  String weatherMessage() {
    if (currently.toString() == "Clouds") {
      return 'bring a jacket just in case in Cupertino';
    } else if (temp <= 0) {
      return 'you,ll need a ${Emojis.scarf} and ${Emojis.gloves} in ${util.defaultCity}';
    } else
      return 'It\'s a beautiful day ';
  }

  String weatherIcon() {
    if (temp <= 0) {
      return Emojis.snowflake;
    } else if (temp > 20) {
      return Emojis.sun;
    }
    return null;
  }
}

TextStyle tempStyle() {
  return TextStyle(color: Colors.white, fontSize: 40);
}
