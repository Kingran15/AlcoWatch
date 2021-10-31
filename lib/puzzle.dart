import 'dart:math';

import 'package:drunk_proj/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';

import 'constants.dart';
import 'api_calls.dart' as api;
import 'functions.dart';
import 'main.dart';

class Puzzle extends StatefulWidget {

  final List<IconData> iconList = [CupertinoIcons.airplane, CupertinoIcons.cloud_drizzle_fill,
  CupertinoIcons.desktopcomputer, CupertinoIcons.flag_fill, CupertinoIcons.hammer_fill,
  CupertinoIcons.moon_fill, CupertinoIcons.lab_flask_solid, CupertinoIcons.paw, CupertinoIcons.rocket_fill,
  CupertinoIcons.star_fill, CupertinoIcons.suit_heart_fill, CupertinoIcons.suit_club_fill, CupertinoIcons.suit_spade_fill,
  CupertinoIcons.suit_diamond_fill, CupertinoIcons.tortoise_fill, CupertinoIcons.wrench_fill];

  final int tries;

  Puzzle(this.tries, {Key key}) : super(key: key);

  @override
  _PuzzleState createState() => _PuzzleState();
}

class _PuzzleState extends State<Puzzle> with TickerProviderStateMixin{
  int stage;
  int tries;
  List<int> puzzleIcons = [];
  int currentIcon = 0;
  List<Widget> grid = [];
  AnimationController controller;
  Row promptRow;
  Row empty = Row();
  Row currentRow;
  SizedBox textBox;

  @override
  void initState() {
    super.initState();
    tries = widget.tries;
    if(tries <= 0) {
      _failTest();
    }

    List<int> unusedIcons = [];
    List<int> nonPuzzleIcons = [];
    Random rand = Random();
    for(int i = 0; i < 16; i++) {
      unusedIcons.add(i);
      nonPuzzleIcons.add(i);
    }

    for(int i = 0; i < 4; i++) {
      int dex = rand.nextInt(nonPuzzleIcons.length);
      puzzleIcons.add(nonPuzzleIcons[dex]);
      nonPuzzleIcons.removeAt(dex);
    }

    while(unusedIcons.isNotEmpty) {
      int toRemove = rand.nextInt(unusedIcons.length);
      grid.add(MemoryButton(unusedIcons[toRemove], _getIcon(unusedIcons[toRemove])));
      unusedIcons.removeAt(toRemove);
    }

    textBox = const SizedBox(
        height: 50,
        child: Text(
          "REMEMBER THESE!",
          style: TextStyle(
            color: black,
            fontSize: 40,
          ),
        )
    );

    promptRow = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          widget.iconList[puzzleIcons[0]],
          color: black,
          size: 100,
        ),
        const SizedBox(width: 20),
        Icon(
          widget.iconList[puzzleIcons[1]],
          color: black,
          size: 100,
        ),
        const SizedBox(width: 20),
        Icon(
          widget.iconList[puzzleIcons[2]],
          color: black,
          size: 100,
        ),
        const SizedBox(width: 20),
        Icon(
          widget.iconList[puzzleIcons[3]],
          color: black,
          size: 100,
        ),
      ],
    );

    currentRow = promptRow;
    currentIcon = 0;
    stage = 0;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: background,
        child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).padding.left,
              right: MediaQuery.of(context).padding.right,
              top: MediaQuery.of(context).padding.top + 10,
              bottom: MediaQuery.of(context).padding.bottom
            ),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 30,
                  child: AnimatedTimer(_onComplete)
              )
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 25,
              right: 25,
              top: 25 + MediaQuery.of(context).padding.top,
              bottom: 25 + MediaQuery.of(context).padding.bottom + 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  "TRIES REMAINING",
                  style: TextStyle(
                    color: black,
                    fontSize: 32
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  tries.toString(),
                  style: TextStyle(
                    color: black,
                    fontSize: 40
                  )
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    grid[0],
                    const SizedBox(width: 20),
                    grid[1],
                    const SizedBox(width: 20),
                    grid[2],
                    const SizedBox(width: 20),
                    grid[3],
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    grid[4],
                    const SizedBox(width: 20),
                    grid[5],
                    const SizedBox(width: 20),
                    grid[6],
                    const SizedBox(width: 20),
                    grid[7],
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    grid[8],
                    const SizedBox(width: 20),
                    grid[9],
                    const SizedBox(width: 20),
                    grid[10],
                    const SizedBox(width: 20),
                    grid[11],
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    grid[12],
                    const SizedBox(width: 20),
                    grid[13],
                    const SizedBox(width: 20),
                    grid[14],
                    const SizedBox(width: 20),
                    grid[15],
                  ],
                ),
                const SizedBox(height: 20),
                textBox,
                const SizedBox(width: 20),
                currentRow
              ],
            ),
        ),
        ]),
    );
  }

  void _onComplete() {
    stage++;
    setState(() {
      if(stage == 1) {
        for(int i = 0; i < grid.length; i++) {
          grid[i] = InteractiveMemoryButton((grid[i] as MemoryButton).index, (grid[i] as MemoryButton).icon, _checkPress);
        }
        currentRow = empty;
        textBox = const SizedBox(
            height: 50,
            child: Text(
              "Click the tiles with the pattern in the correct order!",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: black,
                fontSize: 40,
              ),
            )
        );
      } else if (stage == 2) {
        _failTest();
      }
    });
  }

  void _checkPress(int index) {
    if(puzzleIcons[currentIcon] == index) {
      currentIcon++;
    } else {
      _reset();
    }

    if(currentIcon == 4) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        push(const Result(true), context);
      });
    }
  }

  void _failTest() {
    api.sendMessage();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      push(const Result(false), context);
    });
  }

  void _reset() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      push(Puzzle(tries - 1), context);
    });
  }

  IconData _getIcon(int i) {
    return widget.iconList[i];
  }

}