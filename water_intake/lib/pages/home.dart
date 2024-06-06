import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final amountController = TextEditingController(text: 'Hello');
  void addWater() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Add water'),
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Add water to your daily intake'),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Amount'),
                  )
                ],
              ),
              actions: [
                TextButton(onPressed: () {
                  Navigator.of(context).pop();
                }, child: Text('Cancel')),
                TextButton(onPressed: () {
                  // save data to db
                }, child: Text('Save')),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.map)),
        ],
        title: Text('Water'),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton:
          FloatingActionButton(onPressed: addWater, child: Icon(Icons.add)),
    );
  }
}
