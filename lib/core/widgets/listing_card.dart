import 'motion_feedback.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../models/listing.dart';
import '../theme/app_theme.dart';

/// Image-led card with separate, accessible favorite control.
class ListingCard extends StatelessWidget {
  final Listing listing;
  final Object? heroTag;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onFavoriteTap;
  const ListingCard({
    super.key,
    required this.listing,
    this.heroTag,
    required this.isFavorite,
    required this.onTap,
    required this.onFavoriteTap,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = theme.textTheme;
    return Material(
      color: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: theme.colorScheme.onSurface.withValues(alpha: .08),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: LayoutBuilder(
          builder: (context, box) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Hero(
                        tag: heroTag ?? 'listing-photo-${listing.id}',
                        child: ColoredBox(
                          color: AppColors.primaryLight,
                          child: listing.images.isEmpty
                              ? const Icon(
                                  Icons.inventory_2_outlined,
                                  color: AppColors.primary,
                                  size: 36,
                                )
                              : CachedNetworkImage(
                                  imageUrl: listing.images.first,
                                  fit: BoxFit.cover,
                                  placeholder: (_, _) => const Center(
                                    child: Icon(
                                      Icons.image_outlined,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  errorWidget: (_, _, _) => const Icon(
                                    Icons.broken_image_outlined,
                                    color: AppColors.primary,
                                  ),
                                ),
                        ),
                      ),
                      Positioned(
                        top: 4,
                        left: 4,
                        child: PressFeedback(
                          child: IconButton.filledTonal(
                            tooltip: isFavorite
                                ? 'إزالة من المفضلة'
                                : 'إضافة للمفضلة',
                            style: IconButton.styleFrom(
                              backgroundColor: theme.colorScheme.surface,
                              foregroundColor: isFavorite
                                  ? AppColors.danger
                                  : theme.colorScheme.onSurface,
                            ),
                            onPressed: onFavoriteTap,
                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              size: 21,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          listing.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: text.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.swap_horiz,
                              size: 16,
                              color: theme.colorScheme.primary,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                listing.wantedInReturn,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: text.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryLight,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Text(
                            listing.condition,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: text.labelSmall?.copyWith(
                              color: AppColors.text,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
