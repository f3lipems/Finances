import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import './transaction_item.dart';

class TransactionList extends StatefulWidget {
  const TransactionList({super.key, required this.transaction, required this.onRemove});

  final List<Transaction> transaction;
  final void Function(String) onRemove;

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  void _orderTransactions() {
    widget.transaction.sort((a, b) => a.date.compareTo(b.date));
  }

  @override
  Widget build(BuildContext context) {
    _orderTransactions();

    if (widget.transaction.isEmpty) {
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
      // return ListView(
      //   children: widget.transaction.map((tr) {
      //     return TransactionItem(
      //       key: ValueKey(tr.id),
      //       tr: tr,
      //       onRemove: widget.onRemove,
      //     );
      //   }).toList(),
      // );
      return ListView.builder(
        itemCount: widget.transaction.length,
        itemBuilder: (ctx, index) {
          final tr = widget.transaction[index];
          return TransactionItem(
            key: GlobalObjectKey(tr.id),
            tr: tr,
            onRemove: widget.onRemove,
          );
        },
      );
    }
  }
}
