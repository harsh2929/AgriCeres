//to import more of gcd 
import 'package:flutter/material.dart';

class FarmProduceProfitCalculator extends StatefulWidget {
  @override
  _FarmProduceProfitCalculatorState createState() =>
      _FarmProduceProfitCalculatorState();
}

class _FarmProduceProfitCalculatorState
    extends State<FarmProduceProfitCalculator> {
  TextEditingController _costController = TextEditingController();
  TextEditingController _quantityController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _fertilizerController = TextEditingController();
  TextEditingController _seedController = TextEditingController();
  TextEditingController _harvestingController = TextEditingController();
  double _profit = 0.0;

  void _calculateProfit() {
    double cost = double.tryParse(_costController.text) ?? 0.0;
    double quantity = double.tryParse(_quantityController.text) ?? 0.0;
    double price = double.tryParse(_priceController.text) ?? 0.0;
    double fertilizerCost = double.tryParse(_fertilizerController.text) ?? 0.0;
    double seedCost = double.tryParse(_seedController.text) ?? 0.0;
    double harvestingCost = double.tryParse(_harvestingController.text) ?? 0.0;

    setState(() {
      _profit = (price * quantity) -
          cost -
          fertilizerCost -
          seedCost -
          harvestingCost;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Farm Produce Profit Calculator'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _costController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Cost per unit',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _quantityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Quantity produced',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Price per unit',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _fertilizerController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Fertilizer cost',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _seedController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Seed cost',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _harvestingController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Harvesting cost',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _calculateProfit,
              child: Text('Calculate Profit'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Profit: \$$_profit',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
