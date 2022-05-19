import 'package:flutter/material.dart';

import '../google_maps/screen/google_maps_screen.dart';
import '../register/view/register_page.dart';
import '../timer/timer_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String mapPageButtonText = 'Go to Map Page';
  final String registerPageButtonText = 'Go to Register Page';
  final String timerPageButtonText = 'Go to Timer Page';
  final String homepageTitle = 'Home Page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(homepageTitle),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const GoogleMapsScreen()));
              },
              child: Text(mapPageButtonText),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const RegisterView()));
              },
              child: Text(registerPageButtonText),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const TimerPage()));
              },
              child: Text(timerPageButtonText),
            ),
          ],
        ),
      ),
    );
  }
}
