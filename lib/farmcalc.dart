//to import more of gcd 
import 'package:flutter/material.dart';

class FarmerYearlyProfitCalculator extends StatefulWidget {
  @override
  _FarmerYearlyProfitCalculatorState createState() =>
      _FarmerYearlyProfitCalculatorState();
}

//adding moe variables 
class _FarmerYearlyProfitCalculatorState
    extends State<FarmerYearlyProfitCalculator> {
  TextEditingController _cropSalesQuantityController = TextEditingController();
  TextEditingController _cropSalesPriceController = TextEditingController();
  TextEditingController _cropProductionCostController =
      TextEditingController();
  TextEditingController _fertilizerCostController = TextEditingController();
  TextEditingController _seedCostController = TextEditingController();
  TextEditingController _harvestingCostController = TextEditingController();
  TextEditingController _irrigationCostController = TextEditingController();
  TextEditingController _laborCostController = TextEditingController();
  TextEditingController _pestControlCostController = TextEditingController();
  TextEditingController _storageCostController = TextEditingController();
  TextEditingController _transportationCostController =
      TextEditingController();
  TextEditingController _marketingCostController = TextEditingController();
  TextEditingController _interestAndFinanceChargesController =
      TextEditingController();
  TextEditingController _taxesAndInsuranceController =
      TextEditingController();
  TextEditingController _equipmentAndMachineryCostsController =
      TextEditingController();
  TextEditingController _miscellaneousCostsController =
      TextEditingController();
  TextEditingController _loanAmountController = TextEditingController();

  double _totalCropSales = 0.0;
  double _totalVariableCosts = 0.0;
  double _totalCosts = 0.0;
  double _totalProfit = 0.0;

  void _calculateProfit() {
    double cropSalesQuantity =
        double.tryParse(_cropSalesQuantityController.text) ?? 0.0;
    double cropSalesPrice =
        double.tryParse(_cropSalesPriceController.text) ?? 0.0;
    double cropProductionCost =
        double.tryParse(_cropProductionCostController.text) ?? 0.0;
    double fertilizerCost =
        double.tryParse(_fertilizerCostController.text) ?? 0.0;
    double seedCost = double.tryParse(_seedCostController.text) ?? 0.0;
    double harvestingCost =
        double.tryParse(_harvestingCostController.text) ?? 0.0;
    double irrigationCost =
        double.tryParse(_irrigationCostController.text) ?? 0.0;
    double laborCost = double.tryParse(_laborCostController.text) ?? 0.0;
    double pestControlCost =
        double.tryParse(_pestControlCostController.text) ?? 0.0;
    double storageCost = double.tryParse(_storageCostController.text) ?? 0.0;
    double transportationCost =
        double.tryParse(_transportationCostController.text) ?? 0.0;
    double marketingCost =
        double.tryParse(_marketingCostController.text) ?? 0.0;
    double interestAndFinanceCharges =
        double.tryParse(_interestAndFinanceChargesController.text) ?? 0.0;
    double taxesAndInsurance =
        double.tryParse(_taxesAndInsuranceController.text) ?? 0.0;
    double equipmentAndMachineryCosts =
        double.tryParse(_equipmentAndMachineryCostsController.text) ?? 0.0;
    double miscellaneousCosts =
        double.tryParse(_miscellaneousCostsController.text) ?? 0.0;
    double loanAmount = double.tryParse(_loanAmountController.text) ?? 0.0;

    setState(() {
      _totalCropSales = cropSalesQuantity * cropSalesPrice;
      _totalVariableCosts = cropProductionCost +
          fertilizerCost +
          seedCost +
          harvestingCost +
          irrigationCost +
laborCost +
          pestControlCost +
          storageCost +
          transportationCost +
          marketingCost +
          interestAndFinanceCharges +
          taxesAndInsurance +
          equipmentAndMachineryCosts +
          miscellaneousCosts;

      _totalCosts = _totalVariableCosts + loanAmount;
      _totalProfit = _totalCropSales - _totalCosts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Farmer Yearly Profit Calculator'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _cropSalesQuantityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Crop Sales Quantity'),
            ),
            TextField(
              controller: _cropSalesPriceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Crop Sales Price'),
            ),
            TextField(
              controller: _cropProductionCostController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Crop Production Cost'),
            ),
            TextField(
              controller: _fertilizerCostController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Fertilizer Cost'),
            ),
            TextField(
              controller: _seedCostController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Seed Cost'),
            ),
            TextField(
              controller: _harvestingCostController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Harvesting Cost'),
            ),
            TextField(
              controller: _irrigationCostController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Irrigation Cost'),
            ),
            TextField(
              controller: _laborCostController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Labor Cost'),
            ),
            TextField(
              controller: _pestControlCostController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Pest Control Cost'),
            ),
            TextField(
              controller: _storageCostController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Storage Cost'),
            ),
            TextField(
              controller: _transportationCostController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Transportation Cost'),
            ),
            TextField(
              controller: _marketingCostController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Marketing Cost'),
            ),
            TextField(
              controller: _interestAndFinanceChargesController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'Interest and Finance Charges'),
            ),
            TextField(
              controller: _taxesAndInsuranceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Taxes and Insurance'),
            ),
            TextField(
              controller: _equipmentAndMachineryCostsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'Equipment and Machinery Costs'),
            ),
            TextField(
              controller: _miscellaneousCostsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Miscellaneous Costs'),
            ),
            TextField(
              controller: _loanAmountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Loan Amount'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _calculateProfit();
                });
              },
              child: Text('Calculate Profit'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Total Crop Sales: \$$_totalCropSales',
              style: TextStyle(fontSize: 18.0),
            ),
            Text(
              'Total Variable Costs: \$$_totalVariableCosts',
              style: TextStyle(fontSize: 18.0),
            ),
            Text(
              'Total Costs: \$$_totalCosts',
              style: TextStyle(fontSize: 18.0),
            ),
            Text(
              'Total Profit: \$$_totalProfit',
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}