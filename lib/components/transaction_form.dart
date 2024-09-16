import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  TransactionForm({super.key, required this.onSubmit});

  final void Function(String, double) onSubmit;

  final titleController = TextEditingController();
  final valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: valueController,
              decoration: const InputDecoration(labelText: 'Valor (R\$)'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    final title = titleController.text;
                    final value = double.tryParse(valueController.text) ?? 0.0;
                    onSubmit(title, value);
                  },
                  style: const ButtonStyle(
                      foregroundColor: WidgetStatePropertyAll(Colors.purple)),
                  child: const Text('Nova Transação'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
