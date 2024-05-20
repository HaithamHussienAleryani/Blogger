import 'package:blogger/core/routing/router.dart';
import 'package:blogger/core/theme/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Blogger',
    
      theme: AppTheme.darkThemeMode,
      routerConfig: routingConfig,
    );
  }
}
