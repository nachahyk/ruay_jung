import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/entities/transaction_entity.dart';
import '../../domain/usecases/add_transaction.dart';
import '../../domain/usecases/get_categories.dart';

part 'add_transaction_event.dart';
part 'add_transaction_state.dart';

@injectable
class AddTransactionBloc extends Bloc<AddTransactionEvent, AddTransactionState> {
  final AddTransaction _addTransaction;
  final GetCategories _getCategories;

  AddTransactionBloc({
    required AddTransaction addTransaction,
    required GetCategories getCategories,
  })  : _addTransaction = addTransaction,
        _getCategories = getCategories,
        super(AddTransactionState(date: DateTime.now())) {
    on<AddTransactionTypeChanged>(_onTypeChanged);
    on<AddTransactionAmountChanged>(_onAmountChanged);
    on<AddTransactionDateChanged>(_onDateChanged);
    on<AddTransactionCategoryChanged>(_onCategoryChanged);
    on<AddTransactionNoteChanged>(_onNoteChanged);
    on<AddTransactionFetchCategories>(_onFetchCategories);
    on<AddTransactionSubmitted>(_onSubmitted);

    // Initial fetch
    add(AddTransactionFetchCategories(state.type));
  }

  void _onTypeChanged(AddTransactionTypeChanged event, Emitter<AddTransactionState> emit) {
    emit(state.copyWith(type: event.type, category: null));
    add(AddTransactionFetchCategories(event.type));
  }

  void _onAmountChanged(AddTransactionAmountChanged event, Emitter<AddTransactionState> emit) {
    emit(state.copyWith(amount: event.amount));
  }

  void _onDateChanged(AddTransactionDateChanged event, Emitter<AddTransactionState> emit) {
    emit(state.copyWith(date: event.date));
  }

  void _onCategoryChanged(AddTransactionCategoryChanged event, Emitter<AddTransactionState> emit) {
    emit(state.copyWith(category: event.category));
  }

  void _onNoteChanged(AddTransactionNoteChanged event, Emitter<AddTransactionState> emit) {
    emit(state.copyWith(note: event.note));
  }

  Future<void> _onFetchCategories(
    AddTransactionFetchCategories event,
    Emitter<AddTransactionState> emit,
  ) async {
    final result = await _getCategories(event.type);
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.message)),
      (categories) => emit(state.copyWith(categories: categories)),
    );
  }

  Future<void> _onSubmitted(AddTransactionSubmitted event, Emitter<AddTransactionState> emit) async {
    if (state.amount <= 0) {
      emit(state.copyWith(status: AddTransactionStatus.failure, errorMessage: 'Amount must be greater than 0'));
      return;
    }
    if (state.category == null) {
      emit(state.copyWith(status: AddTransactionStatus.failure, errorMessage: 'Please select a category'));
      return;
    }

    emit(state.copyWith(status: AddTransactionStatus.loading));

    final transaction = TransactionEntity(
      id: const Uuid().v4(),
      amount: state.amount,
      type: state.type,
      date: state.date,
      category: state.category!,
      note: state.note,
      createdAt: DateTime.now(),
    );

    final result = await _addTransaction(transaction);

    result.fold(
      (failure) => emit(state.copyWith(status: AddTransactionStatus.failure, errorMessage: failure.message)),
      (_) => emit(state.copyWith(status: AddTransactionStatus.success)),
    );
  }
}
