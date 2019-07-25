import 'package:flutter/material.dart';
//import './ui/home.dart';
//import './ui/home1.dart';
//import './ui/make_it_rain.dart';
//import './ui/Login.dart';
//import './ui/weight_on_planet.dart';
//import "./ui/bmi.dart";
//import "./ui/json_object.dart";
//import './ui/quakes.dart';
//import './ui/Climatic.dart';
//import './ui/routing.dart';
//import './ui/path_provider_io.dart';
import './ui/websocket.dart';


void main() async
{
  var title = "ReadWrite";



  runApp(new MaterialApp(
    title: title,
    home: new WsApp(),
  ));
}

