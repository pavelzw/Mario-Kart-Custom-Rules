import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mkcustomrules/models/player_score.dart';

class ResultPlayerRow extends StatefulWidget {
  final PlayerScore playerScore;
  final int index;
  final Function update;

  ResultPlayerRow({Key key, this.playerScore, this.index, this.update});

  @override
  _ResultPlayerRowState createState() => _ResultPlayerRowState();
}

class _ResultPlayerRowState extends State<ResultPlayerRow> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        String text = _controller.text;

        if (text.isNotEmpty) {
          widget.playerScore.place = int.parse(text);
        } else {
          widget.playerScore.place = 0;
        }
      });
      widget.update();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
          child: Image(
            image: AssetImage(widget.playerScore.player.getPlayerIconPath()),
            height: 45,
          ),
        ),
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(labelText: widget.playerScore.player.getPlayerName(context, widget.index)),
            keyboardType: TextInputType.number,
            style: TextStyle(fontSize: 16),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'^((1[0-2])|([1-9]))$'), replacementString: _controller.text),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 16, top: 16),
          width: 50,
          child: Text(
            "+" + widget.playerScore.pointsThisRound.toString(),
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
