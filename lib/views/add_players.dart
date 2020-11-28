import 'package:flutter/material.dart';

final Color darkBlue = Color.fromARGB(255, 18, 32, 47);

class AddPlayers extends StatefulWidget {
  AddPlayers({Key key, this.title, List<String> data})
      : data = data ?? <String>[""];
  final List<String> data;

  final String title;

  @override
  _AddPlayersState createState() => _AddPlayersState();
}

class _AddPlayersState extends State<AddPlayers> {
  final List<List<String>> players = [
    <String>['Rose', 'SunFlower'],
    <String>['SUV', 'CityCar', 'Jeep'],
  ];

  List<TextEditingController> controllers;

  @override
  void initState() {
    super.initState();

    setState(() {
      if (widget.data.isNotEmpty) {
        controllers = widget.data.map((s) {
          return TextEditingController(text: s);
        }).toList();
      } else {
        controllers = [];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: controllers == null
          ? CircularProgressIndicator()
          : Column(
              children: <Widget>[
                // Start button
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                        child: FlatButton(
                          color: Colors.blue,
                          textColor: Colors.white,
                          child: Text(
                            "Start",
                            style: TextStyle(fontSize: 20.0),
                          ),
                          onPressed: () {
                            if (controllers.isEmpty) {
                              print('You need to add at least one player');
                              return;
                            }

                            final list =
                                controllers.map((c) => c.text).toList();
                            Navigator.pop(context, list);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                // Player selection
                new Expanded(
                  child: ListView(
                    children: controllers.map((controller) {
                      return Container(
                        padding: const EdgeInsets.all(16),
                        child: TextField(
                          controller: controller,
                          decoration: InputDecoration(
                            labelText:
                                'Player ${controllers.indexOf(controller) + 1}',
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'min',
            onPressed: () {
              setState(() {
                controllers.removeLast();
              });
            },
            child: Icon(Icons.remove),
          ),
          SizedBox(width: 8),
          FloatingActionButton(
            heroTag: 'add',
            onPressed: () {
              setState(() {
                controllers.add(TextEditingController());
              });
            },
            child: Icon(Icons.add),
          )
        ],
      ),
    );
  }
}
