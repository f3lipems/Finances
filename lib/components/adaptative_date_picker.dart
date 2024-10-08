import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:intl/intl.dart';

class AdaptativeDatePicker extends StatelessWidget {
  const AdaptativeDatePicker({
    super.key,
    required this.selectedDate,
    required this.onDateChange,
  });

  final DateTime selectedDate;
  final Function(DateTime) onDateChange;

  _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      } else {
        onDateChange(pickedDate);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Container(
          height: 180,
          child: CupertinoDatePicker(
              onDateTimeChanged: onDateChange,
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime.now(),
              minimumDate: DateTime(2024),
              maximumDate: DateTime.now(),
            ),
        )
        : Container(
            height: 70,
            child: Row(
              children: [
                Expanded(
                  child: Text('Data selecionada: ${DateFormat('dd/MM/y').format(selectedDate)}'),
                ),
                TextButton(
                  onPressed: () => _showDatePicker(context),
                  child: Text(
                    'Selecionar Data',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          );
  }
}
