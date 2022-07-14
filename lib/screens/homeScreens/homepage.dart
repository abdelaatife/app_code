// ignore_for_file: library_private_types_in_public_api

import 'package:app/screens/homeScreens/HomeDrawer.dart';
import 'package:app/screens/profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() =>
      _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final user = FirebaseAuth.instance.currentUser?.uid;
  var data;
CollectionReference prodect =
      FirebaseFirestore.instance.collection('users');
  getData() async {
    data = [];
    var responsebody = await prodect.get();
    responsebody.docs.forEach((element) {
      setState(() {
        data.add(element.data());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
        drawer: const HomeDrawer(),
        extendBodyBehindAppBar: true,
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                      "assets/Union-2.png"),
                  alignment: Alignment.topRight,
                  opacity: 0.5,
                  fit: BoxFit.contain),
            ),
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 40),
                child: Column(children: [
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment
                            .values[3],
                    children: [
                      Builder(
                        builder: (context) =>
                            IconButton(
                          onPressed: () {
                            Scaffold.of(context)
                                .openDrawer();
                          },
                          icon: Image.asset(
                            "assets/liste_icon.png",
                            color: Color.fromARGB(
                                255, 0, 0, 0),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (() {
                          Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          const profilePage()));
                        }),
                        child: const CircleAvatar(
                          radius: 21,
                          backgroundImage:
                              AssetImage(
                                  'assets/man.jpg'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        'Hi   ',
                        style: const TextStyle(
                            color: Color.fromARGB(
                                255, 0, 0, 0),
                            fontSize: 22,
                            fontWeight:
                                FontWeight.w500),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        'Youe have 4 new suggestion diet',
                        style: TextStyle(
                          color: Color.fromARGB(
                                  255, 0, 0, 0)
                              .withOpacity(0.75),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ]))));
  }
}
