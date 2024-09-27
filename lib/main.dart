import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

import './components/transaction_form.dart';
import './components/transaction_list.dart';
import './components/chart.dart';
import '../models/transaction.dart';

void main() => runApp(const Finances());

class Finances extends StatelessWidget {
  const Finances({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(1, 22, 175, 206),
          brightness: Brightness.light,
          secondary: const Color.fromARGB(1, 125, 149, 156),
          // : const Color.fromARGB(1, 125, 149, 156),
          tertiary: const Color.fromARGB(1, 138, 142, 1179),
        ),
        fontFamily: 'Quicksand',
        textTheme: const TextTheme(
          titleMedium: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _trasactions = [];
  bool _showChart = true;

  List<Transaction> get _recentTransactions {
    return _trasactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _trasactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _deleteTransaction(String id) {
    setState(() {
      _trasactions.removeWhere((tr) => tr.id == id);
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(onSubmit: _addTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    var appBar = AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      actions: [
        if (isLandscape)
          IconButton(
            onPressed: () {
              setState(() {
                _showChart = !_showChart;
              });
            },
            icon: Icon(_showChart ? Icons.list : Icons.show_chart),
          ),
        IconButton(
          onPressed: () => _openTransactionFormModal(context),
          icon: const Icon(Icons.add),
        ),
      ],
      title: const Text(
        'Finanças',
        textScaler: TextScaler.linear(1),
      ),
    );

    final availableHeight = MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // if (isLandscape)
            //   Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       const Text('Exibir Gráfico'),
            //       Switch(
            //         value: _showChart,
            //         onChanged: (value) {
            //           setState(() {
            //             _showChart = value;
            //           });
            //         },
            //       ),
            //     ],
            //   ),
            if (_showChart || !isLandscape)
              SizedBox(
                height: availableHeight * (isLandscape ? 0.7 : 0.25),
                child: Chart(recentTransactions: _recentTransactions),
              ),
            if (!_showChart || !isLandscape)
              SizedBox(
                height: availableHeight * 0.75,
                child: TransactionList(transaction: _trasactions, onRemove: _deleteTransaction),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openTransactionFormModal(context),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
    );
  }
}
