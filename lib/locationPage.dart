import 'package:flutter/material.dart';
import 'package:http/http.dart';

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final TextEditingController cityNameController = new TextEditingController();
  Future getCity() async {
    return cityNameController.text;
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
              image: AssetImage("assets/images/night.jpg"), fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Form(
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(
                    Icons.location_city,
                    color: Colors.white,
                  ),
                  title: TextFormField(
                    controller: cityNameController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Enter city Name'),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/');
                      setState(() {
                        cityNameController.text;
                      });
                    },
                    child: Text(
                      'Get Weather',
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
