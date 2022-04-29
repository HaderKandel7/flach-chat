import 'package:flash_chat/layout/home_screen.dart';
import 'package:flash_chat/layout/login_screen.dart';
import 'package:flash_chat/models/userModel.dart';
import 'package:flash_chat/services/cache_helper.dart';
import 'package:flash_chat/shared/bloc_observer.dart';
import 'package:flash_chat/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart' as b;
import 'package:flutter/services.dart';

void main() async {
  // b.Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await CacheHelper.init();
  uId = CacheHelper.getData(key: 'uId');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        appBarTheme: AppBarTheme(
        titleSpacing: 20,
        backgroundColor: Colors.white,
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        elevation: 0.0,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      ),
      home: (uId == '' || uId== null)
          ? LoginScreen()
          : HomeScreen(
              flag: true,
            ),
    );
  }
}
