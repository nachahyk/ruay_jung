import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../injection.dart';
import '../bloc/add_transaction_bloc.dart';
import '../widgets/category_selector.dart';
import '../widgets/transaction_type_toggle.dart';

class AddTransactionPage extends StatelessWidget {
  const AddTransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<AddTransactionBloc>(),
      child: const AddTransactionView(),
    );
  }
}

class AddTransactionView extends StatefulWidget {
  const AddTransactionView({super.key});

  @override
  State<AddTransactionView> createState() => _AddTransactionViewState();
}

class _AddTransactionViewState extends State<AddTransactionView> {
  late final TextEditingController _amountController;
  late final TextEditingController _noteController;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController();
    _noteController = TextEditingController();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddTransactionBloc, AddTransactionState>(
      listener: (context, state) {
        if (state.status == AddTransactionStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Transaction added successfully!')),
          );
          Navigator.pop(context);
        } else if (state.status == AddTransactionStatus.failure && state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage!), backgroundColor: AppPalette.error),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Add Transaction', style: AppTextStyles.h3),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.close, color: AppPalette.textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(AppDimens.paddingPage),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Type Toggle
                      BlocSelector<AddTransactionBloc, AddTransactionState, String>(
                        selector: (state) => state.type,
                        builder: (context, type) {
                          return TransactionTypeToggle(
                            selectedType: type,
                            onTypeChanged: (newType) {
                              context.read<AddTransactionBloc>().add(AddTransactionTypeChanged(newType));
                            },
                          );
                        },
                      ),
                      const SizedBox(height: AppDimens.spacingXL),

                      // Amount Input
                      BlocSelector<AddTransactionBloc, AddTransactionState, bool>(
                        selector: (state) => state.type == 'expense',
                        builder: (context, isExpense) {
                          return AppAmountInput(
                            controller: _amountController,
                            isExpense: isExpense,
                            onChanged: (value) {
                              final amount = double.tryParse(value) ?? 0.0;
                              context.read<AddTransactionBloc>().add(AddTransactionAmountChanged(amount));
                            },
                          );
                        },
                      ),
                      const SizedBox(height: AppDimens.spacingXL),

                      // Date Picker
                      BlocSelector<AddTransactionBloc, AddTransactionState, DateTime>(
                        selector: (state) => state.date,
                        builder: (context, date) {
                          return AppDatePickerField(
                            selectedDate: date,
                            onDateSelected: (newDate) {
                              context.read<AddTransactionBloc>().add(AddTransactionDateChanged(newDate));
                            },
                          );
                        },
                      ),
                      const SizedBox(height: AppDimens.spacingL),

                      // Category Selector
                      BlocBuilder<AddTransactionBloc, AddTransactionState>(
                        buildWhen: (previous, current) => 
                            previous.categories != current.categories || 
                            previous.category != current.category,
                        builder: (context, state) {
                          return CategorySelector(
                            categories: state.categories,
                            selectedCategory: state.category,
                            onCategorySelected: (category) {
                              context.read<AddTransactionBloc>().add(AddTransactionCategoryChanged(category));
                            },
                          );
                        },
                      ),
                      const SizedBox(height: AppDimens.spacingL),

                      // Note Field
                      AppTextField(
                        label: 'Note',
                        hint: 'Add a message...',
                        controller: _noteController,
                        maxLines: 3,
                        onChanged: (value) {
                          context.read<AddTransactionBloc>().add(AddTransactionNoteChanged(value));
                        },
                      ),
                      const SizedBox(height: AppDimens.spacingXL),
                    ],
                  ),
                ),
              ),
              
              // Sticky Save Button
              Padding(
                padding: const EdgeInsets.all(AppDimens.paddingPage),
                child: BlocBuilder<AddTransactionBloc, AddTransactionState>(
                  buildWhen: (previous, current) => previous.status != current.status,
                  builder: (context, state) {
                    return AppButton(
                      text: 'Save Transaction',
                      isLoading: state.status == AddTransactionStatus.loading,
                      onPressed: () {
                        context.read<AddTransactionBloc>().add(AddTransactionSubmitted());
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
