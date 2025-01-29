import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'home.dart';
import 'login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Ensure this file is generated in your project


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase using the configuration
  await Firebase.initializeApp(
    options: FirebaseOptions( apiKey: 'AIzaSyAzyKHyB5I9ivKH0lNQAAljcCCySj__LfE',
      appId: '1:547810480733:android:083ff1a1254dc9dfdd73b4',
      messagingSenderId: '547810480733',
      projectId: 'keys-edeaa',
      storageBucket: 'keys-edeaa.firebasestorage.app',),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: login_page(),
    );
  }
}

