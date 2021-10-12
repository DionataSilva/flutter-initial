import 'package:bytebank/components/input_text.dart';
import 'package:bytebank/enums/snack_bar_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../models/transfer.dart';


const _accountNumberLabel = 'Número da conta';
const _accountNumberHint = '0000';

const _transferValueLabel = 'Valor e transferência';
const _transferValueHint = '0.00';

const _confirmButtomText = 'Confirmar transferência';
const _succeessMessage = 'Transferência realizada com sucesso!';
const _errorMessage = 'Todos os campos são obrigatórios!';


class TransferForm extends StatefulWidget {
  final String title;

  const TransferForm({Key? key, required this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => TransferFormState();
}

class TransferFormState extends State<TransferForm> {
  final TextEditingController _accountNumberController =
      TextEditingController();
  final TextEditingController _transferValueController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InputTextField(
              labelText: _accountNumberLabel,
              hintText: _accountNumberHint,
              controller: _accountNumberController,
            ),
            InputTextField(
              labelText: _transferValueLabel,
              hintText: _transferValueHint,
              controller: _transferValueController,
              icon: const Icon(Icons.monetization_on),
            ),
            ElevatedButton(
              onPressed: () => _createTransfer(context),
              child: const Text(_confirmButtomText),
            )
          ],
        ),
      ),
    );
  }

  void _createTransfer(BuildContext context) {
    final int? accountNumber = int.tryParse(_accountNumberController.text);
    final double? transferValue =
        double.tryParse(_transferValueController.text);

    if (accountNumber != null && transferValue != null) {
      final Transfer transfer = Transfer(
        accountNumber,
        transferValue,
      );

      Navigator.pop(context, transfer);

      _showSnackBar(context, message: _succeessMessage);
    } else {
      _showSnackBar(context, message: _errorMessage, type: SnackBarType.error);
    }
  }

  void _showSnackBar(BuildContext context,
      {required String message, SnackBarType? type = SnackBarType.success}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor:
            type == SnackBarType.error ? Theme.of(context).errorColor : null,
      ),
    );
  }
}
