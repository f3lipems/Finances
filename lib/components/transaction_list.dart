import 'package:finances/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({super.key, required this.transaction});

  final List<Transaction> transaction;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transaction.isEmpty
          ? Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Nenhuma transação cadastrada.',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          : ListView.builder(
              itemCount: transaction.length,
              itemBuilder: (ctx, index) {
                final tr = transaction[index];

                return Card(
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2,
                          ),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          'R\$ ${tr.value.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.titleSmall,
                          // style: const TextStyle(
                          //   fontWeight: FontWeight.bold,
                          //   fontSize: 20,
                          //   color: Colors.purple,
                          // ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tr.title,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            DateFormat('d MMM y').format(tr.date),
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
    );
  }
}
