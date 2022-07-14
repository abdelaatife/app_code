import 'package:app/screens/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:line_icons/line_icons.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: (() {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => profilePage()));
                }),
                child: CircleAvatar(
                  maxRadius: 50,
                  backgroundImage: AssetImage('asset/man.jpg'),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text("user"),
          const SizedBox(
            height: 15,
          ),
          const Divider(),
          const SizedBox(
            height: 20,
          ),
          ListTile(
            onTap: () {},
            trailing: const Icon(
              LineIcons.bluetooth,
              size: 26,
            ),
            title: const Text('connect with device'),
          ),
          ListTile(
            onTap: () {},
            trailing: const Icon(LineIcons.tags),
            title: const Text('your offers'),
          ),
          ListTile(
            onTap: () {},
            trailing: const Icon(Ionicons.settings_outline),
            title: const Text('settings'),
          ),
          ListTile(
            onTap: () {},
            trailing: const Icon(Ionicons.information_circle_outline),
            title: const Text('more information'),
          ),
          ListTile(
            onTap: () {},
            trailing: const Icon(Ionicons.help_circle_outline),
            title: const Text('contact support'),
          ),
        ],
      ),
    ));
  }
}
