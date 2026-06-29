import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../constants/app_dimens.dart';
import '../../theme/theme.dart';

class AppAmountInput extends StatelessWidget {
  final TextEditingController controller;
  final String currencySymbol;
  final void Function(String)? onChanged;
  final bool isExpense;

  const AppAmountInput({
    super.key,
    required this.controller,
    this.currencySymbol = '฿',
    this.onChanged,
    this.isExpense = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Amount',
          style: AppTextStyles.labelM.copyWith(color: AppPalette.textSecondary),
        ),
        const SizedBox(height: AppDimens.spacingS),
        IntrinsicWidth(
          child: TextFormField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            textAlign: TextAlign.center,
            onChanged: onChanged,
            style: AppTextStyles.h1.copyWith(
              fontSize: 48,
              color: isExpense ? AppPalette.error : AppPalette.success,
            ),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
            ],
            decoration: InputDecoration(
              prefixText: '$currencySymbol ',
              prefixStyle: AppTextStyles.h2.copyWith(
                color: isExpense ? AppPalette.error : AppPalette.success,
              ),
              border: InputBorder.none,
              hintText: '0.00',
              hintStyle: AppTextStyles.h1.copyWith(
                fontSize: 48,
                color: AppPalette.textDisabled.withOpacity(0.3),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
