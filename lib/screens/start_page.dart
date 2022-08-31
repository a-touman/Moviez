import 'package:flutter/material.dart';
import 'package:moviez/components/ticket_button.dart';
import 'package:moviez/services/network.dart';
import 'package:moviez/utilities/api_keys.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

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
              TicketStyleButton(
                buttonText: "Explore!",
                onPressed: () {
                  Navigator.pushNamed(context, "/LoginPage");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
