import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:ruay_jung/src/theme/app_colors.dart';
import 'package:ruay_jung/l10n/app_localizations.dart';
import 'package:ruay_jung/src/core/utils/formatters.dart';
import 'package:ruay_jung/src/features/accounts/domain/entities/account.dart';
import 'package:ruay_jung/src/features/accounts/presentation/controllers/accounts_cubit.dart';
import 'package:ruay_jung/src/features/accounts/presentation/controllers/accounts_state.dart';
import 'package:ruay_jung/src/features/transactions/presentation/controllers/transactions_cubit.dart';

class AccountsPage extends StatefulWidget {
  const AccountsPage({super.key});

  @override
  State<AccountsPage> createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
  @override
  void initState() {
    super.initState();
    context.read<AccountsCubit>().loadAccounts();
    context.read<TransactionsCubit>().loadTransactions();
  }

  Future<void> _addAccount() async {
    final l10n = AppLocalizations.of(context)!;
    final colors = AppColors.of(context);
    final nameController = TextEditingController();
    var selectedType = AccountType.cash;

    final created = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (sheetContext, setSheetState) {
            return Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, MediaQuery.of(sheetContext).viewInsets.bottom + 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(l10n.accountFormTitle, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: colors.ink)),
                  const SizedBox(height: 16),
                  TextField(
                    controller: nameController,
                    autofocus: true,
                    decoration: InputDecoration(labelText: l10n.accountFormNameLabel),
                  ),
                  const SizedBox(height: 14),
                  Text(l10n.accountFormTypeLabel, style: TextStyle(fontSize: 12.5, color: colors.inkMuted)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: [
                      for (final type in AccountType.values)
                        ChoiceChip(
                          label: Text(_typeLabel(l10n, type)),
                          selected: selectedType == type,
                          onSelected: (_) => setSheetState(() => selectedType = type),
                        ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  FilledButton(
                    onPressed: () {
                      if (nameController.text.trim().isEmpty) return;
                      context.read<AccountsCubit>().createAccount(name: nameController.text.trim(), type: selectedType);
                      Navigator.of(sheetContext).pop(true);
                    },
                    child: Text(l10n.accountFormSaveButton),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
    if (created == true) nameController.dispose();
  }

  String _typeLabel(AppLocalizations l10n, AccountType type) {
    return switch (type) {
      AccountType.cash => l10n.accountTypeCash,
      AccountType.bank => l10n.accountTypeBank,
      AccountType.eWallet => l10n.accountTypeEWallet,
      AccountType.other => l10n.accountTypeOther,
    };
  }

  IconData _typeIcon(AccountType type) {
    return switch (type) {
      AccountType.cash => Icons.payments_outlined,
      AccountType.bank => Icons.account_balance_outlined,
      AccountType.eWallet => Icons.smartphone_outlined,
      AccountType.other => Icons.wallet_outlined,
    };
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = AppColors.of(context);
    final accountsState = context.watch<AccountsCubit>().state;
    final transactionsState = context.watch<TransactionsCubit>().state;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.accountsTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: l10n.navBackToSwitcher,
          onPressed: () => context.go('/'),
        ),
      ),
      body: accountsState.status == AccountsStatus.loading
          ? const Center(child: CircularProgressIndicator())
          : accountsState.accounts.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.account_balance_wallet_outlined, size: 40, color: colors.onCoverMuted),
                        const SizedBox(height: 14),
                        Text(l10n.accountsEmptyTitle, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: colors.onCover)),
                        const SizedBox(height: 6),
                        Text(l10n.accountsEmptyBody, textAlign: TextAlign.center, style: TextStyle(fontSize: 13, color: colors.onCoverMuted)),
                      ],
                    ),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 90),
                  itemCount: accountsState.accounts.length,
                  itemBuilder: (context, index) {
                    final account = accountsState.accounts[index];
                    final balance = transactionsState.totalForAccount(account.id);
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(color: colors.page, borderRadius: BorderRadius.circular(14)),
                        child: Row(
                          children: [
                            Container(
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(color: colors.goldTint, borderRadius: BorderRadius.circular(11)),
                              child: Icon(_typeIcon(account.type), size: 18, color: colors.goldBright),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(account.name, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: colors.ink)),
                                  Text(_typeLabel(l10n, account.type), style: TextStyle(fontSize: 11.5, color: colors.inkMuted)),
                                ],
                              ),
                            ),
                            Text(
                              Formatters.baht(balance),
                              style: TextStyle(
                                fontSize: 14.5,
                                fontWeight: FontWeight.w700,
                                color: balance >= 0 ? colors.emerald : colors.clay,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addAccount,
        icon: const Icon(Icons.add),
        label: Text(l10n.accountsAddButton),
        shape: const StadiumBorder(),
      ),
    );
  }
}
