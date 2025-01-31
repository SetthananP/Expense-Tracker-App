part of 'expense_bloc.dart';

abstract class ExpenseState extends Equatable {
  const ExpenseState();

  @override
  List<Object> get props => [];
}

class ExpenseInitial extends ExpenseState {}

class ExpenseLoaded extends ExpenseState {
  final List<Expense> expenses;
  final double totalAmount;

  const ExpenseLoaded({
    required this.expenses,
    required this.totalAmount,
  });

  @override
  List<Object> get props => [expenses, totalAmount];
}
