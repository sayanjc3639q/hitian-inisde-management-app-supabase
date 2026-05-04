import 'package:flutter/material.dart';
import 'theme.dart';
import 'main_scaffold.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const HITianInsideApp());
}

class HITianInsideApp extends StatelessWidget {
  const HITianInsideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HITian Inside',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      home: const MainScaffold(),
    );
  }
}
