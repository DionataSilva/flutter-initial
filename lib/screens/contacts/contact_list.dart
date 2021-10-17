import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contacts/contact_form.dart';
import 'package:flutter/material.dart';

const _pageTitle = 'Contacts';

class ContactList extends StatefulWidget {
  const ContactList({Key? key}) : super(key: key);

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  final ContactDao _contactDao = ContactDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_pageTitle),
      ),
      body: FutureBuilder<List<Contact>>(
        initialData: const [],
        future: _contactDao.findAll(),
        builder: (context, snapshot) {
          final List<Contact>? contactList = snapshot.data;

          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                    Text('Loading'),
                  ],
                ),
              );
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              return ListView.builder(
                itemCount: contactList?.length,
                itemBuilder: (BuildContext context, int index) {
                  Contact contact = contactList![index];
                  return ContactCard(contact);
                },
              );
            default:
          }

          return const Text('Error');
        },
      ),
      floatingActionButton: _floatingActionButton(context),
    );
  }

  FloatingActionButton _floatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ContactForm(),
          ),
        ).then((res) => {setState(() {})});
      },
      child: const Icon(Icons.add),
    );
  }
}

class ContactCard extends StatelessWidget {
  final Contact contact;
  const ContactCard(this.contact, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}
