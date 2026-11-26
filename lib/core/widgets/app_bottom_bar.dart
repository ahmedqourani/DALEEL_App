import 'dalil_tour.dart';
import 'motion_feedback.dart';
import 'package:flutter/material.dart';

import '../constants/app_strings.dart';
import '../theme/app_theme.dart';

/// The full dock, including the raised half of the FAB, occupies layout
/// space. Scrolling content ends above it instead of underneath the button.
class AppBottomBar extends StatelessWidget {
  final int index;
  final ValueChanged<int> onSelected;
  final VoidCallback onAdd;

  const AppBottomBar({
    super.key,
    required this.index,
    required this.onSelected,
    required this.onAdd,
  });

  static const _labels = [
    AppStrings.navHome,
    AppStrings.navRequests,
    AppStrings.navFavorites,
    AppStrings.navProfile,
  ];
  static const _icons = [
    Icons.home_outlined,
    Icons.swap_horiz,
    Icons.favorite_border,
    Icons.person_outline,
  ];
  static const _activeIcons = [
    Icons.home,
    Icons.swap_horiz,
    Icons.favorite,
    Icons.person,
  ];

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final selected = dark ? const Color(0xFF8CD6DF) : const Color(0xFF075E6B);
    final inactive = dark ? const Color(0xFFB2C8CF) : const Color(0xFF5B737A);
    return SafeArea(
      top: false,
      minimum: const EdgeInsets.fromLTRB(12, 8, 12, 12),
      child: SizedBox(
        height: 96,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              top: 28,
              left: 0,
              right: 0,
              child: Material(
                key: const Key('nav-dock'),
                elevation: 4,
                shadowColor: const Color(0x33075E6B),
                color: dark ? const Color(0xFF18313B) : const Color(0xFFFFFFFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: BorderSide(
                    color: dark ? const Color(0xFF29454F) : Colors.white,
                  ),
                ),
                child: SizedBox(
                  height: 68,
                  child: TourTarget(
                    step: 4,
                    title: 'كل حاجة قريبة',
                    description:
                        'تابع طلبات التبديل والمفضلة وافتح حسابك من هنا.',
                    child: Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        _tab(context, 0, selected, inactive),
                        _tab(context, 1, selected, inactive),
                        const SizedBox(width: 68),
                        _tab(context, 2, selected, inactive),
                        _tab(context, 3, selected, inactive),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            TourTarget(
              step: 0,
              title: 'أضف إعلانك',
              description:
                  'اعرض الحاجة اللي مش محتاجها واكتب عايز تبدلها بإيه.',
              child: SizedBox.square(
                dimension: 56,
                child: PressFeedback(
                  child: FloatingActionButton(
                    heroTag: 'add-listing',
                    tooltip: AppStrings.addListing,
                    onPressed: onAdd,
                    backgroundColor: AppColors.addAction,
                    foregroundColor: const Color(0xFF15170F),
                    elevation: 4,
                    shape: const CircleBorder(),
                    child: const Icon(Icons.add, size: 30),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tab(BuildContext context, int tab, Color selected, Color inactive) {
    final active = tab == index;
    final color = active ? selected : inactive;
    return Expanded(
      child: Semantics(
        selected: active,
        button: true,
        label: _labels[tab],
        child: PressFeedback(
          child: InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: () => onSelected(tab),
            child: SizedBox.expand(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    active ? _activeIcons[tab] : _icons[tab],
                    size: 24,
                    color: color,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _labels[tab],
                    maxLines: 1,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: color,
                      fontSize: 11,
                      fontWeight: active ? FontWeight.w700 : FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
