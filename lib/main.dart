import 'package:ecommerece/firebase_options.dart';
import 'package:ecommerece/new_architecture/controller/auth_controller.dart';
import 'package:ecommerece/new_architecture/datasource/auth_data.dart';
import 'package:ecommerece/new_architecture/repo/auth_logic.dart';
import 'package:ecommerece/services/Cache_Helper.dart';
import 'package:ecommerece/views/onBoarding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheData.cacheInitialization();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthController(
          cache: CacheData(),
          repo: AuthHandlerImplement(
              authImplement: AuthImplement(firebaseauth: FirebaseAuth.instance),
              cacheData: CacheData())),
      child: MaterialApp(
        home: Intro(),
      ),
    );
  }
}
