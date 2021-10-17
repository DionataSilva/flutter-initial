import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const String contactTable = 'contacts';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'bytebank.db');

  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(ContactDao.createContactTable);
    },
    version: 1,
    // onDowngrade: onDatabaseDowngradeDelete,
    onUpgrade: (db, oldVersion, newVersion) {
      // run sql code for upgrade
    },
  );
}
