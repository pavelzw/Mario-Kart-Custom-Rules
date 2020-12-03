import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class IconPicker extends StatelessWidget {
  static List<String> iconNames = [
    "mario",
    "luigi",
    "peach",
    "daisy",
    "rosalina",
    "tanooki_mario",
    "cat_peach",
    "yoshi",
    "toad",
    "koopa",
    "shy_guy",
    "lakitu",
    "toadette",
    "king_boo",
    "baby_mario",
    "baby_luigi",
    "baby_peach",
    "baby_daisy",
    "baby_rosalina",
    "metal_mario",
    "pink_gold_peach",
    "wario",
    "waluigi",
    "donkey_kong",
    "bowser",
    "dry_bones",
    "bowser_jr",
    "dry_bowser",
    "lemmy",
    "larry",
    "wendy",
    "ludwig",
    "iggy",
    "roy",
    "morton",
    "inkling_orange",
    "inkling_blue",
    "link_botw",
    "villager_male",
    "villager_female",
    "isabelle",
    "mii_amiibo"
  ];
  static List<Tuple2<String, Image>> icons = iconNames
      .map((name) =>
          Tuple2(name, Image.asset("assets/player_icons/" + name + ".png")))
      .toList();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: Wrap(
        spacing: 5,
        children: (icons
            .map((t) => GestureDetector(
                  onTap: () => Navigator.pop(context, t.item1),
                  child: Tab(icon: t.item2),
                ))
            .toList()),
      ),
    );
  }
}
