import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerece/Stripe_Payment/stripe_keys.dart';
import 'package:ecommerece/firebase_options.dart';
import 'package:ecommerece/models/user_model.dart';
import 'package:ecommerece/new_architecture/controller/auth_controller.dart';
import 'package:ecommerece/new_architecture/controller/cart_controller.dart';
import 'package:ecommerece/new_architecture/controller/firestore_controller.dart';
import 'package:ecommerece/new_architecture/datasource/auth_data.dart';
import 'package:ecommerece/new_architecture/datasource/cart_data.dart';
import 'package:ecommerece/new_architecture/datasource/firestore_data.dart';
import 'package:ecommerece/new_architecture/repo/auth_logic.dart';
import 'package:ecommerece/new_architecture/repo/cart_repo.dart';
import 'package:ecommerece/new_architecture/repo/firestore_logic.dart';
import 'package:ecommerece/services/Cache_Helper.dart';
import 'package:ecommerece/services/NotificationHandler/notification_handler.dart';
import 'package:ecommerece/views/admin_loadingCheck.dart';
import 'package:ecommerece/views/admin_page.dart';
import 'package:ecommerece/views/bottom_navigation.dart';
import 'package:ecommerece/views/onBoarding.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheData.cacheInitialization();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Stripe.publishableKey = ApiKeys.publishableKey;
  NotificationHandler.instance.init().then((_) {
    runApp(MultiProvider(providers: [
      ChangeNotifierProvider(
          create: (context) =>
              FireStoreController(
                  firestorehandlerImplement: FirestorehandlerImplement(
                      cacheData: CacheData(),
                      firestoreImplement: FirestoreImplement(
                          firebaseFirestore: FirebaseFirestore.instance)))),
      ChangeNotifierProvider(
          create: (context) =>
              AuthController(
                  repo: AuthHandlerImplement(
                      authImplement:
                      AuthImplement(firebaseauth: FirebaseAuth.instance),
                      cacheData: CacheData()))),
      ChangeNotifierProvider(
          create: (context) =>
              CartController(
                  cartRepo: CartRepo(
                      cacheData: CacheData(),
                      cartStore:
                      CartSource(firebaseFirestore: FirebaseFirestore.instance))))
    ], child: MyApp()));
  });
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
    Either<String, MyUser> user = Provider.of<AuthController>(context)
        .getCurrentUser();
    Provider.of<FireStoreController>(context, listen: false)
        .initProduct(Provider.of<CartController>(context));
    // user.isRight
    //     ? Provider.of<FireStoreController>(context, listen: false)
    //         .updateItemsList(user.right)
    //     : null;
    //print("//////////////////////////////////////////////////"+user.right.role);
    return ScreenUtilInit(
      designSize: const Size(390,844),
      builder: (context,child) {
        return MaterialApp(debugShowCheckedModeBanner: false,
            home: user.isRight? AdminCheckPage(user: user.right): Intro()

        );
      }
    );
  }
}
