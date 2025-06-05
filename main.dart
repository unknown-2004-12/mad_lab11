import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ExpenseApp(),
  ));
}

// -------------------- MAIN WIDGET --------------------
class ExpenseApp extends StatefulWidget {
  const ExpenseApp({super.key});

  @override
  State<ExpenseApp> createState() => _ExpenseAppState();
}

// -------------------- STATE CLASS --------------------
class _ExpenseAppState extends State<ExpenseApp> {
  final TextEditingController _catCtrl = TextEditingController();
  final TextEditingController _amtCtrl = TextEditingController();
  final List<Map<String, dynamic>> _data = [];

  final List<Color> _colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple,
    Colors.teal
  ];

  void _addExpense() {
    final String category = _catCtrl.text.trim();
    final double? amount = double.tryParse(_amtCtrl.text.trim());

    if (category.isNotEmpty && amount != null) {
      setState(() {
        _data.add({
          'cat': category,
          'amt': amount,
          'clr': _colors[_data.length % _colors.length],
        });
        _catCtrl.clear();
        _amtCtrl.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // --- Input Fields ---
            TextField(
              controller: _catCtrl,
              decoration: InputDecoration(labelText: 'Category'),
            ),
            TextField(
              controller: _amtCtrl,
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addExpense,
              child: Text('Add Expense'),
            ),

            SizedBox(height: 20),

            // --- Pie Chart ---
            Expanded(
              child: _data.isEmpty
                  ? Center(child: Text('No expenses added yet'))
                  : PieChart(
                      PieChartData(
                        sections: _data.map((e) => PieChartSectionData(
                                value: e['amt'],
                                color: e['clr'],
                                title: e['cat'],
                                radius: 60,
                                titleStyle: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            )
                            .toList(),         //---------------------------------------------------------------
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
