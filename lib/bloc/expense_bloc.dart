import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../model/expense_model.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  List<Expense> expenses = [];

  ExpenseBloc() : super(ExpenseInitial()) {
    on<AddExpense>((event, emit) {
      expenses.add(event.expense);
      final totalAmount =
          expenses.fold(0.0, (sum, expense) => sum + expense.amount);
      emit(ExpenseLoaded(
          expenses: List.from(expenses), totalAmount: totalAmount));
    });

    on<DeleteExpense>((event, emit) {
      expenses.removeWhere((expense) => expense.id == event.id);
      final totalAmount =
          expenses.fold(0.0, (sum, expense) => sum + expense.amount);
      emit(ExpenseLoaded(
          expenses: List.from(expenses), totalAmount: totalAmount));
    });

    on<UpdateExpense>((event, emit) {
      final index =
          expenses.indexWhere((expense) => expense.id == event.expense.id);
      if (index != -1) {
        expenses[index] = event.expense;
      }
      final totalAmount =
          expenses.fold(0.0, (sum, expense) => sum + expense.amount);
      emit(ExpenseLoaded(
          expenses: List.from(expenses), totalAmount: totalAmount));
    });
  }
}
