import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_intake/components/water_intake_summary.dart';
import 'package:water_intake/components/water_tile.dart';
import 'package:water_intake/data/water_data.dart';
import 'package:water_intake/models/water_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final amountController = TextEditingController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await Provider.of<WaterData>(context, listen: false).getWater();
    setState(() {
      _isLoading = false;
    });
  }

  void saveWater() async {
    Provider.of<WaterData>(context, listen: false).addWater(WaterModel(
      amount: double.parse(amountController.text),
      dateTime: DateTime.now(),
      unit: 'ml',
    ));

    if (!context.mounted) {
      return;
    }

    clearWater();
  }

  void addWater() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add water'),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Add water to your daily intake'),
            const SizedBox(height: 10),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Amount',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              saveWater();
              Navigator.of(context).pop();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WaterData>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.map)),
          ],
          title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Weekly: ',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text('${value.calculateWeeklyWaterIntake(value)} ml', 
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),)
          ]),
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  WaterSummary(startOfWeek: value.getStartOfWeek()),
                  Expanded(
                    child: ListView.builder(
                      itemCount: value.waterData.length,
                      itemBuilder: (context, index) {
                        final waterModel = value.waterData[index];
                        return WaterTile(waterModel: waterModel);
                      },
                    ),
                  ),
                ],
              ),
        backgroundColor: Theme.of(context).colorScheme.background,
        floatingActionButton: FloatingActionButton(
          onPressed: addWater,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void clearWater() {
    amountController.clear();
  }
}
