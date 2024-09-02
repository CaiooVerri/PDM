import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicação Bancária',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BankingFormScreen(),
    );
  }
}

class BankingFormScreen extends StatefulWidget {
  @override
  _BankingFormScreenState createState() => _BankingFormScreenState();
}

class _BankingFormScreenState extends State<BankingFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _accountNumberController = TextEditingController();
  final _amountController = TextEditingController();
  final _transactions = <String>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aplicação Bancária'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _accountNumberController,
                  decoration: InputDecoration(labelText: 'Número da Conta'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o número da conta';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _amountController,
                  decoration: InputDecoration(labelText: 'Valor'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira um valor';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _handleSubmit,
                  child: Text('Adicionar Transação'),
                ),
                SizedBox(height: 16.0),
              ],
            ),
          ),
          Text(
            'Transações:',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          ..._transactions.map((transaction) => ListTile(
                title: Text(transaction),
              )),
        ],
      ),
    );
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        final accountNumber = _accountNumberController.text;
        final amount = _amountController.text;
        _transactions.add('Conta: $accountNumber, Valor: $amount');
        _accountNumberController.clear();
        _amountController.clear();
      });
    }
  }
}
