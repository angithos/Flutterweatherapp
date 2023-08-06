import 'dart:convert';

import 'package:http/http.dart';

class worker
{
late String Location;
//constructor

worker ({ilocation}){
  Location=ilocation;
}

 
 late String temp;
 late String humidity;
 late String air_speed;
 late String description;
 late String main;
 late String city_name;
 late String w_icon;
Future getData() async
 {
  try{
const appid='0d0089149a063b4f8582395d7add8ef2';
Response response=await get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$Location&appid=$appid&units=metric"));
Map data=jsonDecode(response.body);

//temperature & humidity
Map main_temp=data['main'];
double Temp=main_temp['temp'];
int Humidity=main_temp['humidity'];

//weather main and desc and icon
List weather=data['weather'];
Map weather_data=weather[0];
String Main=weather_data['main'];
String Description=weather_data['description'];
String W_icon=weather_data["icon"];

//airspeed & name
Map wind=data['wind'];
double Air_speed=wind['speed'];
String Name=data['name'];

//assigning
temp=Temp.toString();
humidity=Humidity.toString();
air_speed=Air_speed.toString();
description=Description;
main=Main;
city_name=Name;
w_icon=W_icon;
}
 
catch(e){
print(e);
temp="NA";
humidity="NA";
air_speed="NA";
description="cant fetch data";
main="NA";
city_name=Location;
w_icon="09d";
}
 }



}