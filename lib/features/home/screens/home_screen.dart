import 'package:flutter/services.dart';
import '../../../core/widgets/theme_reveal.dart';
import '../../../core/widgets/dalil_tour.dart';
import '../../listings/screens/listing_details_screen.dart';
import '../../../core/widgets/loading_skeleton.dart';
import '../../../core/widgets/motion_feedback.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_routes.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_container.dart';
import '../../../core/widgets/dalil_logo.dart';
import '../../../core/widgets/listing_card.dart';
import '../../../core/widgets/section_header.dart';
import '../../../models/listing.dart';
import '../../../models/review.dart';
import '../../../models/chat.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/listings_provider.dart';
import '../../../providers/misc_providers.dart';
import '../../../providers/theme_provider.dart';

/// ---------------------------------------------------------------------------
/// HomeScreen - the landing tab: greeting, search bar, promo banner,
/// categories row and a "Recently added" grid. Matches the Figma Home frame.
/// ---------------------------------------------------------------------------
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // One icon per category (same order as AppStrings.categoryList).
  static const _categoryIcons = [
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
    final auth = context.watch<AuthProvider>();
    final listings = context.read<ListingsProvider>();
    final text = Theme.of(context).textTheme;
    final uid = auth.uid ?? '';

    return EntranceScope(
      child: SafeArea(
        child: StreamBuilder<List<Listing>>(
          stream: listings.watchAvailable(),
          builder: (context, snap) {
            final all = snap.data ?? [];
            return ListView(
              padding: const EdgeInsets.all(AppSizes.pagePadding),
              children: [
                // Greeting + notification bell.
                Row(
                  children: [
                    const DalilLogo(size: 42),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        '${AppStrings.hiGreeting}${auth.profile?.name.split(' ').first ?? ''}',
                        style: text.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Dark-mode toggle, then the bell with its red badge.
                    PressFeedback(
                      child: Builder(
                        builder: (buttonContext) => IconButton(
                          tooltip: AppStrings.darkMode,
                          onPressed: () => ThemeReveal.toggle(buttonContext),
                          icon: Icon(
                            context.watch<ThemeProvider>().isDark
                                ? Icons.light_mode_outlined
                                : Icons.dark_mode_outlined,
                          ),
                        ),
                      ),
                    ),
                    StreamBuilder<List<Chat>>(
                      stream: context.read<ChatProvider>().watchMine(uid),
                      builder: (context, snap) {
                        final unread = (snap.data ?? [])
                            .where((c) => c.isUnreadFor(uid))
                            .length;
                        return TourTarget(
                          step: 2,
                          title: 'رسائلك',
                          description:
                              'افتح محادثاتك هنا. الرقم الأحمر للمحادثات غير المقروءة.',
                          child: IconButton(
                            tooltip: AppStrings.chats,
                            onPressed: () =>
                                Navigator.pushNamed(context, AppRoutes.chats),
                            icon: Badge.count(
                              count: unread,
                              isLabelVisible: unread > 0,
                              backgroundColor: AppColors.danger,
                              child: const Icon(Icons.chat_bubble_outline),
                            ),
                          ),
                        );
                      },
                    ),
                    // Bell with a red unread-count badge.
                    StreamBuilder<List<AppNotification>>(
                      stream: context
                          .read<ProfileProvider>()
                          .watchNotifications(uid),
                      builder: (context, notifSnap) {
                        final unread = (notifSnap.data ?? [])
                            .where((n) => !n.read)
                            .length;
                        return TourTarget(
                          step: 3,
                          title: 'التنبيهات',
                          description: 'اعرف آخر أخبار طلبات التبديل من الجرس.',
                          child: IconButton(
                            onPressed: () {
                              HapticFeedback.lightImpact();
                              Navigator.pushNamed(
                                context,
                                AppRoutes.notifications,
                              );
                            },
                            icon: Badge.count(
                              count: unread,
                              isLabelVisible: unread > 0,
                              backgroundColor: AppColors.danger,
                              child: const Icon(Icons.notifications_outlined),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.sm),

                // Search bar (tapping it opens the Search screen), frosted.
                TourTarget(
                  step: 1,
                  title: 'دور على اللي محتاجه',
                  description: 'ابحث عن الإعلانات واكتشف حاجة تناسبك.',
                  child: GlassContainer(
                    radius: AppSizes.radiusPill,
                    opacity: 0.5,
                    onTap: () => Navigator.pushNamed(context, AppRoutes.search),
                    child: const TextField(
                      readOnly: true,
                      enabled: false,
                      decoration: InputDecoration(
                        hintText: AppStrings.searchHint,
                        prefixIcon: Icon(Icons.search),
                        filled: false,
                        fillColor: Colors.transparent,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSizes.md),

                // Promo banner (olive, from the Figma).
                Container(
                  padding: const EdgeInsets.all(AppSizes.md),
                  decoration: BoxDecoration(
                    color: AppColors.primaryBanner,
                    borderRadius: BorderRadius.circular(AppSizes.radiusCard),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.promoTitle,
                        style: text.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: AppSizes.xs),
                      Text(
                        AppStrings.promoBody,
                        style: text.bodySmall?.copyWith(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSizes.lg),

                // Categories row.
                SectionHeader(
                  title: AppStrings.categories,
                  onViewAll: () =>
                      Navigator.pushNamed(context, AppRoutes.categories),
                ),
                const SizedBox(height: AppSizes.sm),
                // Real category filters, including Other. Only the header opens all categories.
                SizedBox(
                  height: 88,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: AppStrings.categoryList.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 10),
                    itemBuilder: (_, i) => SizedBox(
                      width: 84,
                      child: GlassContainer(
                        radius: 16,
                        onTap: () => Navigator.pushNamed(
                          context,
                          AppRoutes.categoryListings,
                          arguments: AppStrings.categoryList[i],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _categoryIcons[i],
                              size: 26,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              AppStrings.categoryList[i],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: text.labelSmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSizes.lg),

                // Recently added grid.
                const SectionHeader(title: AppStrings.recentlyAdded),
                const SizedBox(height: AppSizes.sm),
                if (snap.connectionState == ConnectionState.waiting)
                  const LoadingSkeleton(grid: true, embedded: true)
                else if (snap.hasError)
                  EmptyState(
                    icon: Icons.wifi_off_rounded,
                    title: 'تعذّر تحميل الإعلانات',
                    body: 'راجع اتصالك بالإنترنت وحاول تاني.',
                    buttonLabel: 'حاول تاني',
                    onButton: () => (context as Element).markNeedsBuild(),
                  )
                else if (all.isEmpty)
                  EmptyState(
                    icon: Icons.inventory_2_outlined,
                    title: AppStrings.emptyListings,
                    body: 'ابدأ بحاجتك اللي مبقتش محتاجها.',
                    buttonLabel: 'أضف أول إعلان',
                    onButton: () =>
                        Navigator.pushNamed(context, AppRoutes.addListing),
                  )
                else
                  StreamBuilder<Set<String>>(
                    stream: context.read<ProfileProvider>().watchFavoriteIds(
                      uid,
                    ),
                    builder: (context, favSnap) {
                      final favs = favSnap.data ?? {};
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: all.length > 6 ? 6 : all.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: AppSizes.sm,
                              crossAxisSpacing: AppSizes.sm,
                              childAspectRatio: 0.68,
                            ),
                        itemBuilder: (_, i) {
                          final l = all[i];
                          return EntranceItem(
                            key: ValueKey(l.id),
                            id: l.id,
                            index: i,
                            child: ListingCard(
                              listing: l,
                              heroTag: 'home_screen-${l.id}-$i',
                              isFavorite: favs.contains(l.id),
                              onFavoriteTap: () => context
                                  .read<ProfileProvider>()
                                  .toggleFavorite(
                                    uid,
                                    l.id,
                                    favs.contains(l.id),
                                  ),
                              onTap: () => Navigator.pushNamed(
                                context,
                                AppRoutes.listingDetails,
                                arguments: ListingDetailsArgs(
                                  l,
                                  heroTag: 'home_screen-${l.id}-$i',
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// Small helper so detail photos render the same everywhere.
class ListingImage extends StatelessWidget {
  final String url;
  final double height;

  const ListingImage({super.key, required this.url, this.height = 260});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: url.isEmpty
          ? Container(
              color: AppColors.primaryLight,
              child: const Icon(
                Icons.image_outlined,
                size: 48,
                color: AppColors.primary,
              ),
            )
          : CachedNetworkImage(imageUrl: url, fit: BoxFit.cover),
    );
  }
}
