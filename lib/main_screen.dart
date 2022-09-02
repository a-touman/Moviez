import 'package:flutter/material.dart';
import 'package:moviez/utilities/constants.dart';
import 'package:moviez/screens/home_page.dart';
import 'package:moviez/screens/login_page.dart';
import 'package:moviez/screens/start_page.dart';
import 'package:moviez/screens/search_page.dart';
import 'package:moviez/screens/browse_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List pages = [HomePage(), BrowsePage(), SearchPage(), LoginPage()];
  int currentSelection = 0;
  void onTap(int index) {
    setState(() {
      currentSelection = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentSelection],
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTap,
          currentIndex: currentSelection,
          selectedItemColor: Colors.white,
          unselectedItemColor: kIconsColor,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          backgroundColor: kMainAppColor,
          items: [
            BottomNavigationBarItem(
                label: "Home", icon: Icon(Icons.home_filled)),
            BottomNavigationBarItem(
                label: "Browse", icon: Icon(Icons.view_agenda_outlined)),
            BottomNavigationBarItem(label: "Search", icon: Icon(Icons.search)),
            BottomNavigationBarItem(
                label: "Person", icon: Icon(Icons.person_outline)),
          ]),
    );
  }
}
