import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  final Color? color;
  final Widget? switchdata;

  const MyDrawer({
    super.key,
    required this.color,
    this.switchdata,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            // margin: EdgeInsets.zero,
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'ডিজিটাল তসবি',
              style: TextStyle(fontSize: 25),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.light_mode_outlined),
            title: const Text('থিম পরিবর্তন'),
            trailing: switchdata,
            onTap: () {},
          ),
          const Divider(thickness: .5),
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
            title: const Text('প্রাইভেসি পলিসি'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          const Divider(thickness: .5),
          ListTile(
            title: const Text('মতামত ও পরামর্শ'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          const Divider(thickness: .5),
          ListTile(
            leading: Icon(Icons.light_mode_outlined),
            title: const Text('শেয়ার করুন'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
        ],
      ),
    );
  }
}
