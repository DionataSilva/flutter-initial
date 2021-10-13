import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contacts/contact_form.dart';
import 'package:flutter/material.dart';

const _pageTitle = 'Contacts';

class ContactList extends StatefulWidget {
  const ContactList({Key? key}) : super(key: key);

  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  final List<Contact> contactList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_pageTitle),
      ),
      body: _contactList(),
      floatingActionButton: _floatingActionButton(context),
    );
  }

  ListView _contactList() {
    return ListView.builder(
      itemCount: contactList.length,
      itemBuilder: (BuildContext context, int index) {
        Contact contact = contactList[index];
        return _contactCard(contact);
      },
    );
  }

  Card _contactCard(Contact contact) {
    return Card(
      child: ListTile(
        title: Text(
          contact.fullName,
          style: const TextStyle(fontSize: 24.0),
        ),
        subtitle: Text(
          contact.accountNumber.toString(),
          style: const TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }

  FloatingActionButton _floatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        final Future<Contact?> future = Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ContactForm(),
          ),
        );
        future.then((contact) => _addContact(contact));
      },
      child: const Icon(Icons.add),
    );
  }

  _addContact(Contact? contact) {
    if (contact != null) {
      setState(() {
        contactList.add(contact);
      });
    }
  }
}
