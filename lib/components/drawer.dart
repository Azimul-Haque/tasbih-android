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
              // Image.asset("assets/images/drawer.jpg")
              color: Colors.blue,
            ),
            child: Stack(
              children: <Widget>[
                Image.asset("assets/images/drawer.jpg"),
                Positioned(
                  left: 30,
                  bottom: 70,
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Image.asset("assets/images/ic_launcher.png"),
                    // ClipRRect(
                    //   borderRadius: BorderRadius.circular(50.0),
                    //   child: Image.asset("assets/images/withouttext.png"),
                    // ),
                  ),
                ),
                Positioned(
                  left: 30,
                  bottom: 40,
                  child: Text("Infoline",
                      style: const TextStyle(
                          fontFamily: 'Calibri',
                          color: Colors.white,
                          fontSize: 16)),
                ),
                // Positioned(
                //   left: 30,
                //   bottom: 25,
                //   child: Text(userdatasp[0]['mobile'] ?? '',
                //       style: const TextStyle(color: Colors.white70, fontSize: 13)),
                // ),
                Positioned(
                  right: 10,
                  bottom: 30,
                  child: IconButton(
                    padding: const EdgeInsets.all(0.0),
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Positioned(
                  right: 3,
                  bottom: 3,
                  child: Text("Version: ",
                      style: const TextStyle(
                          color: Colors.white60,
                          fontSize: 11,
                          fontFamily: 'Arial')),
                ),
              ],
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
