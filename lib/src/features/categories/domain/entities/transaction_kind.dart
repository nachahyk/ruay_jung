/// Shared between categories, transactions, and budgets — a category is
/// tagged income or expense, a transaction is one or the other, and a
/// budget only ever applies to an expense category.
enum TransactionKind { income, expense }
