/// Route path constants for the Ruay Jung mini-app, namespaced under
/// `/ruay-jung` so they can't collide with another mini-app's routes.
class AppRoutes {
  const AppRoutes._();

  static const String overview = '/ruay-jung/overview';
  static const String transactions = '/ruay-jung/transactions';
  static const String budgets = '/ruay-jung/budgets';
  static const String accounts = '/ruay-jung/accounts';

  static const String transactionNew = '/ruay-jung/transactions/new';
  static const String transactionEditPath = '/ruay-jung/transactions/:id/edit';
  static String transactionEdit(String id) => '/ruay-jung/transactions/$id/edit';
}
