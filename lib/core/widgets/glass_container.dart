import 'package:flutter/material.dart';

/// Shared low-cost solid surface with a subtle press response.
/// Retains its public API so existing screens inherit the same surface style.
class GlassContainer extends StatefulWidget {
  final Widget child;
  final double radius;
  final EdgeInsetsGeometry? padding;

  /// White fill strength: higher = more solid, lower = more see-through.
  final double opacity;
  final VoidCallback? onTap;

  const GlassContainer({
    super.key,
    required this.child,
    this.radius = 16,
    this.padding,
    this.opacity = 0.45,
    this.onTap,
  });

  @override
  State<GlassContainer> createState() => _GlassContainerState();
}

class _GlassContainerState extends State<GlassContainer> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (widget.onTap == null || _pressed == value) return;
    setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(widget.radius);
    final fill = Theme.of(context).colorScheme.surface;
    final borderColor = Theme.of(context).dividerColor.withValues(alpha: 0.12);
    return GestureDetector(
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      child: AnimatedScale(
        scale: _pressed ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 110),
        curve: Curves.easeOutCubic,
        child: ClipRRect(
          borderRadius: borderRadius,
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              onTap: widget.onTap,
              borderRadius: borderRadius,
              splashColor: AppGlassSplash.color,
              child: Container(
                padding: widget.padding,
                decoration: BoxDecoration(
                  color: fill,
                  borderRadius: borderRadius,
                  border: Border.all(color: borderColor),
                ),
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Soft olive ripple used on glass surfaces.
class AppGlassSplash {
  AppGlassSplash._();
  static const Color color = Color.fromRGBO(7, 94, 107, 0.12);
}
