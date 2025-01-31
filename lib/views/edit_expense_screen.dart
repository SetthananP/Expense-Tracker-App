import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/expense_bloc.dart';
import '../model/expense_model.dart';

class EditExpenseScreen extends StatefulWidget {
  final String expenseId;

  const EditExpenseScreen({super.key, required this.expenseId});

  @override
  State<EditExpenseScreen> createState() => _EditExpenseScreenState();
}

String selectedCategory = 'Food';

class _EditExpenseScreenState extends State<EditExpenseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Expense')),
      body: BlocBuilder<ExpenseBloc, ExpenseState>(
        builder: (context, state) {
          if (state is ExpenseLoaded) {
            final expense =
                state.expenses.firstWhere((e) => e.id == widget.expenseId);
            final titleController = TextEditingController(text: expense.title);
            final amountController =
                TextEditingController(text: expense.amount.toString());
            String selectedCategory = expense.category;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(labelText: 'Title'),
                  ),
                  TextField(
                    controller: amountController,
                    decoration: InputDecoration(labelText: 'Amount'),
                  ),
                  DropdownButton<String>(
                    value: selectedCategory,
                    onChanged: (newValue) {
                      selectedCategory = newValue!;
                    },
                    items: ['Food', 'Transportation', 'Entertainment', 'Other']
                        .map((category) => DropdownMenuItem(
                            value: category, child: Text(category)))
                        .toList(),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final updatedExpense = Expense(
                        id: expense.id,
                        title: titleController.text,
                        amount: double.tryParse(amountController.text) ?? 0,
                        category: selectedCategory,
                        date: expense.date,
                      );
                      context
                          .read<ExpenseBloc>()
                          .add(UpdateExpense(updatedExpense));
                      Navigator.pop(context);
                    },
                    child: Text('Update'),
                  )
                ],
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
