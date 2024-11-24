import 'package:flutter/material.dart';

class TasbihList extends StatefulWidget {
  final String title;

  const TasbihList({
    super.key,
    required this.title,
  });

  @override
  State<TasbihList> createState() => _TasbihListState();
}

class _TasbihListState extends State<TasbihList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView(
          children: [
            const SizedBox(
              height: 5,
            ),
            _thisCard(),
            _thisCard(),
            _thisCard(),
          ],
        ));
  }

  Widget _thisCard(title, subtitle, IconData iconname) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
      child: Card(
        color: Theme.of(context).colorScheme.primary,
        elevation: 1,
        child: ListTile(
          title: Text(title),
          subtitle: Text(subtitle),
          leading: Icon(iconname),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {
            // Action for Item 1
          },
        ),
      ),
    );
  }
}
