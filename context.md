# Project Context: Ruay Jung

Always read this file before modifying any code.

---

## Project Overview

**Ruay Jung** is a Flutter personal finance app for tracking income and expenses. It connects to a Supabase backend and supports light/dark themes.

---

## Architecture

Clean Architecture with three layers per feature:

```
Domain  ←  Application boundary (entities, repositories, use cases)
Data    ←  Implements domain contracts (models, remote data sources, repo impls)
Presentation ← UI (BLoC, pages, feature-specific widgets)
```

Data flows:
```
UI → BLoC Event → Use Case → Repository (abstract) → RepositoryImpl → RemoteDataSource → Supabase
                                                                    ↓
UI ← BLoC State ← Either<Failure, T> ←─────────────────────────────┘
```

---

## Folder Structure

```
lib/
├── main.dart                      # App entry point; wraps app in MultiBlocProvider
├── injection.dart                 # GetIt setup; @InjectableInit
├── injection.config.dart          # GENERATED — do not edit manually
├── navigation/
│   ├── app_router.dart            # GoRouter config + GoRouterRefreshStream
│   └── main_shell.dart            # Bottom nav shell (StatefulShellRoute)
├── core/
│   ├── core.dart                  # Barrel: extensions, theme, widgets
│   ├── config/
│   │   └── supabase_config.dart   # Supabase init + client accessor
│   ├── constants/
│   │   └── app_dimens.dart        # All spacing, radius, icon size, button height constants
│   ├── error/
│   │   └── failures.dart          # Failure base class + ServerFailure, AuthFailure
│   ├── extension/
│   │   ├── extensions.dart        # Barrel
│   │   └── build_context_extension.dart  # context.theme, context.colorScheme, context.appColors
│   ├── services/
│   │   └── local_storage_service.dart  # SharedPreferences wrapper (@lazySingleton)
│   ├── theme/
│   │   ├── theme.dart             # Barrel
│   │   ├── app_palette.dart       # All raw colors (MaterialColor primary, neutral scale, status, chart)
│   │   ├── app_color.dart         # AppColors ThemeExtension (background, primaryText, errorText)
│   │   ├── app_theme.dart         # AppTheme.light / AppTheme.dark ThemeData
│   │   └── app_text_styles.dart   # AppTextStyles constants (h1–h3, bodyL/M/S, labelL/M/S)
│   └── widgets/
│       ├── widgets.dart           # Barrel: base, layout, common widgets
│       ├── base/
│       │   ├── base.dart          # Barrel
│       │   ├── calendar.dart      # Calendar widget (TableCalendar wrapper)
│       │   └── circle_fab.dart    # CircleFab (circular FAB with InkWell)
│       ├── layout/
│       │   ├── layout.dart        # Barrel
│       │   └── app_scaffold.dart  # AppScaffold (standard scaffold wrapper)
│       └── common/
│           ├── app_button.dart        # AppButton (primary/secondary, loading state)
│           ├── app_text_field.dart    # AppTextField (label + TextFormField)
│           ├── app_amount_input.dart  # AppAmountInput (large currency input)
│           └── app_date_picker_field.dart  # AppDatePickerField (date picker trigger)
└── features/
    ├── splash/presentation/pages/splash_page.dart
    ├── auth/
    │   ├── data/datasources/auth_remote_data_source.dart
    │   ├── data/repositories/auth_repository_impl.dart
    │   ├── domain/entities/user_entity.dart
    │   ├── domain/repositories/auth_repository.dart
    │   ├── domain/usecases/{get_current_user, sign_in_with_email_password, sign_out, sign_up_with_email_password}.dart
    │   └── presentation/bloc/auth_{bloc,event,state}.dart
    │       pages/{login_page,signup_page}.dart
    ├── home/home_page.dart
    ├── profile/
    │   ├── data/datasources/profile_remote_data_source.dart
    │   ├── data/models/profile_model.dart  (freezed + json_serializable)
    │   ├── data/repositories/profile_repository_impl.dart
    │   ├── domain/entities/profile_entity.dart
    │   ├── domain/repositories/profile_repository.dart
    │   ├── domain/usecases/get_profile.dart
    │   └── presentation/bloc/profile_{bloc,event,state}.dart
    │       profile_page.dart
    └── transaction/
        ├── data/datasources/transaction_remote_data_source.dart
        ├── data/models/{category_model, transaction_model}.dart  (freezed + json_serializable)
        ├── data/repositories/transaction_repository_impl.dart
        ├── domain/entities/{category_entity, transaction_entity}.dart
        ├── domain/repositories/transaction_repository.dart
        ├── domain/usecases/{add_transaction, get_categories}.dart
        └── presentation/
            ├── bloc/add_transaction_{bloc,event,state}.dart
            ├── bloc/transaction_{bloc,event,state}.dart
            ├── pages/{add_transaction_page, transaction_page}.dart
            └── widgets/{category_selector, transaction_type_toggle}.dart
```

