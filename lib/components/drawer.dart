import 'package:flutter/material.dart';

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
              value: isDarkMode,
              onChanged: (bool value) {
                toggleTheme(value);
              },
            ),
            onTap: () {
              // Update the sRtate of the app.
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
