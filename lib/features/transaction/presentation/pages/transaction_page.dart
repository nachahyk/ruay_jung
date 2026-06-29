import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ruay_jung/core/core.dart';
import 'package:ruay_jung/features/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:ruay_jung/injection.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<TransactionBloc>()
        ..add(const TransactionCategoriesFetchRequested('expense')),
      child: const TransactionView(),
    );
  }
}

class TransactionView extends StatelessWidget {
  const TransactionView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Add Transaction',
      showBackButton: true,
      body: BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, state) {
          if (state is TransactionLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TransactionError) {
            return Center(child: Text(state.message));
          }

          if (state is TransactionCategoriesLoaded) {
            final categories = state.categories;
            return ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: category.color != null
                        ? Color(int.parse(category.color!.replaceFirst('#', '0xff')))
                        : context.colorScheme.primary,
                    child: category.icon != null
                        ? Icon(Icons.category) // You can map your icon string here
                        : const Icon(Icons.category),
                  ),
                  title: Text(category.name),
                  subtitle: Text(category.type),
                );
              },
            );
          }

          return const Center(child: Text('No categories found.'));
        },
      ),
    );
  }
}
