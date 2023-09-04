import 'package:custom_render/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

class CustomRenderApp extends StatelessWidget {
  const CustomRenderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomeScreen(),
    );
  }
}
