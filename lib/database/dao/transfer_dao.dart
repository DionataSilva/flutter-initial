import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/models/transfer.dart';
import 'package:sqflite/sqlite_api.dart';

class TransferDao {
  static const String transferTable = 'transfer';
  static const String _id = 'id';
  static const String _value = 'value';
  static const String _account = 'account_number';
  static const String createTransferTable = 'CREATE TABLE $transferTable('
      '$_id INTEGER PRIMARY KEY, '
      '$_account INTEGER, '
      '$_value DOUBLE '
    ')';

  Future<int> save(Transfer transfer) async {
    final Database db = await getDatabase();
    Map<String, dynamic> transferMap = _toMap(transfer);

    return db.insert(transferTable, transferMap);
  }

  Future<List<Transfer>> findAll() async {
    final db = await getDatabase();
    final result = await db.query(transferTable);

    return _toList(result);
  }

  Map<String, dynamic> _toMap(Transfer transfer) {
    final Map<String, dynamic> trnsferMap = {};

    trnsferMap[_value] = transfer.value;
    trnsferMap[_account] = transfer.accountNumber;
    return trnsferMap;
  }

  List<Transfer> _toList(List<Map<String, Object?>> result) {
    final List<Transfer> transfers = [];

    for (Map<String, dynamic> row in result) {
      final Transfer transfer = Transfer(
        row[_id],
        row[_account],
        row[_value],
      );
      transfers.add(transfer);
    }
    return transfers;
  }
}
