import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:initialproject/models/item.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO List',
      theme: ThemeData(primarySwatch: Colors.green),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  var items = new List<Item>();

  HomeScreen() {
    items = [];
  }

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  var newTextController = TextEditingController();

  Future loadItems() async {
    var pref = await SharedPreferences.getInstance();
    var data = pref.getString('data');

    if (data != null) {
      Iterable decoded = jsonDecode(data);
      List<Item> result = decoded.map((f) => Item.fromJson(f)).toList();
      setState(() {
        widget.items = result;
      });
    }
  }

  void addItem() {
    var input = newTextController.text;
    if (input.isEmpty) return;
    setState(() {
      widget.items.add(Item(title: input));
    });
    saveItem();
    newTextController.clear();
  }

  void removeItem(index) {
    setState(() {
      widget.items.removeAt(index);
    });
    newTextController.clear();
    saveItem();
  }

  saveItem() async {
    var pref = await SharedPreferences.getInstance();
    await pref.setString('data', jsonEncode(widget.items));
  }

  HomeScreenState() {
    loadItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: newTextController,
          keyboardType: TextInputType.text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
          decoration: InputDecoration(
            labelText: "Inclua uma nova tarefa",
            labelStyle: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          final item = widget.items[index];
          return Dismissible(
            child: CheckboxListTile(
              title: Text(item.title),
              key: Key(item.title),
              value: item.done,
              onChanged: (value) {
                setState(() {
                  item.done = value;
                  saveItem();
                });
              },
            ),
            key: Key(item.title),
            background: Container(
              color: Colors.red.withOpacity(0.2),
            ),
            onDismissed: (direction) {
              removeItem(index);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addItem();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}
