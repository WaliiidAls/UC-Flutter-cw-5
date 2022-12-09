import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Classwork 1",
      home: const MyStatefulApp()));
}

class MyStatefulApp extends StatefulWidget {
  const MyStatefulApp({Key? key}) : super(key: key);

  @override
  State<MyStatefulApp> createState() => MyApp();
}

class MyApp extends State<MyStatefulApp> {
  int choice = 1;
  int choice2 = 1;
  int winner = 2;
  String desc = "";
  List matches = [0, 0, 0];
  List emojis = ["✌️", "👊", "🖐"];
  double PadVal1 = 5;
  double PadVal2 = 5;
  // 1 scissors
  // 2 rock
  // 3 paper
  void randomize() {
    setState(() {
      choice = Random().nextInt(3) + 1;
      choice2 = Random().nextInt(3) + 1;
      winnerChecker();
    });
  }

  void winnerChecker() {
    PadVal1 = PadVal2 = 5;
    if (choice == choice2) {
      winner = 2;
      desc = "Draw";
    } else if (choice == 1 && choice2 == 2) {
      winner = 1;
      desc = "Rock crushes Scissors";
      PadVal2 = 10;
    } else if (choice == 1 && choice2 == 3) {
      winner = 0;
      desc = "Scissors cuts Paper";
      PadVal1 = 10;
    } else if (choice == 2 && choice2 == 1) {
      winner = 0;
      desc = "Rock crushes Scissors";
      PadVal1 = 10;
    } else if (choice == 2 && choice2 == 3) {
      winner = 1;
      desc = "Paper covers Rock";
      PadVal2 = 10;
    } else if (choice == 3 && choice2 == 1) {
      winner = 1;
      desc = "Scissors cuts Paper";
      PadVal2 = 10;
    } else if (choice == 3 && choice2 == 2) {
      winner = 0;
      desc = "Paper covers Rock";
      PadVal1 = 10;
    }
    matches[winner]++;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("${matches[0]} vs ${matches[1]}",
              style: TextStyle(fontSize: 20)),
          Padding(padding: EdgeInsets.all(20)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  AnimatedContainer(
                    duration: Duration(seconds: 1),
                    padding: EdgeInsets.all(PadVal1),
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                        color: Colors.green.shade200.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.all(5),
                    child: Text(
                      "${emojis[choice - 1]}",
                      style: TextStyle(fontSize: 50),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 10, bottom: 10)),
                  Text("Player 1",
                      style: TextStyle(
                          color: winner == 0 ? Colors.green : Colors.black)),
                ],
              ),
              Column(
                children: [
                  AnimatedContainer(
                    duration: Duration(seconds: 1),
                    padding: EdgeInsets.all(PadVal2),
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                        color: Colors.amber.shade200.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.all(5),
                    child: Text(
                      "${emojis[choice2 - 1]}",
                      style: TextStyle(fontSize: 50),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 10, bottom: 10)),
                  Text("Player 2",
                      style: TextStyle(
                          color: winner == 1 ? Colors.green : Colors.black)),
                ],
              ),
            ],
          ),
          Padding(padding: EdgeInsets.all(10)),
          Text("$desc", style: TextStyle(color: Colors.blueGrey)),
          Padding(padding: EdgeInsets.all(10)),
          ElevatedButton(
              onPressed: () {
                randomize();
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blueGrey)),
              child: Text("Play")),
          Padding(padding: EdgeInsets.only(top: 100)),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TicTacToe()));
            },
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.black),
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              elevation: MaterialStateProperty.all(0),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: Colors.black))),
            ),
            child: Container(
              width: 110,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.arrow_forward),
                  Text("Tic Tac Toe"),
                ],
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(10)),
          Text("Made by: 56248", style: TextStyle(color: Colors.blueGrey)),
        ],
      )),
    ));
  }
}

class TicTacToe extends StatelessWidget {
  List slots = [
    ["", "", ""],
    ["", "", ""],
    ["", "", ""]
  ];
  /*
  00 01 02
  10 11 12
  20 21 22
  */
  var properties = {
    "turn": "X",
    "winner": "",
    "isFinished": false,
  };

  String checkWinner() {
    for (int i = 0; i < 3; i++) {
      if (slots[i][0] == slots[i][1] &&
          slots[i][1] == slots[i][2]) // check for horizontal
        return slots[i][0];
    }
    for (int i = 0; i < 3; i++) {
      if (slots[0][i] == slots[1][i] &&
          slots[1][i] == slots[2][i]) // check for vertical
        return slots[0][i];
    }
    if (slots[0][0] == slots[1][1] &&
        slots[1][1] == slots[2][2]) // check for diagonal 1
      return slots[0][0];
    if (slots[0][2] == slots[1][1] &&
        slots[1][1] == slots[2][0]) // check for diagonal 2
      return slots[0][2];
    return ""; // no winner
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StatefulBuilder(
      builder: (context, StateSetter setState) => Center(
        child: Container(
          height: 600,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.black),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.transparent),
                        elevation: MaterialStateProperty.all(0),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(color: Colors.black)))),
                    child: Container(
                      width: 90,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Icon(Icons.arrow_back), Text("Go back")]),
                    )),
                Column(
                  children: [
                    for (int i = 0; i < 3; i++)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int j = 0; j < 3; j++)
                            GestureDetector(
                              onTap: () {
                                if (slots[i][j] == "X" || slots[i][j] == "O")
                                  return;
                                print("$i $j");
                                setState(() {
                                  slots[i][j] = properties["turn"];
                                  properties["turn"] =
                                      properties["turn"] == "X" ? "O" : "X";
                                  properties["winner"] = checkWinner();
                                  properties["isFinished"] =
                                      properties["winner"] != "";
                                  print(properties["isFinished"]);
                                });
                              },
                              child: Container(
                                width: 75,
                                height: 75,
                                margin: EdgeInsets.all(5),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.blueGrey.shade200
                                        .withOpacity((0.5)),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(slots[i][j]),
                              ),
                            ),
                        ],
                      ),
                  ],
                ),
                Text("${properties['winner']}"),
                Padding(padding: EdgeInsets.all(10)),
                properties["isFinished"] == true
                    ? Column(
                        children: [
                          Text("Game Over"),
                          ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  properties["isFinished"] = false;
                                  properties["winner"] = "";
                                  properties["turn"] = "X";
                                  slots = [
                                    ["", "", ""],
                                    ["", "", ""],
                                    ["", "", ""]
                                  ];
                                });
                              },
                              child: Text("Restart"))
                        ],
                      )
                    : Text(""),
              ]),
        ),
      ),
    ));
  }
}
