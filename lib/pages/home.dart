import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

//  @override
//  void initState() {
//    super.initState();
//  }

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context)?.settings?.arguments as Map;

    // set background image0
    String bgImage = data['isDaytime'] ? 'day2.jpg' : 'night2.jpg';
    Color bgColor = data['isDaytime'] ? Colors.blue : Colors.indigo;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/$bgImage'),
                fit: BoxFit.cover,
              )
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 160.0, 0, 0),
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  radius: 43.0,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 40.0,
                    backgroundImage: AssetImage('assets/' + data['flag']),
                  ),
                ),
                  SizedBox(height: 35.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      data['location'],
                      style: TextStyle(
                        fontSize: 48.0,
                        letterSpacing: 2.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,

                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Text(
                    data['time'],
                    style: TextStyle(
                        fontSize: 72.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                    )
                ),
                SizedBox(height: 20.0,),
                FlatButton.icon(
                  onPressed: () async {
                    dynamic result = await Navigator.pushNamed(context, '/location');
                    if(result != null){
                      setState(() {
                        data = {
                          'time': result['time'],
                          'location': result['location'],
                          'isDaytime': result['isDaytime'],
                          'flag': result['flag']
                        };
                      });
                    }
                  },
                  icon: Icon(
                    Icons.edit_location,
                    color: Colors.grey[50],
                    size: 30.0,
                  ),
                  label: Text(
                    'Edit Location',
                    style: TextStyle(
                    color: Colors.grey[50],
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}