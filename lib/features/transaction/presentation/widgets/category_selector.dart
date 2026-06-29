import 'package:flutter/material.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/theme/theme.dart';
import '../../domain/entities/category_entity.dart';

class CategorySelector extends StatelessWidget {
  final List<CategoryEntity> categories;
  final CategoryEntity? selectedCategory;
  final Function(CategoryEntity) onCategorySelected;

  const CategorySelector({
    super.key,
    required this.categories,
    this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category',
          style: AppTextStyles.labelM.copyWith(color: AppPalette.textSecondary),
        ),
        const SizedBox(height: AppDimens.spacingS),
        SizedBox(
          height: 100,
          child: categories.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: AppDimens.spacingM),
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final isSelected = selectedCategory?.id == category.id;

                    return GestureDetector(
                      onTap: () => onCategorySelected(category),
                      child: Column(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: isSelected 
                                  ? AppPalette.primary.withOpacity(0.1) 
                                  : (Theme.of(context).brightness == Brightness.light 
                                      ? AppPalette.natural.shade100 
                                      : AppPalette.surfaceDark),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected ? AppPalette.primary : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: Icon(
                              _getIcon(category.icon),
                              color: isSelected ? AppPalette.primary : AppPalette.textSecondary,
                            ),
                          ),
                          const SizedBox(height: AppDimens.spacingS),
                          Text(
                            category.name,
                            style: AppTextStyles.labelS.copyWith(
                              color: isSelected ? AppPalette.primary : AppPalette.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  IconData _getIcon(String? iconName) {
    // In a real app, map iconName string to IconData
    switch (iconName) {
      case 'food': return Icons.restaurant;
      case 'shopping': return Icons.shopping_bag;
      case 'transport': return Icons.directions_car;
      default: return Icons.category;
    }
  }
}
