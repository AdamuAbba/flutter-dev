import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  String theCityName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 50, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        child: Stack(
          children: [
            Image.asset(
              'images/night.jpg',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            Column(
              children: <Widget>[
                SizedBox(
                  height: 100,
                ),
                Form(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(
                          Icons.location_city,
                          color: Colors.white,
                        ),
                        title: TextFormField(
                          onChanged: (value) {
                            theCityName = value;
                          },
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Enter city Name'),
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pop<String>(context, theCityName.trim());
                          },
                          child: Text(
                            'Get Weather',
                            style: GoogleFonts.lato(
                                color: Colors.white, fontSize: 30),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
