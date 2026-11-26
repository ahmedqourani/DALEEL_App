import 'package:flutter/material.dart';

import '../../../core/constants/app_routes.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_container.dart';

/// ---------------------------------------------------------------------------
/// CategoriesScreen - "Shop by category" list, matching the Figma frame:
/// frosted-glass rounded rows with an icon and the category name.
/// ---------------------------------------------------------------------------
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  // One icon per category (same order as AppStrings.categoryList).
  static const _icons = [
    Icons.menu_book_outlined,
    Icons.edit_note,
    Icons.handyman_outlined,
    Icons.palette_outlined,
    Icons.laptop_outlined,
    Icons.fitness_center,
    Icons.more_horiz,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.categories)),
      body: ListView.separated(
        padding: const EdgeInsets.all(AppSizes.pagePadding),
        itemCount: AppStrings.categoryList.length,
        separatorBuilder: (_, _) => const SizedBox(height: AppSizes.sm),
        itemBuilder: (_, i) {
          final c = AppStrings.categoryList[i];
          return GlassContainer(
            radius: AppSizes.radiusCard,
            opacity: 0.5,
            child: ListTile(
              onTap: () => Navigator.pushNamed(
                context,
                AppRoutes.categoryListings,
                arguments: c,
              ),
              leading: CircleAvatar(
                backgroundColor: AppColors.primaryLight,
                child: Icon(
                  _icons[i % _icons.length],
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
              title: Text(c),
              trailing: Icon(
                Icons.chevron_right,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          );
        },
      ),
    );
  }
}
