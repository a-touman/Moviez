import 'package:flutter/material.dart';
import 'package:moviez/screens/movie_details_screen.dart';
import 'package:moviez/screens/movie_genre_screen.dart';
import 'package:moviez/utilities/constants.dart';
import 'package:moviez/main_screen.dart';
import 'package:moviez/models/login_provider.dart';
import 'package:moviez/screens/home_page.dart';
import 'package:moviez/screens/login_page.dart';
import 'package:moviez/screens/start_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: kMainAppColor,
        ),
        initialRoute: "/MainScreen",
        routes: {
          "/StartPage": (context) => StartPage(),
          "/MainScreen": (context) => MainScreen(),
          "/LoginPage": (context) => LoginPage(),
          "/HomePage": (context) => HomePage(),
          "/MovieDetails": (context) => MovieDetails(),
          "/MovieGenrePage": (context) => MovieGenrePage(),
        },
      ),
    );
  }
}
