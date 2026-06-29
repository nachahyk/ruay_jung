import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/usecases/get_categories.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

@injectable
class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final GetCategories _getCategories;

  TransactionBloc({
    required GetCategories getCategories,
  })  : _getCategories = getCategories,
        super(TransactionInitial()) {
    on<TransactionCategoriesFetchRequested>(_onCategoriesFetchRequested);
  }

  Future<void> _onCategoriesFetchRequested(
    TransactionCategoriesFetchRequested event,
    Emitter<TransactionState> emit,
  ) async {
    emit(TransactionLoading());
    final result = await _getCategories(event.type);
    result.fold(
      (failure) => emit(TransactionError(failure.message)),
      (categories) => emit(TransactionCategoriesLoaded(categories)),
    );
  }
}
