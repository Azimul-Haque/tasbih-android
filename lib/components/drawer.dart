import 'package:flutter/material.dart';
import 'package:dark_theme/theme/theme_provider.dart';

class MyDrawer extends StatelessWidget {
  final Color? color;

  const MyDrawer({
    super.key,
    required this.color,
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
            title: const Text('মোড পরিবর্তন করুন'),
            trailing: Switch(
              value: notifier.isDark,
              onChanged: (value)=>notifier.changeTheme()
            ),,
            onTap: () {
              // Update the state of the app.
              // ...
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
