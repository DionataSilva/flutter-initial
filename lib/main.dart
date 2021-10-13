import 'package:bytebank/screens/dashboard/dashboard.dart';
import 'package:flutter/material.dart';

const _appName = 'ByteBank';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _appName,
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: Colors.green[900],
        accentColor: Colors.blueAccent[700],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blueAccent[700],
          textTheme: ButtonTextTheme.primary,
        )
      ),
      home: const Dashboard(),
    );
  }
}
