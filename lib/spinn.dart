import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SpinningWheelScreen extends StatefulWidget {
  const SpinningWheelScreen({super.key});

  @override
  State<SpinningWheelScreen> createState() => _SpinningWheelScreenState();
}

class _SpinningWheelScreenState extends State<SpinningWheelScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final List<String> items = [
    'Short walk',
    'Call a friend',
    '10-minute reading',
    'write a gratitude journal',
    'do 15 push-ups',
    'listen to a favorite song',
    '5-minute meditation',
    'drink a glass of water',
    'relax and take a deep breath',
    'compliment someone'
  ];
  String currentItem = 'Tap Spin to Spin!';
  List<String> spinHistory = [];
  late int selectedSegment;
  late double pointerAngle = 0.0;
  StreamController<int> controller = StreamController<int>();
  String fortuneValue = 'Tap Spin';
  int za = 0;
  List <Effect<dynamic>>? effect = [];

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          selectedSegment =
              (_animation.value * items.length).floor() % items.length;
          _updateCurrentItem();
        }
      });
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
  }

  void _spinWheel() {
    // _controller.forward(from: 0.0).whenComplete(() {
    //   setState(() {
    //     pointerAngle = -(selectedSegment * 2 * pi / items.length);
    //   });
    // });
    final va = Fortune.randomInt(0, items.length);

    setState(() {
      za = va;
      controller.add(va);
    });
    _updateCurrentItem();
  }

  void _updateCurrentItem() {
    //final randomIndex = Random().nextInt(items.length);
    setState(() {
      currentItem = items[za];
      spinHistory.insert(0, items[za]);
    });
  }

  void _customizeItems() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Customize Actions',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                for (int i = 0; i < items.length; i++)
                  TextFormField(
                    initialValue: items[i],
                    decoration: InputDecoration(labelText: 'Item ${i + 1}'),
                    onChanged: (value) => items[i] = value,
                  ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _updateCurrentItem();
              },
              child: const Text('Save & Spin'),
            ),
          ],
        )
            .animate()
            .fadeIn(duration: const Duration(milliseconds: 700))
            .move(duration: const Duration(milliseconds: 700));
      },
    );
  }

  void spinhistory() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              "Spin History",
              style: TextStyle(color: Colors.white),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    'History/Log',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  for (String spin in spinHistory) Text(spin),
                ],
              ),
            ),
          )
              .animate()
              .fadeIn(duration: const Duration(milliseconds: 1000))
              .flipH();
        });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.height;
    var sizee = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 19, 31, 60),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Animate(
                  effects: [
                    const FadeEffect(duration: Duration(milliseconds: 700))
                  ],
                  child: Text(
                    "Spinning Wheel",
                    style: TextStyle(
                      color: Colors.blue[400],
                      fontSize: 32,
                    ),
                  ),
                ),
                SizedBox(
                  height: size * 0.5,
                  width: sizee * 0.92,
                  child: FortuneWheel(
                    curve: FortuneCurve.spin,
                    selected: controller.stream,
                    animateFirst: false,
                    items: [
                      for (int i = 0; i < items.length; i++) ...<FortuneItem>{
                        FortuneItem(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 100,
                              child: Text(
                                items[i],
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ).animate().fadeIn().scale(
                                  duration: const Duration(milliseconds: 500)),
                            ),
                          ],
                        )),
                      }
                    ],
                    onAnimationEnd: () {
                      setState(() {
                        fortuneValue = items[za];
                        effect = [FadeEffect(), MoveEffect(),  RotateEffect()];
                        
                      });
                    },
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 13,
                      shadowColor: Colors.blue[200],
                      shape:  const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                  onPressed: _spinWheel,
                  child: const Text('Spin'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 13,
                        shadowColor: Colors.blue[200],
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)))),
                    onPressed: spinhistory,
                    child: const Text(
                      "Spin History",
                    )),
                const SizedBox(height: 20),
                    ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 13,
                      shadowColor: Colors.blue[200],
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                  onPressed: _customizeItems,
                  child: const Text('Customize Actions'),
                ),
                const SizedBox(height: 20),
                Animate(
                  effects: effect,
                  child: Text(
                    'Task: $fortuneValue',
                    style: const TextStyle(fontSize: 18),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    controller.close();
    super.dispose();
  }
}
