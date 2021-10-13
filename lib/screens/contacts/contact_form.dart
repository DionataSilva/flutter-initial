import 'package:bytebank/components/input_text.dart';
import 'package:bytebank/enums/snack_bar_type.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/utils/snack_bar.dart';
import 'package:flutter/material.dart';


const _pageTitle = 'New Contact';
const _accountNumberLabel = 'Account number';
const _fullNameLabel = 'Full Name';
const _confirmButtomText = 'Create Contact';
const _succeessMessage = 'Contato criado com sucesso!';
const _errorMessage = 'Todos os campos são obrigatórios!';

class ContactForm extends StatefulWidget {
  const ContactForm({Key? key}) : super(key: key);

  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {

  final TextEditingController _fullNameCtrl = TextEditingController();
  final TextEditingController _accountNumberCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_pageTitle),
      ),
      body: _form(context),
    );
  }

  Padding _form(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          InputTextField(
            labelText: _fullNameLabel,
            controller: _fullNameCtrl,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: InputTextField(
              labelText: _accountNumberLabel,
              controller: _accountNumberCtrl,
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: SizedBox(
              width: double.maxFinite,
              child: ElevatedButton(
                onPressed: () => _createContact(context),
                child: const Text(_confirmButtomText),
              ),
            ),
          )
        ],
      ),
    );
  }

  _createContact(BuildContext context) {
    final int? accountNumber = int.tryParse(_accountNumberCtrl.text);
    final String fullName = _fullNameCtrl.text;

    if (accountNumber != null) {
      final Contact contact = Contact(
        accountNumber,
        fullName,
      );

      Navigator.pop(context, contact);
      showSnackBar(context, message: _succeessMessage);
    } else {
      showSnackBar(context, message: _errorMessage, type: SnackBarType.error);
    }
  }
}
