import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerece/firebase_options.dart';
import 'package:ecommerece/new_architecture/controller/auth_controller.dart';
import 'package:ecommerece/new_architecture/datasource/auth_data.dart';
import 'package:ecommerece/new_architecture/repo/auth_logic.dart';
import 'package:ecommerece/services/Cache_Helper.dart';
import 'package:ecommerece/views/home.dart';
import 'package:ecommerece/views/onBoarding.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'models/user_model.dart';
import 'package:ecommerece/new_architecture/controller/firestore_controller.dart';
import 'package:ecommerece/new_architecture/repo/firestore_logic.dart';
import 'package:ecommerece/new_architecture/datasource/firestore_data.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheData.cacheInitialization();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
        create: (context) => FireStoreController(
            firestorehandlerImplement: FirestorehandlerImplement(
                firestoreImplement: FirestoreImplement(
                    firebaseFirestore: FirebaseFirestore.instance)))),
    ChangeNotifierProvider(
        create: (context) => AuthController(
            cache: CacheData(),
            repo: AuthHandlerImplement(
                authImplement:
                    AuthImplement(firebaseauth: FirebaseAuth.instance),
                cacheData: CacheData())))
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //MyUser? user=Provider.of<AuthController>(context).getCurrentUser();
    //print(user);
    Either<String, MyUser> user =
        Provider.of<AuthController>(context).getCurrentUser();

    return MaterialApp(
        home: user.isRight ? HomePage(user: user.right) : Intro());
  }
}
