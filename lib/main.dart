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
      home: TransferForm(
          title: 'Nova transferência'), //TransferPage(title: 'Trensferências'),
    );
  }
}

class TransferForm extends StatelessWidget {
  final String title;
  final TextEditingController _accountNumberController =
      TextEditingController();
  final TextEditingController _transferValueController =
      TextEditingController();

  TransferForm({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _accountNumberController,
              keyboardType: TextInputType.number,
              style: TextStyle(fontSize: 16.0),
              decoration: InputDecoration(
                  labelText: 'Número da conta', hintText: '0000'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _transferValueController,
              keyboardType: TextInputType.number,
              style: TextStyle(fontSize: 16.0),
              decoration: InputDecoration(
                labelText: 'Valor e transferência',
                hintText: '0.00',
                icon: Icon(Icons.monetization_on),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final int? accountNumber =
                  int.tryParse(_accountNumberController.text);
              final double? transferValue =
                  double.tryParse(_transferValueController.text);

              if (accountNumber != null && transferValue != null) {
                final _Transfer transfer = _Transfer(
                  accountNumber,
                  transferValue,
                );

                debugPrint('Transferência!: $transfer');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(transfer.toString()),
                  ),
                );
              } else {
                debugPrint('Campos obrigatórios!');
              }
            },
            child: Text('Confirmar transferência'),
          )
        ],
      ),
    );
  }
}

class TransferPage extends StatelessWidget {
  final String title;

  const TransferPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          children: [
            _TransferItem(
              transfer: _Transfer(1000, 20.00),
            ),
            _TransferItem(
              transfer: _Transfer(1000, 05.00),
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

  _Transfer(this.accountNumber, this.value);

  @override
  String toString() {
    return '_Transfer{ accountNumber: $accountNumber, value: $value }';
  }
}
