import 'package:bytebank/components/transfer_item.dart';
import 'package:bytebank/database/dao/transfer_dao.dart';
import 'package:bytebank/models/transfer.dart';
import 'package:bytebank/screens/transfer/transfer_form.dart';
import 'package:bytebank/utils/loader.dart';
import 'package:flutter/material.dart';

const _pageTitle = 'Transferências';
const _emptyTransferListMessage =
    'Parece que você não fez nenhuma tranferência ainda. \n Clique no botão para fazer sua primeira tranferência!';

class TransferPage extends StatefulWidget {
  const TransferPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TransferPageState();
  }
}

class TransferPageState extends State<TransferPage> {
  final TransferDao _transferDao = TransferDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_pageTitle),
      ),
      body: FutureBuilder<List<Transfer>>(
        initialData: const [],
        future: _transferDao.findAll(),
        builder: (context, snapshot) {
          final List<Transfer>? transferList = snapshot.data;

          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return const Loader();
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              return _transferItemList(transferList!);
            default:
          }

          return const Text('Error');
        },
      ),
      floatingActionButton: _floatingActionButton(context),
    );
  }

  Center _transferItemList(List<Transfer> transferList) {
    return Center(
      child: transferList.isEmpty
          ? const Text(
              _emptyTransferListMessage,
              textAlign: TextAlign.center,
            )
          : ListView.builder(
              itemCount: transferList.length,
              itemBuilder: (BuildContext context, int index) {
                return TransferItem(transfer: transferList[index]);
              },
            ),
    );
  }

  FloatingActionButton _floatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const TransferForm(),
          ),
        ).then((res) => {setState(() {})});
      },
      child: const Icon(Icons.add),
    );
  }
}
