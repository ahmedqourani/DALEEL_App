import '../../listings/screens/listing_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_routes.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/listing_card.dart';
import '../../../core/widgets/section_header.dart';
import '../../../models/listing.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/listings_provider.dart';
import '../../../providers/misc_providers.dart';

/// ---------------------------------------------------------------------------
/// CategoryListingsScreen - 2-column grid of listings in one category.
/// Opened with the category name as a route argument.
/// ---------------------------------------------------------------------------
class CategoryListingsScreen extends StatelessWidget {
  const CategoryListingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)!.settings.arguments as String;
    final uid = context.read<AuthProvider>().uid ?? '';
    final listings = context.read<ListingsProvider>();
    final profile = context.read<ProfileProvider>();

    return Scaffold(
      appBar: AppBar(title: Text(category)),
      body: StreamBuilder<List<Listing>>(
        stream: listings.watchByCategory(category),
        builder: (context, snap) {
          if (snap.hasError) {
            return const EmptyState(
              icon: Icons.wifi_off_rounded,
              title: 'تعذّر تحميل البيانات',
              body: 'راجع اتصالك وافتح الصفحة من جديد.',
            );
          }
          final items = snap.data ?? [];
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (items.isEmpty) {
            return const EmptyState(
              icon: Icons.inventory_2_outlined,
              title: AppStrings.emptyListings,
            );
          }
          return StreamBuilder<Set<String>>(
            stream: profile.watchFavoriteIds(uid),
            builder: (context, favSnap) {
              final favs = favSnap.data ?? {};
              return GridView.builder(
                padding: const EdgeInsets.all(AppSizes.pagePadding),
                itemCount: items.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: AppSizes.sm,
                  crossAxisSpacing: AppSizes.sm,
                  childAspectRatio: 0.68,
                ),
                itemBuilder: (_, i) {
                  final l = items[i];
                  return ListingCard(
                    listing: l,
                    heroTag: 'category_listings_screen-${l.id}-$i',
                    isFavorite: favs.contains(l.id),
                    onFavoriteTap: () =>
                        profile.toggleFavorite(uid, l.id, favs.contains(l.id)),
                    onTap: () => Navigator.pushNamed(
                      context,
                      AppRoutes.listingDetails,
                      arguments: ListingDetailsArgs(
                        l,
                        heroTag: 'category_listings_screen-${l.id}-$i',
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
