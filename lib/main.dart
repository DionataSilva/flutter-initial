import 'package:bytebank/screens/transfer_list.dart';
import 'package:flutter/material.dart';

const _appName = 'ByteBank';
const _transferPageName = 'Trensferências';

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
      ),
      home: const TransferPage(
        title: _transferPageName,
      ),
    );
  }
}