---

## State Management

**flutter_bloc** (BLoC pattern).

### BLoC Conventions

- Events use `sealed class` extending `Equatable` (auth) or `abstract class` extending `Equatable` (others).
- States use `sealed class` or plain class extending `Equatable`.
- Files split via `part`/`part of`: `_bloc.dart` contains the class; `_event.dart` and `_state.dart` are parts.
- State classes override `props` from `Equatable` for value equality.
- For form-like screens, use `AddTransactionState` with a `copyWith` method and a status enum instead of multiple state subclasses.
- For simple fetch flows, use separate state subclasses (`Loading`, `Loaded`, `Error`).
- Use `BlocSelector` to rebuild only when a specific field changes; use `buildWhen` for finer control.
- Use `BlocConsumer` when you need both listener (side effects) and builder (UI).
- Use `BlocListener` for one-off side effects (navigation, snackbars).

### Scope

- `AuthBloc` is a **lazySingleton** provided globally in `main.dart` via `MultiBlocProvider`.
- Feature BLoCs (`ProfileBloc`, `AddTransactionBloc`, `TransactionBloc`) are **factory**-scoped; provide them locally with `BlocProvider` at the page level.

---

## Dependency Injection

**get_it** + **injectable** (code generation).

| Annotation | Used for |
|---|---|
| `@lazySingleton` | `LocalStorageService`, `SupabaseClient`, `AuthBloc` |
| `@injectable` (factory) | Use cases, repositories, data sources, feature BLoCs |
| `@Injectable(as: Interface)` | Binds implementation to abstract interface |
| `@module` + `@preResolve` | Registers async dependencies (`SharedPreferences`) |

After adding/changing injectable classes, regenerate:
```
dart run build_runner build --delete-conflicting-outputs
```

Access the container via `serviceLocator<T>()` (defined in `injection.dart`).

---

## Navigation

**go_router** with a `StatefulShellRoute.indexedStack` for the bottom nav shell.

### Routes

| Path | Widget | Notes |
|---|---|---|
| `/` | `SplashPage` | First-launch onboarding |
| `/login` | `LoginPage` | Auth guard redirects here when unauthenticated |
| `/signup` | `SignUpPage` | |
| `/home` | `HomePage` | Inside `MainShell` (branch 0) |
| `/profile` | `ProfilePage` | Inside `MainShell` (branch 1) |
| `/add-transaction` | `AddTransactionPage` | Pushed modally via `context.push` |

### Auth Redirect Logic (in `app_router.dart`)

1. First launch (`isFirstTime == true`) → stay on `/` (splash).
2. Auth state is `AuthInitial` or `AuthLoading` → no redirect (handled by state emission).
3. `AuthAuthenticated` → redirect to `/home` if on splash/login/signup.
4. `AuthUnauthenticated` / `AuthFailureState` → redirect to `/login`.

Router refreshes on every `AuthBloc` state change via `GoRouterRefreshStream`.

### Navigation Helpers

- `context.go('/path')` — replace stack (use for auth flows).
- `context.push('/path')` — push onto stack (use for modal pages).
- `context.pop()` — pop current route.
- `context.canPop()` — check before popping.

---

## Dependency Graph (simplified)

```
SupabaseClient ──► AuthRemoteDataSource ──► AuthRepositoryImpl ──► (UseCases) ──► AuthBloc
               ──► ProfileRemoteDataSource ──► ProfileRepositoryImpl ──► GetProfile ──► ProfileBloc
               ──► TransactionRemoteDataSource ──► TransactionRepositoryImpl ──► {AddTransaction, GetCategories} ──► {AddTransactionBloc, TransactionBloc}
SharedPreferences ──► LocalStorageService
```

---

## Data Models

Data layer models use **freezed** + **json_serializable**:

```dart
@freezed
abstract class CategoryModel with _$CategoryModel {
  const CategoryModel._();  // required for custom methods
  const factory CategoryModel({...}) = _CategoryModel;
  factory CategoryModel.fromJson(Map<String, dynamic> json) => _$CategoryModelFromJson(json);

  CategoryEntity toEntity() => ...;
  factory CategoryModel.fromEntity(CategoryEntity entity) => ...;
}
```

