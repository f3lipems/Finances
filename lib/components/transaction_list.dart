import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({super.key, required this.transaction, required this.onRemove});

  final List<Transaction> transaction;
  final void Function(String) onRemove;

  void _orderTransactions() {
    transaction.sort((a, b) => a.date.compareTo(b.date));
  }

  @override
  Widget build(BuildContext context) {
    _orderTransactions();

    if (transaction.isEmpty) {
      return LayoutBuilder(builder: (context, constraints) {
        return Column(
          children: [
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            SizedBox(
              height: constraints.maxHeight * 0.2,
              child: Text(
                'Nenhuma transação cadastrada.',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            SizedBox(
              height: constraints.maxHeight * 0.6,
              child: Image.asset(
                'assets/images/waiting.png',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.1,
            )
          ],
        );
      });
    } else {
      return ListView.builder(
        itemCount: transaction.length,
        itemBuilder: (ctx, index) {
          final tr = transaction[index];
          return TransactionItem(tr: tr, onRemove: onRemove);
        },
      );
    }
  }
}
