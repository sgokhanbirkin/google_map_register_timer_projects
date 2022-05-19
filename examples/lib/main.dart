import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/providers/google_map_provider.dart';
import 'core/theme/custom_theme.dart';
import 'features/home_page/home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ApplicationProvider()),
      ],
      child: MaterialApp(
        theme: CustomTheme().theme,
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
      ),
    );
  }
}
