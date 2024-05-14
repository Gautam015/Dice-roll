// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int leftdice = 1;
  int rightdice = 1;
  late AnimationController _controller;
  late CurvedAnimation animation;

  @override
  void initState() {
    super.initState();
    animate();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void animate() {
    _controller =
        AnimationController(duration: const Duration(milliseconds: 600), vsync: this);
    animation = CurvedAnimation(parent: _controller, curve: Curves.bounceOut);
    animation.addListener(() {
      setState(() {});
      // print(animation.value);
    });
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          leftdice = Random().nextInt(6) + 1;
          rightdice = Random().nextInt(6) + 1;
        });
        // print('Completed');
        _controller.reverse();
      }
    });
  }

  void roll() {
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ignore: prefer_const_constructors
        title: Text('Dicee'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      body: Container(
        margin: const EdgeInsets.all(10.0),
        // color: const Color.fromARGB(255, 219, 26, 26),
        // alignment: ,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onDoubleTap: roll,
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Image(
                          height: 200 - (animation.value) * 200,
                          image: AssetImage(
                              'assets/images/dice-png-$leftdice.png'),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onDoubleTap: roll,
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Image(
                          height: 200 - (animation.value) * 200,
                          image: AssetImage(
                              'assets/images/dice-png-$rightdice.png'),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              ElevatedButton(
                onPressed: roll,
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(
                      Color.fromARGB(255, 0, 0, 0)),
                ),
                child: const Text(
                  'Roll',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