Run codegen after changing models:
```
dart run build_runner build --delete-conflicting-outputs
```

Generated files (`*.freezed.dart`, `*.g.dart`) are committed. Do not edit them.

---

## Error Handling

- All use cases and repository methods return `Either<Failure, T>` from `fpdart`.
- Call `.fold(onLeft, onRight)` to handle both outcomes.
- `Failure` subclasses: `ServerFailure`, `AuthFailure`.
- Data sources throw typed failures (`AuthFailure`); repositories catch and convert to `left(failure)`.
- BLoC emits a failure state on `left`; never swallows exceptions silently.
- UI shows errors via `SnackBar` or state-driven error widgets.

---

## Theme & Styling

### Color System

- `AppPalette` — raw color constants and `MaterialColor` swatches. Never inline hex colors; use palette values.
- `AppColors` — `ThemeExtension` registered in `ThemeData`. Access via `context.appColors.background` etc.
- `context.colorScheme` — standard Material color scheme.
- `context.theme` — full `ThemeData`.

### Text Styles

Use `AppTextStyles` constants, then `.copyWith(color: ...)` to apply contextual colors:

```dart
AppTextStyles.labelM.copyWith(color: AppPalette.textSecondary)
```

Scale: `h1` (32), `h2` (24), `h3` (20), `bodyL` (18), `bodyM` (16), `bodyS` (14), `labelL` (16 w600), `labelM` (14 w600), `labelS` (12 w600).

### Dimensions

All spacing, radius, icon sizes, button heights are in `AppDimens`. Never hardcode numeric values:

| Constant | Value |
|---|---|
| `spacingXS` | 4 |
| `spacingS` | 8 |
| `spacingM` | 16 |
| `spacingL` | 24 |
| `spacingXL` | 32 |
| `spacingXXL` | 40 |
| `radiusS/M/L/XL/XXL` | 8/12/16/24/32 |
| `buttonHeight` | 56 |
| `paddingPage` | 16 |

### Dark Mode

Check brightness with `Theme.of(context).brightness == Brightness.light` to switch between light/dark surface colors.

---

## Reusable Widgets

| Widget | Location | Purpose |
|---|---|---|
| `AppScaffold` | `core/widgets/layout/` | Standard scaffold with optional title, back button, safe area control |
| `AppButton` | `core/widgets/common/` | Primary/secondary button with loading state, full-width by default |
| `AppTextField` | `core/widgets/common/` | Labeled `TextFormField` with consistent styling |
| `AppAmountInput` | `core/widgets/common/` | Large currency amount input (Thai Baht ฿ by default) |
| `AppDatePickerField` | `core/widgets/common/` | Tappable date field that opens `showDatePicker` |
| `CircleFab` | `core/widgets/base/` | Circular floating action button |
| `Calendar` | `core/widgets/base/` | `TableCalendar` wrapper |
| `TransactionTypeToggle` | `features/transaction/presentation/widgets/` | Expense/Income animated toggle |
| `CategorySelector` | `features/transaction/presentation/widgets/` | Horizontal scrollable category picker |

Always use these before creating new widgets.

---

## Feature-Specific Widgets

Feature widgets live under `features/<feature>/presentation/widgets/`. They may depend on domain entities but must not import from other features.

---

## Services

| Service | Scope | Purpose |
|---|---|---|
| `LocalStorageService` | lazySingleton | `isFirstTime()` / `setNotFirstTime()` via SharedPreferences |
| `SupabaseClient` | lazySingleton | Injected into all remote data sources |

---

## Coding Conventions

### Naming

- Files: `snake_case.dart`
- Classes: `PascalCase`
- Variables/methods: `camelCase`
- Constants: `camelCase` (inside `abstract final class` with `const` members)
- Private members: `_leadingUnderscore`
- BLoC files: `feature_bloc.dart`, `feature_event.dart`, `feature_state.dart`
- Use cases: named after the action (`AddTransaction`, `GetCategories`)
- Entities: `FeatureEntity` suffix
- Models: `FeatureModel` suffix (data layer)
- Pages: `FeaturePage` suffix; stateless wrapper provides BLoC, `FeatureView` is the actual widget

### Page Pattern

