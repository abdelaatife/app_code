// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:app/screens/homeScreens/homepage.dart';
import 'package:app/screens/homeScreens/measure.dart';
import 'package:app/screens/var.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icons.dart';

import 'page_phone_auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() =>
      _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _signOut() async {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                PhoneAuthPage()));
               await FirebaseAuth.instance.signOut();
   
    
  }
 

  @override
  Widget build(BuildContext context) {
    PageController _pageController = PageController(initialPage: 0);

    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (newindex) {
          setState(() {
            index = newindex;
          });
        },
        children: [
          Homepage(),
          measure(),
          Container(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        
        elevation: 1,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Ionicons.home_outline),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.pulse_outline),
            label: 'Measure',
          ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.bar_chart_outline),
            label: 'Analytics',
          ),
        ],
        currentIndex: index,
        unselectedItemColor: Color.fromARGB(255, 0, 0, 0),
        onTap: (index) {
          _pageController.animateToPage(index,
              duration: const Duration(milliseconds: 1), curve: Curves.ease);
        },
      ),
    ); }
  }

