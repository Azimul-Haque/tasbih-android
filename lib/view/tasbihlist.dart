import 'package:flutter/material.dart';
import 'package:tasbih/components/box.dart';
import 'package:tasbih/components/button.dart';
import 'package:tasbih/components/drawer.dart';
import 'package:tasbih/globals.dart';

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ListView(
            children: [
              Card(
                elevation: 1,
                child: ListTile(
                  title: Text('Item 1'),
                  subtitle: Text('Subtitle for item 1'),
                  leading: Icon(Icons.label),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    // Action for Item 1
                  },
                ),
              ),
              Card(
                elevation: 1,
                child: ListTile(
                  title: Text('Item 2'),
                  subtitle: Text('Subtitle for item 2'),
                  leading: Icon(Icons.label),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    // Action for Item 2
                  },
                ),
              ),
              Card(
                elevation: 1,
                child: ListTile(
                  title: Text('Item 3'),
                  subtitle: Text('Subtitle for item 3'),
                  leading: Icon(Icons.label),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    // Action for Item 3
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
