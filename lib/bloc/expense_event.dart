part of 'expense_bloc.dart';

abstract class ExpenseEvent extends Equatable {
  @override
  List<Object?> get props => [];
  const ExpenseEvent();
}

class AddExpense extends ExpenseEvent {
  final Expense expense;
  const AddExpense(this.expense);

  @override
  List<Object?> get props => [expense];
}

class DeleteExpense extends ExpenseEvent {
  final String id;
  const DeleteExpense(this.id);

  @override
  List<Object?> get props => [id];
}

class UpdateExpense extends ExpenseEvent {
  final Expense expense;
  const UpdateExpense(this.expense);

  @override
  List<Object?> get props => [expense];
}



