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
              image: DecorationImage(image: image),
              color: Colors.blue,
            ),
            child: Text(
              'ডিজিটাল তসবি',
              style: TextStyle(fontSize: 25, fontFamily: 'Kalpurush'),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.light_mode_outlined),
            title: const Text(
              'থিম পরিবর্তন',
              style: TextStyle(fontFamily: 'Kalpurush'),
            ),
            trailing: switchdata,
            onTap: () {},
          ),
          const Divider(thickness: .5),
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
            title: const Text('প্রাইভেসি পলিসি',
                style: TextStyle(fontFamily: 'Kalpurush')),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          const Divider(thickness: .5),
          ListTile(
            leading: const Icon(Icons.mail_outline_sharp),
            title: const Text('মতামত ও পরামর্শ',
                style: TextStyle(fontFamily: 'Kalpurush')),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          const Divider(thickness: .5),
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text('শেয়ার করুন',
                style: TextStyle(fontFamily: 'Kalpurush')),
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
