import 'package:flutter/material.dart';
import 'package:mobx_tutorial/screens/login_screen.dart';
import 'package:mobx_tutorial/stores/login_store.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<LoginStore>(
      create: (_) => LoginStore(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MobX Tutorial',
        theme: ThemeData(
          primaryColor: Colors.deepPurpleAccent,
          scaffoldBackgroundColor: Colors.deepPurpleAccent,
        ),
        home: const LoginScreen(),
      ),
    );
  }
}
