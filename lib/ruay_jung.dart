/// Ruay Jung: the personal-finance mini-app.
///
/// Same feature-first Clean Architecture as AimJung/Tiaw Jung internally
/// (accounts, categories, transactions, budgets — each with data/domain/
/// presentation layers and its own Cubits). Until the shell builds this
/// lazily via `AppModule.initialize` (still Phase 7 work, same as the
/// other two mini-apps), `apps/jung_studio` constructs this mini-app's
/// repositories/cubits eagerly itself, which is why this barrel exports
/// those concrete types directly instead of hiding them behind the module.
library;

export 'src/ruay_jung_module.dart';
export 'src/routes/app_routes.dart';
export 'src/theme/app_theme.dart';
export 'src/theme/app_colors.dart';

export 'src/features/accounts/data/datasources/account_remote_data_source.dart';
export 'src/features/accounts/data/repositories/account_repository_impl.dart';
export 'src/features/accounts/domain/repositories/account_repository.dart';
export 'src/features/accounts/presentation/controllers/accounts_cubit.dart';

export 'src/features/categories/data/datasources/category_remote_data_source.dart';
export 'src/features/categories/data/repositories/category_repository_impl.dart';
export 'src/features/categories/domain/repositories/category_repository.dart';
export 'src/features/categories/presentation/controllers/categories_cubit.dart';

export 'src/features/transactions/data/datasources/transaction_remote_data_source.dart';
export 'src/features/transactions/data/repositories/transaction_repository_impl.dart';
export 'src/features/transactions/domain/repositories/transaction_repository.dart';
export 'src/features/transactions/presentation/controllers/transactions_cubit.dart';

export 'src/features/budgets/data/datasources/budget_remote_data_source.dart';
export 'src/features/budgets/data/repositories/budget_repository_impl.dart';
export 'src/features/budgets/domain/repositories/budget_repository.dart';
export 'src/features/budgets/presentation/controllers/budgets_cubit.dart';
