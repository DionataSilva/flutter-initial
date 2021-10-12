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
      home: TransferPage(title: 'Trensferências'),
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
          InputTextField(
            labelText: 'Número da conta',
            hintText: '0000',
            controller: _accountNumberController,
          ),
          InputTextField(
            labelText: 'Valor e transferência',
            hintText: '0.00',
            controller: _transferValueController,
            icon: const Icon(Icons.monetization_on),
          ),
          ElevatedButton(
            onPressed: () => _createTransfer(context),
            child: Text('Confirmar transferência'),
          )
        ],
      ),
    );
  }

  void _createTransfer(BuildContext context) {
    final int? accountNumber = int.tryParse(_accountNumberController.text);
    final double? transferValue =
        double.tryParse(_transferValueController.text);

    if (accountNumber != null && transferValue != null) {
      final _Transfer transfer = _Transfer(
        accountNumber,
        transferValue,
      );

      Navigator.pop(context, transfer);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(transfer.toString()),
        ),
      );
    } else {
      debugPrint('Campos obrigatórios!');
    }
  }
}

class InputTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final Icon? icon;

  const InputTextField({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.controller,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        style: TextStyle(fontSize: 16.0),
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          icon: icon,
        ),
      ),
    );
  }
}

class TransferPage extends StatefulWidget {
  final String title;

  TransferPage({Key? key, required this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TransferPageState();
  }
}

class TransferPageState extends State<TransferPage> {
  final List<_Transfer> transferList = [];

  void _addTransfer(_Transfer transfer) {
    setState(() {
      transferList.add(transfer);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: transferList.length,
          itemBuilder: (BuildContext context, int index) {
            return _TransferItem(transfer: transferList[index]);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final Future<_Transfer?> future = Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TransferForm(title: 'Nova transferência'),
            ),
          );
          future.then((transfer) {
            debugPrint(transfer.toString());
            if (transfer != null) {
              _addTransfer(transfer);
            }
          });
        },
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
    return '_Transfer{accountNumber: $accountNumber, value: $value}';
  }
}
