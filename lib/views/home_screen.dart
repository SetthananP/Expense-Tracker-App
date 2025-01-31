import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../bloc/expense_bloc.dart';
import 'add_expense_screen.dart';
import 'edit_expense_screen.dart';
import 'expense_chart.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Expense Tracker')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            BlocBuilder<ExpenseBloc, ExpenseState>(
              builder: (context, state) {
                if (state is ExpenseLoaded && state.expenses.isNotEmpty) {
                  return Column(
                    children: [
                      ExpenseChart(expenses: state.expenses),
                      SizedBox(height: 20),
                      Text(
                        'Total Expenses: ${state.totalAmount.toStringAsFixed(2)} Bath',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                }
                return Center(child: Text('No Chart'));
              },
            ),
            Expanded(
              child: BlocBuilder<ExpenseBloc, ExpenseState>(
                builder: (context, state) {
                  if (state is ExpenseLoaded && state.expenses.isNotEmpty) {
                    return ListView.builder(
                      itemCount: state.expenses.length,
                      itemBuilder: (context, index) {
                        final expense = state.expenses[index];
                        return ListTile(
                          title: Text(expense.title),
                          subtitle: Text('${expense.amount} Bath'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditExpenseScreen(
                                          expenseId: expense.id),
                                    ),
                                  );
                                },
                                icon: Icon(Icons.edit),
                              ),
                              IconButton(
                                onPressed: () {
                                  context
                                      .read<ExpenseBloc>()
                                      .add(DeleteExpense(expense.id));
                                },
                                icon: Icon(Icons.delete),
                              ),
                            ],
                          ),
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Expense Detail',
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              icon: Icon(Icons.close),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                        Text(
                                          'Title: ${expense.title}',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'Amount: ${expense.amount} Bath',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'Category: ${expense.category}',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'Date: ${_formatDateTime(expense.date)}',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    );
                  }
                  return Center(child: Text('No Data'));
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddExpenseScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final dateFormat = DateFormat('dd-MM-yyyy HH:mm');
    return dateFormat.format(dateTime);
  }
}
