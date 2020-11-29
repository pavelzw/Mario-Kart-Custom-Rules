import 'package:flutter/material.dart';

class AddPlayers extends StatefulWidget {
  AddPlayers({Key key, this.data});
  final List<String> data;
  final String title = "Add players";

  @override
  _AddPlayersState createState() => _AddPlayersState();
}

class _AddPlayersState extends State<AddPlayers> {
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
        controllers = [TextEditingController()];
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
                            "Ready",
                            style: TextStyle(fontSize: 20.0),
                          ),
                          onPressed: () {
                            if (controllers.isEmpty) {
                              print('You need to add at least one player');
                              return;
                            }

                            final list = controllers
                                .map((c) => c.text == ""
                                    ? "Player " +
                                        (controllers.indexOf(c) + 1).toString()
                                    : c.text)
                                .toList();
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