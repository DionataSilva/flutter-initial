import 'package:bytebank/components/input_text.dart';
import 'package:bytebank/enums/snack_bar_type.dart';
import 'package:bytebank/utils/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../models/transfer.dart';

const _pageName = 'Nova tranferência';

const _accountNumberLabel = 'Número da conta';
const _accountNumberHint = '0000';

const _transferValueLabel = 'Valor e transferência';
const _transferValueHint = '0.00';

const _confirmButtomText = 'Confirmar transferência';
const _succeessMessage = 'Transferência realizada com sucesso!';
const _errorMessage = 'Todos os campos são obrigatórios!';

class TransferForm extends StatefulWidget {

  const TransferForm({Key? key}) : super(key: key);

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
      appBar: AppBar(title: const Text(_pageName)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              InputTextField(
                labelText: _accountNumberLabel,
                hintText: _accountNumberHint,
                controller: _accountNumberController,
                keyboardType: TextInputType.number,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: InputTextField(
                  labelText: _transferValueLabel,
                  hintText: _transferValueHint,
                  controller: _transferValueController,
                  icon: const Icon(Icons.monetization_on),
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _createTransfer(context),
                    child: const Text(_confirmButtomText),
                  ),
                ),
              )
            ],
          ),
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

      showSnackBar(context, message: _succeessMessage);
    } else {
      showSnackBar(context, message: _errorMessage, type: SnackBarType.error);
    }
  }
}
