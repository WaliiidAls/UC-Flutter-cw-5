import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyStatefulApp());
}

class MyStatefulApp extends StatefulWidget {
  const MyStatefulApp({Key? key}) : super(key: key);

  @override
  State<MyStatefulApp> createState() => MyApp();
}

class MyApp extends State<MyStatefulApp> {
  int choice = 1;
  int choice2 = 1;
  int winner = 0;
  String desc = "";
  List matches = [0, 0, 0];
  // 1 scissors
  // 2 rock
  // 3 paper
  void randomize() {
    setState(() {
      choice = Random().nextInt(3) + 1;
      choice2 = Random().nextInt(3) + 1;
      if (choice == choice2) {
        winner = 2;
        desc = "Draw";
      } else if (choice == 1 && choice2 == 2) {
        winner = 1;
        desc = "Rock crushes Scissors";
      } else if (choice == 1 && choice2 == 3) {
        winner = 0;
        desc = "Scissors cuts Paper";
      } else if (choice == 2 && choice2 == 1) {
        winner = 0;
        desc = "Rock crushes Scissors";
      } else if (choice == 2 && choice2 == 3) {
        winner = 1;
        desc = "Paper covers Rock";
      } else if (choice == 3 && choice2 == 1) {
        winner = 1;
        desc = "Scissors cuts Paper";
      } else if (choice == 3 && choice2 == 2) {
        winner = 0;
        desc = "Paper covers Rock";
      }
      matches[winner]++;
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Classwork 1",
        home: Scaffold(
            body: SafeArea(
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${matches[0]} vs ${matches[1]}",
                  style: TextStyle(fontSize: 20)),
              Padding(padding: EdgeInsets.all(30)),
              Row(
                children: [
                  Column(
                    children: [
                      Image.asset(
                        "../cw-1/images/i_$choice.png",
                        height: 200,
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      Text("Player 1",
                          style: TextStyle(
                              color:
                                  winner == 0 ? Colors.green : Colors.black)),
                    ],
                  ),
                  Column(
                    children: [
                      Image.asset(
                        "../cw-1/images/i_$choice2.png",
                        height: 200,
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      Text("Player 2",
                          style: TextStyle(
                              color:
                                  winner == 1 ? Colors.green : Colors.black)),
                    ],
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.all(30)),
              Text("$desc", style: TextStyle(color: Colors.blueGrey)),
              Padding(padding: EdgeInsets.all(30)),
              ElevatedButton(
                  onPressed: () {
                    randomize();
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blueGrey)),
                  child: Text("Play")),
            ],
          )),
        )));
  }
}
