import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/expense_bloc.dart';
import 'views/home_screen.dart';

class ExpenseApp extends StatelessWidget {
  const ExpenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    final expenseBloc =
        BlocProvider<ExpenseBloc>(create: (context) => ExpenseBloc());
    return MultiBlocProvider(
      providers: [expenseBloc],
      child: MaterialApp(
        title: "Expense Tracker App",
        home: HomeScreen(),
      ),
    );
  }
}
