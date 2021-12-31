import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  late String location; // location name for UI
  late String time; // the time in that location
  late String flag; // url to an asset flag icon
  late String url; // location url for api endpoint
  late bool isDaytime; // true or false if daytime or not

  WorldTime({ required this.location, required this.flag, required this.url });

  Future<void> getTime() async {

    try{
      // make the request
      Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);

      // get properties from json
      // print(data);
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);
      String sign = data['utc_offset'].substring(0,1);
      String offsetMin = data['utc_offset'].substring(4,6);
      // create DateTime object
      DateTime now = DateTime.parse(datetime);
      if(sign == "+"){
        now = now.add(Duration(hours: int.parse(offset)));
        now = now.add(Duration(minutes: int.parse(offsetMin)));
      }else{
        now = now.subtract(Duration(hours: int.parse(offset)));
        now = now.subtract(Duration(minutes: int.parse(offsetMin)));
      }
      

      // set the time property
      isDaytime = now.hour > 4 && now.hour < 19 ? true : false;
      time = DateFormat.jm().format(now);
      // print(time);
    }
    catch (e) {
      print(e);
      time = 'could not get time';
    }

  }

}