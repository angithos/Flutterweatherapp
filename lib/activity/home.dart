import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/worker/worker.dart';
import 'package:flutter_gradient_app_bar/flutter_gradient_app_bar.dart';
import 'package:weather_icons/weather_icons.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController search_controller= new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("init callec");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("disposed");
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    print("state changed");
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    print("deactivated");
  }

  @override
  Widget build(BuildContext context) {
    var city_Name = ["mumbai", 'chennai', 'ahmedabad', 'indore', 'bangalore'];
    final _random = new Random();
    String city = city_Name[_random.nextInt(city_Name.length)];
    Map info = ModalRoute.of(context)!.settings.arguments as Map;
    String City=info["cityname"];
    String Temp=(info["temp_value"]);
    String air=(info["air_value"]);
    if(Temp=="NA"){
      print("NA");
    }
    else {
      Temp=((info["temp_value"]).toString()).substring(0,4);
      air=((info["air_value"]).toString()).substring(0,3);
    }
    String weather_icon_id=info["icon_value"];
    String humidity=info["hum_value"];
    return Scaffold(
      resizeToAvoidBottomInset:false,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: GradientAppBar(
            gradient: LinearGradient(
                colors: [Colors.pinkAccent.shade400, Colors.blue.shade800],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
          )),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blue.shade800, Colors.blue.shade300],
            ),
          ),
          child: Column(children: [
            //search bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6.0),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(30)),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if((search_controller.text).replaceAll(" ", "")=="")
                      {
                        print("Blank search");
                      }else {
                     Navigator.pushReplacementNamed(context, "/loading",arguments: 
                      "searchText":search_controller.text);
                      }  
                    },
                    child: const Icon(Icons.search, color: Colors.lightBlueAccent),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: search_controller,
                      style: const TextStyle(color: Colors.black54),
                      decoration: InputDecoration(
                          hintStyle: const TextStyle(
                              color: Colors.black38, fontWeight: FontWeight.w500),
                          border: InputBorder.none,
                          hintText: "Search $city",
                          fillColor: Colors.white),
                    ),
                  )
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  //box1
      
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(14)),
                    padding:  EdgeInsets.all(20),
                    margin:  EdgeInsets.symmetric(horizontal: 10),
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 20),
                        Image.network("https://openweathermap.org/img/wn/$weather_icon_id@2x.png"),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              info["main"],
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "in $City",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
      
                  //box 2
      
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white.withOpacity(0.5)),
                    margin:  EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    padding:  EdgeInsets.all(26),
                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(WeatherIcons.thermometer),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(Temp,style: TextStyle(
                              fontSize: 80,
                              fontWeight: FontWeight.w600
                            ),),
                            Text("C",style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.w400
                            ),)
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            //box 3 & 4
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Expanded(
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white.withOpacity(0.5)), 
                    
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    padding:  const EdgeInsets.all(25),
                        
                    child: Column(
                     
                      children: [
                         Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [ 
                        Icon(WeatherIcons.day_windy),
                         SizedBox(width: 20),
                        Text("SPEED")
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(air,style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold
                    ),),
                    Text("km/hr")
                      ],
                    )),
              ),
      
      
              Expanded(
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white.withOpacity(0.5)), 
                    
                    margin:  EdgeInsets.symmetric(horizontal: 10),
                    padding:   EdgeInsets.all(25),
                        
                    child:  Column(
                     
                      children: [
                         Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [ 
                        Icon(WeatherIcons.humidity),
                        SizedBox(width: 10),
                        Text("HUMIDITY")
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(humidity,style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold
                    ),
                    ),
                    Text("percent")
                      ],
                    )),
              )
            ]
            ),
      SizedBox(height: 25),
            Container(
              padding: const EdgeInsets.all(10),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("MADE BY ANGITH"),
                  Text("Powered by OpenWeather")
                ],
              ),
            )
          ]),
        )),
      ),
    );
  }
}
