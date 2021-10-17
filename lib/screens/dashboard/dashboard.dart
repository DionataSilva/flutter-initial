import 'package:bytebank/screens/contacts/contact_list.dart';
import 'package:bytebank/screens/transfer/transfer_list.dart';
import 'package:flutter/material.dart';

const _pageTitle = 'Dashboard';
const _contacts = 'Transfer';
const _transactions = 'Transaction Feed';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_pageTitle),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('images/bytebank_logo.png'),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20.0),
            height: 120.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _OptionCard(
                  text: _contacts,
                  icon: Icons.monetization_on,
                  onClick: () => _goTo(context, const ContactList()),
                ),
                _OptionCard(
                  text: _transactions,
                  icon: Icons.description,
                  onClick: () =>  _goTo(context, const TransferPage()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _goTo(BuildContext context, page) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => page),
    );
  }
}

class _OptionCard extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Function onClick;

  const _OptionCard({
    Key? key,
    required this.text,
    required this.icon,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () => onClick(),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            width: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 32.0,
                ),
                Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
