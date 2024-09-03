import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bindings/initial_bindings.dart';
import 'controllers/auth_controller.dart';
import 'screens/company_listing_page.dart';
import 'screens/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCNqWAKiHAOPzl2_TjiMeUc17w4i6Gq9vw",
          appId: "1:85417364680:android:fc1f1b598d46d60aafa9fd",
          messagingSenderId: "85417364680",
          projectId: "joistic-portal"));
  InitialBindings().dependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthController _authController = Get.find<AuthController>();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff645efc)),
          primaryColor: const Color(0xff645efc),
          // colorSchemeSeed: const Color(0xff645efc),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor:const Color(0xff645efc),
              foregroundColor: Colors.white
            ),
          ),
          appBarTheme: const AppBarTheme(backgroundColor: const Color.fromARGB(255, 241, 239, 239))),
      getPages: [
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/companyListing', page: () => CompanyListingPage()),
      ],
      title: 'Company App',
      debugShowCheckedModeBanner: false,
      home: Obx(() {
        if (_authController.firebaseUser.value != null) {
          return CompanyListingPage();
        } else {
          return LoginPage();
        }
      }),
    );
  }
}
