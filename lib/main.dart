import 'package:app_despesas/Components/chart.dart';
import 'package:app_despesas/Components/transaction_form.dart';
import 'package:app_despesas/Models/transaction.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import './Components/transaction_form.dart';
import './Components/transaction_list.dart';

main() {
  runApp(AppDespesas());
}

class AppDespesas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];
  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransacao = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransacao);
    });

    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      actions: [
        IconButton(
            onPressed: () => _openTransactionFormModal(context),
            icon: Icon(Icons.add))
      ],
      title: Text(
        'Despesas Pessoais',
        style: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 20 * MediaQuery.of(context).textScaleFactor,
        ),
      ),
    );
    final avaliableHeight = MediaQuery.of(context).size.height;
    -appBar.preferredSize.height - MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Exibir Gráfico'),
                Switch(
                  value: _showChart,
                  onChanged: (value) {
                    setState(() {
                      _showChart = value;
                    });
                  },
                ),
              ],
            ),
          // if (_showChart) 
           Container(
                    height: avaliableHeight * 0.3,
                    child: Chart(recentTransactions: _recentTransactions),
                  ),
           //  if (_showChart)   
             Container(
                    height: avaliableHeight * 0.7,
                    child: TransactionList(_transactions, _removeTransaction),
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openTransactionFormModal(context),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
