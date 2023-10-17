import 'dart:async';

import 'package:flappy_bird_clone/barriers.dart';
import 'package:flappy_bird_clone/bird.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdYaxis = 0;
  double time = 0;
  double highscore = 0;
  double score = 0;
  double height = 0;
  double initialHeight = birdYaxis;
  bool gameHasStarted = false;
  static double barrierXone = 1;
  double barrierXtwo = barrierXone + 1.5;

  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYaxis;
    });
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.brown,
            title: const Text(
              "GAME OVER",
              style: TextStyle(color: Colors.white),
            ),
            content: Text(
              "Score: $score",
              style: const TextStyle(color: Colors.white),
            ),
            actions: [
              TextButton(
                child: const Text(
                  "PLAY AGAIN",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  if (score > highscore) {
                    highscore = score;
                  }
                  initState();
                  setState(() {
                    gameHasStarted = false;
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(const Duration(milliseconds: 60), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        birdYaxis = initialHeight - height;
      });

      setState(() {
        if (barrierXone < -2) {
          barrierXone += 3.5;
        } else {
          barrierXone -= 0.05;
        }
      });

      setState(() {
        if (barrierXtwo < -2) {
          barrierXtwo += 3.5;
        } else {
          barrierXtwo -= 0.05;
        }
      });

      if (birdYaxis > 1) {
        timer.cancel();
        gameHasStarted = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          if (gameHasStarted) {
            jump();
          } else {
            startGame();
          }
        },
        child: Scaffold(
          body: Column(
            children: [
              Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    AnimatedContainer(
                      alignment: Alignment(0, birdYaxis),
                      duration: const Duration(milliseconds: 0),
                      color: Colors.blue,
                      child: const MyBird(),
                    ),
                    Container(
                      alignment: const Alignment(0, -0.3),
                      child: gameHasStarted
                          ? const Text(" ")
                          : const Text(
                              "T A P  T O  P L A Y",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(barrierXone, 1.4),
                      duration: const Duration(milliseconds: 0),
                      child: const MyBarrier(
                        size: 200.0,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(barrierXone, -1.6),
                      duration: const Duration(milliseconds: 0),
                      child: const MyBarrier(
                        size: 200.0,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(barrierXtwo, 1.3),
                      duration: const Duration(milliseconds: 0),
                      child: const MyBarrier(
                        size: 150.0,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(barrierXtwo, -1.8),
                      duration: const Duration(milliseconds: 0),
                      child: const MyBarrier(
                        size: 250.0,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 15,
                color: Colors.green,
              ),
              Expanded(
                child: Container(
                  color: Colors.brown,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "SCORE",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "0",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "BEST",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "10",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
