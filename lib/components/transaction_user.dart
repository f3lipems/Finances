import 'package:flutter/material.dart';
import './transaction_form.dart';
import './transaction_list.dart';
import '../models/transaction.dart';

class TransactionUser extends StatefulWidget {
  const TransactionUser({super.key});

  @override
  State<TransactionUser> createState() => _TransactionUserState();
}

class _TransactionUserState extends State<TransactionUser> {
  final _trasactions = [
    Transaction(id: 't1', title: 'Tênis', value: 300.00, date: DateTime.now()),
    Transaction(id: 't2', title: 'Luz', value: 198.34, date: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransactionList(transaction: _trasactions),
        TransactionForm(),
      ],
    );
  }
}
