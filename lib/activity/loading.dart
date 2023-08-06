import 'package:flutter/material.dart';
import 'package:weather_app/worker/worker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading_screen extends StatefulWidget {
  const Loading_screen({super.key});

  @override
  State<Loading_screen> createState() => _Loading_screenState();
}

class _Loading_screenState extends State<Loading_screen> {
  @override
  late String Location="bangalore";
  late String temp;
  late String hum;
  late String air_speed;
  late String desc;
  late String main;
  late String w_icon;
  late String city_name;
  
  void startApp(String Location) async {
    
    worker instance = worker(ilocation: Location);
    await instance.getData();
    temp = instance.temp;
    air_speed = instance.air_speed;
    hum = instance.humidity;
    desc = instance.description;
    main = instance.main;
    city_name = instance.city_name;
    w_icon=instance.w_icon;


    Future.delayed(Duration(seconds: 2),(){
  Navigator.pushReplacementNamed(context, '/home', arguments: {
      "temp_value": temp,
      "air_value": air_speed,
      "hum_value": hum,
      "desc": desc,
      "main": main,
      "cityname": city_name,
      "icon_value":w_icon
    });
    });
    // ignore: use_build_context_synchronously
    
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    print("init callec");
    
  }

  Widget build(BuildContext context) {
   
  Map? search_data=ModalRoute.of(context)?.settings.arguments as Map?;

  if(search_data?.isNotEmpty ?? false){
    Location=search_data!["searchText"];
  }
  startApp(Location);
  
    return Scaffold(
        body: SafeArea(
            child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:<Widget> [
        Image.asset("images/weather_icon.png",height: 160,width: 160),
        SizedBox(height: 20),
        const Text("The Weather App",
        style: TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.w500
          
        ),
        ),
        SizedBox(height: 10),
        const Text("Made by angith",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w400
        )
        ),
        SizedBox(height: 20),
        const SpinKitWave(
          color: Colors.white,
          size: 50.0,
        )
      ]),
    )
    ),backgroundColor: Colors.blue[300],
    );
  }
}
