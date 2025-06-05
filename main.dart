import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
void main(){
  runApp(MaterialApp(
    home: Expense(),
    debugShowCheckedModeBanner: false,
  ));
}
class Expense extends StatefulWidget {
  const Expense({super.key});
  @override
  State<Expense> createState() => _ExpenseState();
}
class _ExpenseState extends State<Expense>{
  final TextEditingController catCtrl = TextEditingController();
  final TextEditingController amtCtrl = TextEditingController();
  final List<Map<String, dynamic>> data = [];
  final List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.yellow,
    Colors.pink,
  ];
  void addExpense(){
    final String category = catCtrl.text.trim();
    final double? amt = double.tryParse(amtCtrl.text.trim());
    if( category.isNotEmpty && amt != null){
      setState((){
        data.add({
          'cat': category,
          'amt': amt,
          'clr': colors[data.length % colors.length],
        });
      });
    }
    catCtrl.clear();
    amtCtrl.clear();
  }
  @override   
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: catCtrl,
            decoration: InputDecoration(labelText: 'category'),
          ),
          SizedBox(height: 10,),
          TextField(
            controller: amtCtrl,
            decoration: InputDecoration(labelText: 'amount'),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 10,),
          ElevatedButton(
            onPressed: () => addExpense(),
            child: Text('Add Expense'),
          ),
          SizedBox(height: 20,),
          Expanded(
            child:  PieChart(
                    PieChartData(
                      sections: data.map((e) => PieChartSectionData(
                        color: e['clr'],
                        value: e['amt'],
                        title: e['cat'],
                        radius: 50,
                        titleStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )).toList()
                    )
                  ),
          )

        ],
      ),
    );
  }
}
