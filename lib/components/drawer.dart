import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  final Color? color;
  final Widget? switch;

  const MyDrawer({
    super.key,
    required this.color,
    required this.switch,
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
            child: Text('Digital Tasbih'),
          ),
          ListTile(
            title:  Text('মোড পরিবর্তন করুন'),
            trailing: Switch(onChanged: {}, value: true,),
            onTap: () {
              
            },
          ),
          ListTile(
            title: const Text('Item 2'),
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
