import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:ruay_jung/src/theme/app_colors.dart';
import 'package:ruay_jung/l10n/app_localizations.dart';
import 'package:ruay_jung/src/core/widgets/rj_page_header.dart';
import 'package:ruay_jung/src/features/accounts/presentation/controllers/accounts_cubit.dart';
import 'package:ruay_jung/src/features/categories/domain/entities/category.dart';
import 'package:ruay_jung/src/features/categories/domain/entities/transaction_kind.dart';
import 'package:ruay_jung/src/features/categories/presentation/controllers/categories_cubit.dart';
import 'package:ruay_jung/src/features/transactions/domain/entities/transaction.dart';
import 'package:ruay_jung/src/features/transactions/presentation/controllers/transactions_cubit.dart';
import 'package:ruay_jung/src/features/transactions/presentation/controllers/transactions_state.dart';

/// Add/Edit form for a single transaction. When [transactionId] is null
/// this creates a new one; otherwise it edits the existing one, looked up
/// from `TransactionsCubit`'s already-loaded list.
class TransactionFormPage extends StatefulWidget {
  const TransactionFormPage({super.key, this.transactionId});

  final String? transactionId;

  @override
  State<TransactionFormPage> createState() => _TransactionFormPageState();
}

class _TransactionFormPageState extends State<TransactionFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();

  Transaction? _editing;
  TransactionKind _kind = TransactionKind.expense;
  String? _categoryId;
  String? _accountId;
  DateTime _occurredOn = DateTime.now();
  bool _initialized = false;

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _initFromExisting(Transaction transaction) {
    _editing = transaction;
    _amountController.text = transaction.amount.toStringAsFixed(0);
    _noteController.text = transaction.note ?? '';
    _kind = transaction.kind;
    _categoryId = transaction.categoryId;
    _accountId = transaction.accountId;
    _occurredOn = transaction.occurredOn;
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _occurredOn,
      firstDate: DateTime.now().subtract(const Duration(days: 365 * 2)),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked == null) return;
    setState(() => _occurredOn = picked);
  }

  Future<void> _addCategory() async {
    final l10n = AppLocalizations.of(context)!;
    final controller = TextEditingController();
    final name = await showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.transactionFormNewCategoryTitle),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: InputDecoration(labelText: l10n.transactionFormNewCategoryNameLabel),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(dialogContext).pop(), child: Text(l10n.commonCancel)),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(controller.text.trim()),
            child: Text(l10n.commonSave),
          ),
        ],
      ),
    );
    if (name == null || name.isEmpty || !mounted) return;
    final category = await context.read<CategoriesCubit>().createCategory(name: name, kind: _kind);
    if (!mounted) return;
    setState(() => _categoryId = category.id);
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final accountId = _accountId;
    final categoryId = _categoryId;
    if (accountId == null || categoryId == null) return;

    final transaction = Transaction(
      id: _editing?.id ?? '',
      accountId: accountId,
      categoryId: categoryId,
      kind: _kind,
      amount: double.parse(_amountController.text.trim()),
      occurredOn: _occurredOn,
      note: _noteController.text.trim().isEmpty ? null : _noteController.text.trim(),
    );

    final cubit = context.read<TransactionsCubit>();
    if (_editing == null) {
      cubit.addTransaction(transaction);
    } else {
      cubit.updateTransaction(transaction);
    }
  }

  void _delete() {
    final id = _editing?.id;
    if (id == null) return;
    context.read<TransactionsCubit>().deleteTransaction(id);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = AppColors.of(context);
    final categoriesState = context.watch<CategoriesCubit>().state;
    final accounts = context.watch<AccountsCubit>().state.accounts;

    if (!_initialized) {
      _initialized = true;
      final transactionId = widget.transactionId;
      if (transactionId != null) {
        for (final transaction in context.read<TransactionsCubit>().state.transactions) {
          if (transaction.id == transactionId) {
            _initFromExisting(transaction);
            break;
          }
        }
      } else if (accounts.isNotEmpty) {
        _accountId = accounts.first.id;
      }
    }

    final categoriesForKind = _kind == TransactionKind.income ? categoriesState.incomeCategories : categoriesState.expenseCategories;
    if (_categoryId != null && categoriesForKind.every((c) => c.id != _categoryId)) {
      _categoryId = null;
    }

    return Scaffold(
      appBar: RjPageHeader(title: _editing == null ? l10n.transactionFormAddTitle : l10n.transactionFormEditTitle),
      body: BlocListener<TransactionsCubit, TransactionsState>(
        listenWhen: (previous, current) => previous.actionStatus != current.actionStatus,
        listener: (context, state) {
          if (state.actionStatus == TransactionsActionStatus.success) {
            context.read<TransactionsCubit>().resetActionStatus();
            if (context.canPop()) context.pop();
          } else if (state.actionStatus == TransactionsActionStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.actionError ?? l10n.commonSomethingWentWrong)),
            );
            context.read<TransactionsCubit>().resetActionStatus();
          }
        },
        child: BlocBuilder<TransactionsCubit, TransactionsState>(
          builder: (context, state) {
            final isSaving = state.actionStatus == TransactionsActionStatus.saving;
            return SafeArea(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SegmentedButton<TransactionKind>(
                          segments: [
                            ButtonSegment(value: TransactionKind.expense, label: Text(l10n.transactionFormExpense)),
                            ButtonSegment(value: TransactionKind.income, label: Text(l10n.transactionFormIncome)),
                          ],
                          selected: {_kind},
                          onSelectionChanged: (selection) => setState(() {
                            _kind = selection.first;
                            _categoryId = null;
                          }),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _amountController,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          decoration: InputDecoration(labelText: l10n.transactionFormAmountLabel, prefixText: '฿ '),
                          validator: (value) {
                            final parsed = double.tryParse((value ?? '').trim());
                            return (parsed == null || parsed <= 0) ? l10n.transactionFormAmountRequired : null;
                          },
                        ),
                        const SizedBox(height: 14),
                        _CategoryPicker(
                          label: l10n.transactionFormCategoryLabel,
                          categories: categoriesForKind,
                          selectedId: _categoryId,
                          onSelected: (id) => setState(() => _categoryId = id),
                          addLabel: l10n.transactionFormNewCategory,
                          onAdd: _addCategory,
                        ),
                        if (_categoryId == null)
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(l10n.transactionFormCategoryRequired, style: TextStyle(fontSize: 12, color: colors.clay)),
                          ),
                        const SizedBox(height: 14),
                        if (accounts.isEmpty)
                          Text(l10n.transactionFormNoAccountsYet, style: TextStyle(fontSize: 13, color: colors.onCoverMuted))
                        else ...[
                          Text(l10n.transactionFormAccountLabel, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: colors.onCover)),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              for (final account in accounts)
                                ChoiceChip(
                                  label: Text(account.name),
                                  selected: _accountId == account.id,
                                  onSelected: (_) => setState(() => _accountId = account.id),
                                ),
                            ],
                          ),
                        ],
                        const SizedBox(height: 14),
                        OutlinedButton(
                          onPressed: _pickDate,
                          child: Text('${l10n.transactionFormDateLabel}: ${_occurredOn.day}/${_occurredOn.month}/${_occurredOn.year}'),
                        ),
                        const SizedBox(height: 14),
                        TextFormField(
                          controller: _noteController,
                          maxLines: 2,
                          decoration: InputDecoration(labelText: l10n.transactionFormNoteLabel),
                        ),
                        const SizedBox(height: 24),
                        FilledButton(
                          onPressed: (isSaving || accounts.isEmpty || _categoryId == null || _accountId == null) ? null : _submit,
                          child: isSaving
                              ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                              : Text(l10n.transactionFormSaveButton),
                        ),
                        if (_editing != null) ...[
                          const SizedBox(height: 10),
                          OutlinedButton(
                            onPressed: isSaving ? null : _delete,
                            style: OutlinedButton.styleFrom(foregroundColor: colors.clay, side: BorderSide(color: colors.clay)),
                            child: Text(l10n.transactionFormDeleteButton),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _CategoryPicker extends StatelessWidget {
  const _CategoryPicker({
    required this.label,
    required this.categories,
    required this.selectedId,
    required this.onSelected,
    required this.addLabel,
    required this.onAdd,
  });

  final String label;
  final List<Category> categories;
  final String? selectedId;
  final ValueChanged<String> onSelected;
  final String addLabel;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: colors.onCover)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final category in categories)
              ChoiceChip(
                label: Text(category.name),
                selected: selectedId == category.id,
                onSelected: (_) => onSelected(category.id),
              ),
            ActionChip(label: Text(addLabel), onPressed: onAdd),
          ],
        ),
      ],
    );
  }
}
