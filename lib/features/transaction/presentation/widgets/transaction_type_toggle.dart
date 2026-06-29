import 'package:flutter/material.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/theme/theme.dart';

class TransactionTypeToggle extends StatelessWidget {
  final String selectedType;
  final Function(String) onTypeChanged;

  const TransactionTypeToggle({
    super.key,
    required this.selectedType,
    required this.onTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.spacingXS),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light 
            ? AppPalette.natural.shade100 
            : AppPalette.surfaceDark,
        borderRadius: BorderRadius.circular(AppDimens.radiusL),
      ),
      child: Row(
        children: [
          _ToggleItem(
            label: 'Expense',
            isSelected: selectedType == 'expense',
            onTap: () => onTypeChanged('expense'),
            activeColor: AppPalette.error,
          ),
          _ToggleItem(
            label: 'Income',
            isSelected: selectedType == 'income',
            onTap: () => onTypeChanged('income'),
            activeColor: AppPalette.success,
          ),
        ],
      ),
    );
  }
}

class _ToggleItem extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final Color activeColor;

  const _ToggleItem({
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: AppDimens.spacingM),
          decoration: BoxDecoration(
            color: isSelected ? activeColor : Colors.transparent,
            borderRadius: BorderRadius.circular(AppDimens.radiusM),
            boxShadow: isSelected 
                ? [BoxShadow(color: activeColor.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4))]
                : null,
          ),
          child: Center(
            child: Text(
              label,
              style: AppTextStyles.labelM.copyWith(
                color: isSelected ? Colors.white : AppPalette.textSecondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
