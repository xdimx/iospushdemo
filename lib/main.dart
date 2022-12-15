
import 'package:flutter/material.dart';
import 'package:appmetrica_plugin/appmetrica_plugin.dart'; // Яндекс метрика
import 'package:appmetrica_push_plugin/appmetrica_push_plugin.dart';



void main() async {

  initPushAndMetrica();
  runApp(const MyApp());

}

void initPushAndMetrica()  {
  AppMetrica.activate(
      const AppMetricaConfig("a9ecc76c-4f5b-4dc5-b289-e23dffbd7414")
  );
  AppMetrica.reportEvent('AppMetrica 4 ios event!');
  AppMetricaPush.activate();
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);



  // Главный виджет
  @override
  Widget build(BuildContext context) {




    return const MaterialApp(
      title: 'Кинотеатры',

      home:
      Scaffold(
        body:
        Center(
          child:
          Text("Hello world! Ios test 4."),


        ),
      ),


    );
  }



}

