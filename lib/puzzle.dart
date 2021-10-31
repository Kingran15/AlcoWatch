import 'dart:math';

import 'package:drunk_proj/widgets.dart';
import 'package:flutter/cupertino.dart';

import 'constants.dart';

class Puzzle extends StatefulWidget {

  final List<IconData> iconList = [CupertinoIcons.airplane, CupertinoIcons.cloud_drizzle_fill,
  CupertinoIcons.desktopcomputer, CupertinoIcons.flag_fill, CupertinoIcons.hammer_fill,
  CupertinoIcons.moon, CupertinoIcons.lab_flask_solid, CupertinoIcons.paw, CupertinoIcons.rocket_fill,
  CupertinoIcons.star_fill, CupertinoIcons.suit_heart_fill, CupertinoIcons.suit_club_fill, CupertinoIcons.suit_spade_fill,
  CupertinoIcons.suit_diamond_fill, CupertinoIcons.tortoise_fill, CupertinoIcons.wrench_fill];

  Puzzle({Key? key}) : super(key: key);

  @override
  _PuzzleState createState() => _PuzzleState();
}

class _PuzzleState extends State<Puzzle> {
  int num1 = 2;
  int num2 = 7;
  List<int> puzzleIcons = [];
  List<int> grid = [];

  @override
  void initState() {
    super.initState();
    List<int> unusedIcons = [];
    Random rand = Random();
    for(int i = 0; i < 16; i++) {
      if(puzzleIcons.length < 4) {
        puzzleIcons.add(rand.nextInt(16));
      }
      unusedIcons.add(i);
    }

    while(unusedIcons.isNotEmpty) {
      int toRemove = rand.nextInt(unusedIcons.length);
      grid.add(unusedIcons[toRemove]);
      unusedIcons.removeAt(toRemove);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: background,
        child: Padding(
          padding: EdgeInsets.only(
            left: 25,
            right: 25,
            top: MediaQuery.of(context).padding.top,
            bottom: 25 + MediaQuery.of(context).padding.bottom + 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const AnimatedTimer(),
              const SizedBox(height: 175),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MemoryButton(0, _getIcon(0)),
                  const SizedBox(width: 20),
                  MemoryButton(1, _getIcon(1)),
                  const SizedBox(width: 20),
                  MemoryButton(2, _getIcon(2)),
                  const SizedBox(width: 20),
                  MemoryButton(3, _getIcon(3)),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MemoryButton(4, _getIcon(4)),
                  const SizedBox(width: 20),
                  MemoryButton(5, _getIcon(5)),
                  const SizedBox(width: 20),
                  MemoryButton(6, _getIcon(6)),
                  const SizedBox(width: 20),
                  MemoryButton(7, _getIcon(7)),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MemoryButton(8, _getIcon(8)),
                  const SizedBox(width: 20),
                  MemoryButton(9, _getIcon(9)),
                  const SizedBox(width: 20),
                  MemoryButton(10, _getIcon(10)),
                  const SizedBox(width: 20),
                  MemoryButton(11, _getIcon(11)),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MemoryButton(12, _getIcon(12)),
                  const SizedBox(width: 20),
                  MemoryButton(13, _getIcon(13)),
                  const SizedBox(width: 20),
                  MemoryButton(14, _getIcon(14)),
                  const SizedBox(width: 20),
                  MemoryButton(15, _getIcon(15)),
                ],
              ),
            ],
          ),
        ),
    );
  }

  IconData _getIcon(int i) {
    return widget.iconList[grid[i]];
  }

}