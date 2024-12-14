import 'package:flutter/material.dart';
import 'package:tasbih/globals.dart';

class AyatulKursi extends StatefulWidget {
  const AyatulKursi({super.key});

  @override
  State<AyatulKursi> createState() => _AyatulKursiState();
}

class _AyatulKursiState extends State<AyatulKursi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          title: const Text('আয়াতুল কুরসি'),
        ),
        body: ListView(
          children: [
            const SizedBox(
              height: 5,
            ),
            _thisCard('أَسْتَغْفِرُ ٱللَّٰهَ',
                'Astaghfirullah - আসতাগফিরুল্লাহ', Icons.label, Icons.check),
          ],
        ));
  }

  Widget _thisCard(title, subtitle, IconData iconname1, IconData iconname2) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
      child: Card(
        color: Theme.of(context).colorScheme.primary,
        elevation: 1.5,
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Text(
            title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            subtitle,
            style: const TextStyle(fontSize: 15),
          ),
          leading: Icon(iconname1),
          trailing: Icon(iconname2),
          onTap: () {
            tasbihArabic = title;
            tasbihEnBn = subtitle;
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