```dart
// Stateless wrapper provides the BLoC
class AddTransactionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<AddTransactionBloc>(),
      child: const AddTransactionView(),
    );
  }
}

// Stateful (or stateless) view contains the UI
class AddTransactionView extends StatefulWidget { ... }
```

### Use Case Pattern

```dart
@injectable
class GetCategories {
  final TransactionRepository repository;
  GetCategories(this.repository);

  Future<Either<Failure, List<CategoryEntity>>> call(String type) =>
      repository.getCategories(type);
}
```

Use cases implement `call()` so they can be invoked as functions.

### Repository Pattern

- Abstract interface in `domain/repositories/` — no imports from `data` layer.
- Implementation in `data/repositories/` — annotated `@Injectable(as: AbstractInterface)`.
- Maps between domain entities and data models.

### Imports

- Use package imports (`package:ruay_jung/...`) for cross-feature or cross-layer imports.
- Use relative imports within the same feature layer.

---

## Backend (Supabase)

- Auth: email/password via `_client.auth`.
- Database: `_client.from('table').insert/select`.
- RPC: `_client.rpc('function_name', params: {...})` (used for `get_categories`).
- User metadata stored in `auth.users.user_metadata` (`full_name`, `avatar_url`).
- Transactions table: `id`, `amount`, `type`, `date`, `category_id`, `note`, `user_id`, `created_at`.

---

## Common Pitfalls

1. **Don't edit generated files** (`injection.config.dart`, `*.freezed.dart`, `*.g.dart`).
2. **Run build_runner** after changing injectable annotations or freezed models.
3. **`AuthBloc` is a lazySingleton** — do not create a second instance via `BlocProvider`; read it with `context.read<AuthBloc>()`.
4. **Feature BLoCs are factory-scoped** — always provide them locally in the page widget.
5. **`MainShell`'s FAB navigates to `/add-transaction`** — that page must not use `MainShell`'s bottom nav.
6. **Hardcoded strings in pages** (e.g., `LoginPage`, `SplashPage`) — new code must not add more; extract to constants or localization.
7. **`AddTransactionState` cannot clear `category` via `copyWith`** — passing `null` falls back to `this.category`. Use a wrapper or a sentinel if you need to clear nullable fields.
8. **`TransactionTypeToggle` uses string literals `'expense'`/`'income'`** — treat these as the canonical type enum until a proper enum is introduced.

---

## Testing Strategy

No test files exist yet. When writing tests:

- Unit test use cases and BLoCs (mock repositories with `mockito` or manual fakes).
- Integration test repository implementations against a Supabase test instance.
- Do not mock `SharedPreferences`; prefer a real in-memory implementation.
- Widget tests should provide BLoC via `BlocProvider` with a stubbed BLoC.

---

## AI Working Rules

Always read `context.md` before modifying code.

### General Principles

- Write clean, readable, and maintainable code.
- Keep solutions simple.
- Prefer readability over cleverness.
- Follow SOLID principles where appropriate.
- Follow the existing project architecture.
- Keep functions and widgets focused on a single responsibility.
- Prefer composition over inheritance.
- Reuse existing code before creating new code.

### Modification Rules

- Make the smallest possible change.
- Do not refactor unrelated code.
- Keep pull requests small and easy to review.
- Preserve backward compatibility.
- Do not change public APIs unless required.
- Explain every modified file.

### Reusability

Before creating a Widget, Service, Repository, Extension, Helper, Constant, or Validator — search for an existing implementation first. Never duplicate logic.

### Code Style

- No hardcoded strings.
- No magic numbers.
- Extract constants where appropriate.
- Use localization for all user-facing text.
- Use theme values instead of inline styles.
- Prefer `const` constructors.
- Keep files organized.
- Remove dead code.
- Avoid deep widget nesting.
- Use meaningful names.
- Keep methods short and easy to understand.

### Performance

- Avoid unnecessary rebuilds — use `BlocSelector` and `buildWhen`.
- Reuse widgets.
- Avoid duplicate API calls.
- Keep state as local as possible.

### Error Handling

- Reuse existing error handling (`Failure` hierarchy, `Either`).
- Show user-friendly messages.
- Do not swallow exceptions silently.

### Before Every Change — Ask Yourself

1. Can I reuse existing code?
2. Can I modify fewer files?
3. Can I reduce the code diff?
4. Can I avoid introducing new abstractions?
5. Is the code easier to read after my change?
6. Is there any hardcoded value that should be extracted?
7. Does this follow the project's existing patterns?

If the answer to any question is "No", revise the implementation before proceeding.
