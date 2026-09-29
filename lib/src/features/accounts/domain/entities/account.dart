enum AccountType { cash, bank, eWallet, other }

/// A place money lives — cash on hand, a bank account, an e-wallet. Its
/// balance isn't stored; it's the sum of every transaction against it,
/// computed client-side by whoever already has the transaction list loaded.
class Account {
  const Account({required this.id, required this.name, required this.type});

  final String id;
  final String name;
  final AccountType type;
}
