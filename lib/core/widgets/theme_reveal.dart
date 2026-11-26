import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';

/// A bounded, temporary screenshot of the old theme reveals the live new theme.
/// No third-party theme owner: the original provider still persists dark_mode.
class ThemeReveal extends StatefulWidget {
  const ThemeReveal({super.key, required this.child});
  final Widget child;
  static Future<void> toggle(BuildContext context) async {
    final state = context.findAncestorStateOfType<_ThemeRevealState>();
    if (state != null) {
      await state.toggle(context);
    } else {
      await context.read<ThemeProvider>().toggle();
    }
  }

  @override
  State<ThemeReveal> createState() => _ThemeRevealState();
}

class _ThemeRevealState extends State<ThemeReveal>
    with SingleTickerProviderStateMixin {
  final _boundary = GlobalKey();
  late final AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
  }

  ui.Image? _image;
  Offset _origin = Offset.zero;
  bool _busy = false;
  Future<void> toggle(BuildContext trigger) async {
    if (_busy) return;
    _busy = true;
    final theme = trigger.read<ThemeProvider>();
    if (MediaQuery.disableAnimationsOf(trigger)) {
      try {
        await theme.toggle();
      } finally {
        _busy = false;
      }
      return;
    }
    bool changed = false;
    try {
      final boundary =
          _boundary.currentContext?.findRenderObject()
              as RenderRepaintBoundary?;
      final button = trigger.findRenderObject() as RenderBox?;
      if (boundary != null && !boundary.debugNeedsPaint) {
        _origin = button == null
            ? boundary.size.center(Offset.zero)
            : button.localToGlobal(button.size.center(Offset.zero)) -
                  boundary.localToGlobal(Offset.zero);
        // At most one logical-pixel image, about 1 MB on a 360x800 phone.
        final image = await boundary.toImage(pixelRatio: 1);
        if (!mounted) {
          image.dispose();
          return;
        }
        setState(() => _image = image);
      }
      if (!mounted) return;
      changed = true;
      final persistence = theme.toggle();
      if (!mounted) return;
      await WidgetsBinding.instance.endOfFrame;
      if (!mounted) return;
      await _controller.forward(from: 0).orCancel;
      await persistence;
    } on TickerCanceled {
      // Disposal cancels an active reveal.
    } catch (_) {
      // A screenshot is optional. Never lose the actual theme preference.
      if (!changed && mounted) {
        await theme.toggle();
      }
    } finally {
      final image = _image;
      if (mounted) setState(() => _image = null);
      _image = null;
      WidgetsBinding.instance.addPostFrameCallback((_) => image?.dispose());
      _busy = false;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _image?.dispose();
    _image = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Stack(
    textDirection: TextDirection.rtl,
    fit: StackFit.expand,
    children: [
      RepaintBoundary(key: _boundary, child: widget.child),
      if (_image != null)
        Positioned.fill(
          child: IgnorePointer(
            child: ExcludeSemantics(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (_, _) => ClipPath(
                  clipper: _RevealClipper(
                    _origin,
                    Curves.easeInOutCubic.transform(_controller.value),
                  ),
                  child: RawImage(image: _image, fit: BoxFit.fill),
                ),
              ),
            ),
          ),
        ),
    ],
  );
}

class _RevealClipper extends CustomClipper<Path> {
  _RevealClipper(this.origin, this.progress);
  final Offset origin;
  final double progress;
  @override
  Path getClip(Size size) {
    final radius = [
      Offset.zero,
      Offset(size.width, 0),
      Offset(0, size.height),
      Offset(size.width, size.height),
    ].map((p) => (p - origin).distance).reduce(math.max);
    return Path()
      ..fillType = PathFillType.evenOdd
      ..addRect(Offset.zero & size)
      ..addOval(Rect.fromCircle(center: origin, radius: radius * progress));
  }

  @override
  bool shouldReclip(_RevealClipper oldClipper) =>
      oldClipper.progress != progress || oldClipper.origin != origin;
}
