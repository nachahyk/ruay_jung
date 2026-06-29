import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../constants/app_dimens.dart';
import '../../theme/theme.dart';

class AppDatePickerField extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;
  final String label;

  const AppDatePickerField({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
    this.label = 'Date',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.labelM.copyWith(color: AppPalette.textSecondary),
        ),
        const SizedBox(height: AppDimens.spacingS),
        InkWell(
          onTap: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: selectedDate,
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.light(
                      primary: AppPalette.primary,
                      onPrimary: Colors.white,
                      onSurface: AppPalette.textPrimary,
                    ),
                  ),
                  child: child!,
                );
              },
            );
            if (picked != null && picked != selectedDate) {
              onDateSelected(picked);
            }
          },
          child: Container(
            padding: const EdgeInsets.all(AppDimens.spacingM),
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.light 
                  ? AppPalette.natural.shade100 
                  : AppPalette.surfaceDark,
              borderRadius: BorderRadius.circular(AppDimens.radiusM),
            ),
            child: Row(
              children: [
                const Icon(Icons.calendar_today_outlined, color: AppPalette.textSecondary, size: 20),
                const SizedBox(width: AppDimens.spacingM),
                Text(
                  DateFormat('EEEE, d MMM yyyy').format(selectedDate),
                  style: AppTextStyles.bodyM,
                ),
                const Spacer(),
                const Icon(Icons.arrow_forward_ios, color: AppPalette.textDisabled, size: 14),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
