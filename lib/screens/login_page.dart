import 'package:flutter/material.dart';
import 'package:moviez/utilities/constants.dart';
import 'package:moviez/models/login_provider.dart';
import 'package:provider/provider.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:moviez/components/ticket_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/name_field.dart';
import 'home_page.dart';

class LoginPage extends StatelessWidget {
  late String randomGen;
  late String name;

  @override
  Widget build(BuildContext context) {
    name = Provider.of<LoginProvider>(context).lName;
    randomGen = Provider.of<LoginProvider>(context).lSeed;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: randomAvatar(
                  randomGen,
                  height: 100,
                  width: 100,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              NameTextField(
                onChange: (value) {
                  Provider.of<LoginProvider>(context, listen: false)
                      .changeNamePfp(value);
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              TicketStyleButton(
                buttonText: "Enter",
                onPressed: () async {
                  if (name.isNotEmpty) {
                    String name =
                        Provider.of<LoginProvider>(context, listen: false)
                            .lName;
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.setString("name", name);

                    Navigator.popAndPushNamed(context, "/MainScreen");
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Name field empty",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }
                },
                height: 60,
                width: 200,
              )
            ],
          ),
        ),
      ),
    );
  }
}
