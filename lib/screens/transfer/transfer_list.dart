import 'package:bytebank/components/transfer_item.dart';
import 'package:bytebank/models/transfer.dart';
import 'package:bytebank/screens/transfer/transfer_form.dart';
import 'package:flutter/material.dart';

const pageTitle = 'Transferências';

class TransferPage extends StatefulWidget {

  const TransferPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TransferPageState();
  }
}

class TransferPageState extends State<TransferPage> {
  final List<Transfer> transferList = [];

  void _addTransfer(Transfer? transfer) {
    if (transfer != null) {
      setState(() {
        transferList.add(transfer);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(pageTitle),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: transferList.length,
          itemBuilder: (BuildContext context, int index) {
            return TransferItem(transfer: transferList[index]);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final Future<Transfer?> future = Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  const TransferForm(),
            ),
          );
          future.then((transfer) => _addTransfer(transfer));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
