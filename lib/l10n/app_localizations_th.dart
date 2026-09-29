// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class AppLocalizationsTh extends AppLocalizations {
  AppLocalizationsTh([String locale = 'th']) : super(locale);

  @override
  String get commonCancel => 'ยกเลิก';

  @override
  String get commonSave => 'บันทึก';

  @override
  String get commonDelete => 'ลบ';

  @override
  String get commonSomethingWentWrong => 'เกิดข้อผิดพลาด';

  @override
  String get navBackToSwitcher => 'กลับไป Jung Studio';

  @override
  String get navOverview => 'ภาพรวม';

  @override
  String get navTransactions => 'รายการ';

  @override
  String get navBudgets => 'งบประมาณ';

  @override
  String get navAccounts => 'บัญชี';

  @override
  String get overviewTitle => 'ภาพรวม';

  @override
  String get overviewIncome => 'รายรับ';

  @override
  String get overviewExpense => 'รายจ่าย';

  @override
  String get overviewSaved => 'เก็บได้แล้ว';

  @override
  String get overviewSafeToSpend => 'ใช้ได้ต่อวัน';

  @override
  String get overviewBudgetSectionTitle => 'งบประมาณเดือนนี้';

  @override
  String get overviewNoBudgets => 'ยังไม่ได้ตั้งงบประมาณเดือนนี้';

  @override
  String overviewDaysLeft(int count) {
    return 'เหลืออีก $count วัน';
  }

  @override
  String get transactionsTitle => 'รายการ';

  @override
  String get transactionsEmptyTitle => 'ยังไม่มีรายการ';

  @override
  String get transactionsEmptyBody => 'เริ่มบันทึกรายรับหรือรายจ่ายแรกของคุณ';

  @override
  String get transactionsLoadError => 'โหลดรายการไม่สำเร็จ';

  @override
  String get transactionFormAddTitle => 'เพิ่มรายการ';

  @override
  String get transactionFormEditTitle => 'แก้ไขรายการ';

  @override
  String get transactionFormAmountLabel => 'จำนวนเงิน';

  @override
  String get transactionFormAmountRequired => 'กรุณากรอกจำนวนเงิน';

  @override
  String get transactionFormIncome => 'รายรับ';

  @override
  String get transactionFormExpense => 'รายจ่าย';

  @override
  String get transactionFormCategoryLabel => 'หมวดหมู่';

  @override
  String get transactionFormCategoryRequired => 'กรุณาเลือกหมวดหมู่';

  @override
  String get transactionFormAccountLabel => 'บัญชี';

  @override
  String get transactionFormAccountRequired => 'กรุณาเลือกบัญชี';

  @override
  String get transactionFormDateLabel => 'วันที่';

  @override
  String get transactionFormNoteLabel => 'โน้ต (ไม่บังคับ)';

  @override
  String get transactionFormSaveButton => 'บันทึกรายการ';

  @override
  String get transactionFormDeleteButton => 'ลบรายการ';

  @override
  String get transactionFormNewCategory => '+ หมวดหมู่ใหม่';

  @override
  String get transactionFormNewCategoryTitle => 'หมวดหมู่ใหม่';

  @override
  String get transactionFormNewCategoryNameLabel => 'ชื่อหมวดหมู่';

  @override
  String get transactionFormNewCategoryNameRequired => 'กรุณากรอกชื่อหมวดหมู่';

  @override
  String get transactionFormNoAccountsYet => 'กรุณาเพิ่มบัญชีก่อน';

  @override
  String get budgetsTitle => 'งบประมาณ';

  @override
  String get budgetsSubtitle => 'ตั้งงบที่วางแผนจะใช้ในแต่ละหมวดหมู่เดือนนี้';

  @override
  String get budgetsEmptyTitle => 'ยังไม่มีหมวดหมู่รายจ่าย';

  @override
  String get budgetsEmptyBody =>
      'เพิ่มหมวดหมู่รายจ่ายจากฟอร์มรายการ แล้วค่อยตั้งงบที่นี่';

  @override
  String get budgetsAmountLabel => 'งบประมาณต่อเดือน';

  @override
  String get accountsTitle => 'บัญชี';

  @override
  String get accountsEmptyTitle => 'ยังไม่มีบัญชี';

  @override
  String get accountsEmptyBody =>
      'เพิ่มบัญชีเงินสด ธนาคาร หรือ e-wallet เพื่อเริ่มบันทึกรายการ';

  @override
  String get accountsAddButton => 'เพิ่มบัญชี';

  @override
  String get accountFormTitle => 'เพิ่มบัญชี';

  @override
  String get accountFormNameLabel => 'ชื่อบัญชี';

  @override
  String get accountFormNameRequired => 'กรุณากรอกชื่อบัญชี';

  @override
  String get accountFormTypeLabel => 'ประเภท';

  @override
  String get accountTypeCash => 'เงินสด';

  @override
  String get accountTypeBank => 'ธนาคาร';

  @override
  String get accountTypeEWallet => 'E-Wallet';

  @override
  String get accountTypeOther => 'อื่นๆ';

  @override
  String get accountFormSaveButton => 'เพิ่มบัญชี';
}
