import '../../listings/screens/listing_details_screen.dart';
import '../../../core/widgets/loading_skeleton.dart';
import '../../../core/widgets/motion_feedback.dart';
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
/// FavoritesScreen - the heart-tab. Shows only listings the user marked,
/// matching the Figma "Favorite Page" grid.
/// ---------------------------------------------------------------------------
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = context.read<AuthProvider>().uid ?? '';
    final listings = context.read<ListingsProvider>();
    final profile = context.read<ProfileProvider>();

    return EntranceScope(
      child: SafeArea(
        child: StreamBuilder<Set<String>>(
          stream: profile.watchFavoriteIds(uid),
          builder: (context, favSnap) {
            if (favSnap.hasError) {
              return const EmptyState(
                icon: Icons.wifi_off_rounded,
                title: 'تعذّر تحميل المفضلة',
                body: 'راجع اتصالك وافتح الصفحة من جديد.',
              );
            }
            if (favSnap.connectionState == ConnectionState.waiting &&
                !favSnap.hasData) {
              return const LoadingSkeleton(grid: true);
            }

            final favIds = favSnap.data ?? {};
            return StreamBuilder<List<Listing>>(
              stream: listings.watchAvailable(),
              builder: (context, snap) {
                if (snap.hasError) {
                  return const EmptyState(
                    icon: Icons.wifi_off_rounded,
                    title: 'تعذّر تحميل المفضلة',
                    body: 'راجع اتصالك وافتح الصفحة من جديد.',
                  );
                }
                if (snap.connectionState == ConnectionState.waiting &&
                    !snap.hasData) {
                  return const LoadingSkeleton(grid: true);
                }

                final items = (snap.data ?? [])
                    .where((l) => favIds.contains(l.id))
                    .toList();
                if (items.isEmpty) {
                  return const EmptyState(
                    icon: Icons.favorite_border,
                    title: AppStrings.emptyFavorites,
                  );
                }
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
                    return EntranceItem(
                      key: ValueKey(l.id),
                      id: l.id,
                      index: i,
                      child: ListingCard(
                        listing: l,
                        heroTag: 'favorites_screen-${l.id}-$i',
                        isFavorite: true,
                        onFavoriteTap: () =>
                            profile.toggleFavorite(uid, l.id, true),
                        onTap: () => Navigator.pushNamed(
                          context,
                          AppRoutes.listingDetails,
                          arguments: ListingDetailsArgs(
                            l,
                            heroTag: 'favorites_screen-${l.id}-$i',
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
