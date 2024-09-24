import 'package:flutter/material.dart';
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
  final List<Transaction> _trasactions = [
    // Transaction(id: 't0', title: 'Conta Antiga', value: 326.00, date: DateTime.now().subtract(const Duration(days: 33))),
    // Transaction(id: 't1', title: 'Tênis', value: 300.00, date: DateTime.now().subtract(const Duration(days: 5))),
    // Transaction(id: 't2', title: 'Luz', value: 198.34, date: DateTime.now().subtract(const Duration(days: 3))),
    // Transaction(id: 't3', title: 'Restaurante', value: 135.40, date: DateTime.now().subtract(const Duration(days: 1))),
    // Transaction(id: 't4', title: 'Mercado', value: 452.74, date: DateTime.now()),
  ];

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        actions: [
          IconButton(
            onPressed: () => _openTransactionFormModal(context),
            icon: const Icon(Icons.add),
          )
        ],
        title: const Text(
          'Finanças',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(recentTransactions: _recentTransactions),
            TransactionList(transaction: _trasactions, onRemove: _deleteTransaction),
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
