import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ByteBank',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const TransferPage(title: 'Trensferências'),
    );
  }
}

class TransferPage extends StatefulWidget {
  const TransferPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<TransferPage> createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            _TransferItem(
              transfer: _Transfer(accountNumber: 1000, value: 30.00),
            ),
            _TransferItem(
              transfer: _Transfer(accountNumber: 1000, value: 20.00),
            ),
            _TransferItem(
              transfer: _Transfer(accountNumber: 1000, value: 05.00),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _TransferItem extends StatelessWidget {
  final _Transfer transfer;

  const _TransferItem({Key? key, required this.transfer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.monetization_on),
        title: Text(transfer.value.toString()),
        subtitle: Text(transfer.accountNumber.toString()),
      ),
    );
  }
}

class _Transfer {
  final int accountNumber;
  final double value;

  const _Transfer({required this.accountNumber, required this.value});
}
