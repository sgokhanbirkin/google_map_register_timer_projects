import 'package:flutter/material.dart';

import '../../../core/models/temp_model.dart';
import '../../home_page/home_page.dart';

class RegisterionCompletedPage extends StatelessWidget {
  final TempModel model;
  const RegisterionCompletedPage({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Register Completed'),
            Text('Name: ${model.name}'),
            Text('Email: ${model.email}'),
            Text('Phone: ${model.phone}'),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (_) => const HomePage(),
                  ),
                  (_) => false,
                );
              },
              child: const Text('Go to Home Page'),
            ),
          ],
        ),
      ),
    );
  }
}
