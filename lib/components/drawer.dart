import 'package:flutter/material.dart';
import 'package:tasbih/globals.dart';
import 'package:tasbih/view/ayatulkursi.dart';
import 'package:tasbih/view/privacypolicy.dart';
import 'package:share_plus/share_plus.dart';

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
          DrawerHeader(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/drawer.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage('assets/images/ic_launcher.png'),
                ),
                const SizedBox(height: 5),
                const Text(
                  'ডিজিটাল তসবি',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Kalpurush'),
                ),
                Text(
                  'Version: $appversion',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
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
            leading: const Icon(Icons.mosque_outlined),
            title: const Text('আয়াতুল কুরসি',
                style: TextStyle(fontFamily: 'Kalpurush')),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AyatulKursi(),
                ),
              );
            },
          ),
          const Divider(thickness: .5),
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
            title: const Text('প্রাইভেসি পলিসি',
                style: TextStyle(fontFamily: 'Kalpurush')),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PrivacyPolicy(),
                ),
              );
            },
          ),
          // const Divider(thickness: .5),
          // ListTile(
          //   leading: const Icon(Icons.mail_outline_sharp),
          //   title: const Text('মতামত ও পরামর্শ',
          //       style: TextStyle(fontFamily: 'Kalpurush')),
          //   onTap: () {
          //     // Update the state of the app.
          //     // ...
          //   },
          // ),
          const Divider(thickness: .5),
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text('শেয়ার করুন',
                style: TextStyle(fontFamily: 'Kalpurush')),
            onTap: () {
              // Share.share(
              //     "তাসবিহ অ্যাপ https://play.google.com/store/apps/details?id=com.orbachinujbuk.tasbih",
              //     subject: "তাসবিহ অ্যাপ");
              SharePlus.instance.share(ShareParams(
                title: 'তসবিহ অ্যাপ',
                text:
                    'তসবিহ অ্যাপ https://play.google.com/store/apps/details?id=com.orbachinujbuk.tasbih',
                subject: "তসবিহ অ্যাপ",
                uri: Uri.parse(
                    'https://play.google.com/store/apps/details?id=com.orbachinujbuk.tasbih'),
              ));
            },
          ),
        ],
      ),
    );
  }
}
