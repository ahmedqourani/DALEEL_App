import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingSkeleton extends StatelessWidget {
  const LoadingSkeleton({
    super.key,
    this.grid = false,
    this.details = false,
    this.embedded = false,
  });
  final bool grid;
  final bool details;
  final bool embedded;
  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final base = dark ? const Color(0xFF243F49) : const Color(0xFFDDE9EB);
    final highlight = dark ? const Color(0xFF35535E) : const Color(0xFFF3F8F8);
    Widget block(double height, {double? width}) => Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: base,
        borderRadius: BorderRadius.circular(14),
      ),
    );
    final body = Padding(
      padding: const EdgeInsets.all(16),
      child: details
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                block(260),
                const SizedBox(height: 24),
                block(24),
                const SizedBox(height: 16),
                block(18),
                const SizedBox(height: 12),
                block(18),
                const SizedBox(height: 28),
                block(52),
              ],
            )
          : grid
          ? GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: .68,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              children: List.generate(4, (_) => block(200)),
            )
          : Column(
              children: List.generate(
                5,
                (_) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: block(84),
                ),
              ),
            ),
    );
    Widget child = ExcludeSemantics(
      child: Shimmer.fromColors(
        enabled:
            !MediaQuery.disableAnimationsOf(context) &&
            TickerMode.valuesOf(context).enabled,
        baseColor: base,
        highlightColor: highlight,
        period: const Duration(milliseconds: 1400),
        child: body,
      ),
    );
    if (!embedded) child = SingleChildScrollView(child: child);
    return Semantics(
      label: 'جارٍ تحميل البيانات',
      liveRegion: true,
      child: child,
    );
  }
}
