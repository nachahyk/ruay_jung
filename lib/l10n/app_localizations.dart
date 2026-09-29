import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_th.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('th'),
  ];

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get commonSave;

  /// No description provided for @commonDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get commonDelete;

  /// No description provided for @commonSomethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get commonSomethingWentWrong;

  /// No description provided for @navBackToSwitcher.
  ///
  /// In en, this message translates to:
  /// **'Back to Jung Studio'**
  String get navBackToSwitcher;

  /// No description provided for @navOverview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get navOverview;

  /// No description provided for @navTransactions.
  ///
  /// In en, this message translates to:
  /// **'Transactions'**
  String get navTransactions;

  /// No description provided for @navBudgets.
  ///
  /// In en, this message translates to:
  /// **'Budgets'**
  String get navBudgets;

  /// No description provided for @navAccounts.
  ///
  /// In en, this message translates to:
  /// **'Accounts'**
  String get navAccounts;

  /// No description provided for @overviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overviewTitle;

  /// No description provided for @overviewIncome.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get overviewIncome;

  /// No description provided for @overviewExpense.
  ///
  /// In en, this message translates to:
  /// **'Expense'**
  String get overviewExpense;

  /// No description provided for @overviewSaved.
  ///
  /// In en, this message translates to:
  /// **'Saved so far'**
  String get overviewSaved;

  /// No description provided for @overviewSafeToSpend.
  ///
  /// In en, this message translates to:
  /// **'Safe to spend / day'**
  String get overviewSafeToSpend;

  /// No description provided for @overviewBudgetSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'This month\'s budget'**
  String get overviewBudgetSectionTitle;

  /// No description provided for @overviewNoBudgets.
  ///
  /// In en, this message translates to:
  /// **'No budgets set for this month yet'**
  String get overviewNoBudgets;

  /// No description provided for @overviewDaysLeft.
  ///
  /// In en, this message translates to:
  /// **'{count} days left'**
  String overviewDaysLeft(int count);

  /// No description provided for @transactionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Transactions'**
  String get transactionsTitle;

  /// No description provided for @transactionsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No transactions yet'**
  String get transactionsEmptyTitle;

  /// No description provided for @transactionsEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Log your first income or expense to get started.'**
  String get transactionsEmptyBody;

  /// No description provided for @transactionsLoadError.
  ///
  /// In en, this message translates to:
  /// **'Failed to load transactions'**
  String get transactionsLoadError;

  /// No description provided for @transactionFormAddTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Transaction'**
  String get transactionFormAddTitle;

  /// No description provided for @transactionFormEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Transaction'**
  String get transactionFormEditTitle;

  /// No description provided for @transactionFormAmountLabel.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get transactionFormAmountLabel;

  /// No description provided for @transactionFormAmountRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter an amount'**
  String get transactionFormAmountRequired;

  /// No description provided for @transactionFormIncome.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get transactionFormIncome;

  /// No description provided for @transactionFormExpense.
  ///
  /// In en, this message translates to:
  /// **'Expense'**
  String get transactionFormExpense;

  /// No description provided for @transactionFormCategoryLabel.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get transactionFormCategoryLabel;

  /// No description provided for @transactionFormCategoryRequired.
  ///
  /// In en, this message translates to:
  /// **'Choose a category'**
  String get transactionFormCategoryRequired;

  /// No description provided for @transactionFormAccountLabel.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get transactionFormAccountLabel;

  /// No description provided for @transactionFormAccountRequired.
  ///
  /// In en, this message translates to:
  /// **'Choose an account'**
  String get transactionFormAccountRequired;

  /// No description provided for @transactionFormDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get transactionFormDateLabel;

  /// No description provided for @transactionFormNoteLabel.
  ///
  /// In en, this message translates to:
  /// **'Note (optional)'**
  String get transactionFormNoteLabel;

  /// No description provided for @transactionFormSaveButton.
  ///
  /// In en, this message translates to:
  /// **'Save Transaction'**
  String get transactionFormSaveButton;

  /// No description provided for @transactionFormDeleteButton.
  ///
  /// In en, this message translates to:
  /// **'Delete Transaction'**
  String get transactionFormDeleteButton;

  /// No description provided for @transactionFormNewCategory.
  ///
  /// In en, this message translates to:
  /// **'+ New category'**
  String get transactionFormNewCategory;

  /// No description provided for @transactionFormNewCategoryTitle.
  ///
  /// In en, this message translates to:
  /// **'New Category'**
  String get transactionFormNewCategoryTitle;

  /// No description provided for @transactionFormNewCategoryNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Category Name'**
  String get transactionFormNewCategoryNameLabel;

  /// No description provided for @transactionFormNewCategoryNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get transactionFormNewCategoryNameRequired;

  /// No description provided for @transactionFormNoAccountsYet.
  ///
  /// In en, this message translates to:
  /// **'Add an account first'**
  String get transactionFormNoAccountsYet;

  /// No description provided for @budgetsTitle.
  ///
  /// In en, this message translates to:
  /// **'Budgets'**
  String get budgetsTitle;

  /// No description provided for @budgetsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Set how much you plan to spend in each category this month.'**
  String get budgetsSubtitle;

  /// No description provided for @budgetsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No expense categories yet'**
  String get budgetsEmptyTitle;

  /// No description provided for @budgetsEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Add an expense category from the transaction form, then set its budget here.'**
  String get budgetsEmptyBody;

  /// No description provided for @budgetsAmountLabel.
  ///
  /// In en, this message translates to:
  /// **'Monthly budget'**
  String get budgetsAmountLabel;

  /// No description provided for @accountsTitle.
  ///
  /// In en, this message translates to:
  /// **'Accounts'**
  String get accountsTitle;

  /// No description provided for @accountsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No accounts yet'**
  String get accountsEmptyTitle;

  /// No description provided for @accountsEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Add a cash, bank, or e-wallet account to start logging transactions.'**
  String get accountsEmptyBody;

  /// No description provided for @accountsAddButton.
  ///
  /// In en, this message translates to:
  /// **'Add Account'**
  String get accountsAddButton;

  /// No description provided for @accountFormTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Account'**
  String get accountFormTitle;

  /// No description provided for @accountFormNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Account Name'**
  String get accountFormNameLabel;

  /// No description provided for @accountFormNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get accountFormNameRequired;

  /// No description provided for @accountFormTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get accountFormTypeLabel;

  /// No description provided for @accountTypeCash.
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get accountTypeCash;

  /// No description provided for @accountTypeBank.
  ///
  /// In en, this message translates to:
  /// **'Bank'**
  String get accountTypeBank;

  /// No description provided for @accountTypeEWallet.
  ///
  /// In en, this message translates to:
  /// **'E-Wallet'**
  String get accountTypeEWallet;

  /// No description provided for @accountTypeOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get accountTypeOther;

  /// No description provided for @accountFormSaveButton.
  ///
  /// In en, this message translates to:
  /// **'Add Account'**
  String get accountFormSaveButton;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'th'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'th':
      return AppLocalizationsTh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
