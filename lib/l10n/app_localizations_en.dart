// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonSave => 'Save';

  @override
  String get commonDelete => 'Delete';

  @override
  String get commonSomethingWentWrong => 'Something went wrong';

  @override
  String get navBackToSwitcher => 'Back to Jung Studio';

  @override
  String get navOverview => 'Overview';

  @override
  String get navTransactions => 'Transactions';

  @override
  String get navBudgets => 'Budgets';

  @override
  String get navAccounts => 'Accounts';

  @override
  String get overviewTitle => 'Overview';

  @override
  String get overviewIncome => 'Income';

  @override
  String get overviewExpense => 'Expense';

  @override
  String get overviewSaved => 'Saved so far';

  @override
  String get overviewSafeToSpend => 'Safe to spend / day';

  @override
  String get overviewBudgetSectionTitle => 'This month\'s budget';

  @override
  String get overviewNoBudgets => 'No budgets set for this month yet';

  @override
  String overviewDaysLeft(int count) {
    return '$count days left';
  }

  @override
  String get transactionsTitle => 'Transactions';

  @override
  String get transactionsEmptyTitle => 'No transactions yet';

  @override
  String get transactionsEmptyBody =>
      'Log your first income or expense to get started.';

  @override
  String get transactionsLoadError => 'Failed to load transactions';

  @override
  String get transactionFormAddTitle => 'Add Transaction';

  @override
  String get transactionFormEditTitle => 'Edit Transaction';

  @override
  String get transactionFormAmountLabel => 'Amount';

  @override
  String get transactionFormAmountRequired => 'Enter an amount';

  @override
  String get transactionFormIncome => 'Income';

  @override
  String get transactionFormExpense => 'Expense';

  @override
  String get transactionFormCategoryLabel => 'Category';

  @override
  String get transactionFormCategoryRequired => 'Choose a category';

  @override
  String get transactionFormAccountLabel => 'Account';

  @override
  String get transactionFormAccountRequired => 'Choose an account';

  @override
  String get transactionFormDateLabel => 'Date';

  @override
  String get transactionFormNoteLabel => 'Note (optional)';

  @override
  String get transactionFormSaveButton => 'Save Transaction';

  @override
  String get transactionFormDeleteButton => 'Delete Transaction';

  @override
  String get transactionFormNewCategory => '+ New category';

  @override
  String get transactionFormNewCategoryTitle => 'New Category';

  @override
  String get transactionFormNewCategoryNameLabel => 'Category Name';

  @override
  String get transactionFormNewCategoryNameRequired => 'Name is required';

  @override
  String get transactionFormNoAccountsYet => 'Add an account first';

  @override
  String get budgetsTitle => 'Budgets';

  @override
  String get budgetsSubtitle =>
      'Set how much you plan to spend in each category this month.';

  @override
  String get budgetsEmptyTitle => 'No expense categories yet';

  @override
  String get budgetsEmptyBody =>
      'Add an expense category from the transaction form, then set its budget here.';

  @override
  String get budgetsAmountLabel => 'Monthly budget';

  @override
  String get accountsTitle => 'Accounts';

  @override
  String get accountsEmptyTitle => 'No accounts yet';

  @override
  String get accountsEmptyBody =>
      'Add a cash, bank, or e-wallet account to start logging transactions.';

  @override
  String get accountsAddButton => 'Add Account';

  @override
  String get accountFormTitle => 'Add Account';

  @override
  String get accountFormNameLabel => 'Account Name';

  @override
  String get accountFormNameRequired => 'Name is required';

  @override
  String get accountFormTypeLabel => 'Type';

  @override
  String get accountTypeCash => 'Cash';

  @override
  String get accountTypeBank => 'Bank';

  @override
  String get accountTypeEWallet => 'E-Wallet';

  @override
  String get accountTypeOther => 'Other';

  @override
  String get accountFormSaveButton => 'Add Account';
}
