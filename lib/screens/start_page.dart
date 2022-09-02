import 'package:flutter/material.dart';
import 'package:moviez/components/ticket_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartPage extends StatefulWidget {
  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  late Future<String> route;

  /*
  *
  *  here in our start page of the app the below function will check if the user has a shared preference with 'name'
  *  if that is not the case they are transferred to login page to create a name
  *
  */
  Future<String> getUserStatus() async {
    final bool loggedIn;
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    loggedIn = prefs.containsKey("name");

    return loggedIn ? "/MainScreen" : "/LoginPage";
  }

  @override
  void initState() {
    super.initState();

    route = getUserStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Image.asset("images/logo.png"),
              ),
              FutureBuilder(
                future: route,
                builder: (context, snapshot) => TicketStyleButton(
                  buttonText: snapshot.data.toString().startsWith("/MainScreen")
                      ? "Welcome Back!"
                      : "Explore!",
                  onPressed: () {
                    Navigator.pushNamed(context, snapshot.data.toString());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
