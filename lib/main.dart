import 'package:chargerrr_app/presentation/auth/login_page.dart';
import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';


const String ACCESS_TOKEN = String.fromEnvironment("ACCESS_TOKEN");


void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  MapboxOptions.setAccessToken(ACCESS_TOKEN);

  if(ACCESS_TOKEN.isEmpty){
      print("Error in maps Mapbox Access Token is missing! Use --dart-define.");
  }


  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xff00C950),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: LoginPage(),
    );
  }
}
