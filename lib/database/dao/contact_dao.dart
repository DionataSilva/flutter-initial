import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/models/contact.dart';
import 'package:sqflite/sqlite_api.dart';

class ContactDao {
  static const String contactTable = 'contacts';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _account = 'account_number';
  static const String createContactTable = 'CREATE TABLE $contactTable('
      '$_id INTEGER PRIMARY KEY, '
      '$_name TEXT, '
      '$_account INTEGER '
    ')';

  Future<int> save(Contact contact) async {
    final Database db = await getDatabase();
    Map<String, dynamic> contactMap = _toMap(contact);

    return db.insert(contactTable, contactMap);
  }

  Future<List<Contact>> findAll() async {
    final db = await getDatabase();
    final result = await db.query(contactTable);

    List<Contact> contacts = _toList(result);

    return contacts;
  }

  Map<String, dynamic> _toMap(Contact contact) {
    final Map<String, dynamic> contactMap = {};

    contactMap[_name] = contact.fullName;
    contactMap[_account] = contact.accountNumber;
    return contactMap;
  }

  List<Contact> _toList(List<Map<String, Object?>> result) {
    final List<Contact> contacts = [];

    for (Map<String, dynamic> row in result) {
      final Contact contact = Contact(
        row[_id],
        row[_name],
        row[_account],
      );
      contacts.add(contact);
    }
    return contacts;
  }
}
