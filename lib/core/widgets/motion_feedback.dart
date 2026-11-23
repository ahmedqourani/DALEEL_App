import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Visual feedback without adding a second gesture recognizer or tap callback.
/// The child keeps its own semantics, disabled state and keyboard activation.
class PressFeedback extends StatefulWidget {
  const PressFeedback({super.key, required this.child, this.enabled = true});
  final Widget child;
  final bool enabled;
  @override
  State<PressFeedback> createState() => _PressFeedbackState();
}

class _PressFeedbackState extends State<PressFeedback> {
  bool _down = false;
  void _release() {
    if (_down) setState(() => _down = false);
  }

  @override
  void didUpdateWidget(covariant PressFeedback oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.enabled) _down = false;
  }

  @override
  Widget build(BuildContext context) => Listener(
    onPointerDown: widget.enabled
        ? (_) {
            setState(() => _down = true);
          }
        : null,
    onPointerUp: (_) => _release(),
    onPointerCancel: (_) => _release(),
    child: GestureDetector(
      onTapDown: widget.enabled ? (_) {} : null,
      onTapCancel: _release,
      child: AnimatedScale(
        scale: _down && !MediaQuery.disableAnimationsOf(context) ? .95 : 1,
        duration: MediaQuery.disableAnimationsOf(context)
            ? Duration.zero
            : const Duration(milliseconds: 110),
        curve: Curves.easeOut,
        child: widget.child,
      ),
    ),
  );
}

/// A scope owns the first nonempty snapshot's ids. Stream updates/reorders and
/// scrolling never create another entrance wave. Offstage tabs wait until seen.
class EntranceScope extends StatefulWidget {
  const EntranceScope({super.key, required this.child});
  final Widget child;
  @override
  State<EntranceScope> createState() => EntranceScopeState();
}

class EntranceScopeState extends State<EntranceScope> {
  final Set<Object> played = {};
  bool sealed = false;
  bool scheduled = false;
  bool claim(Object id, int index, BuildContext context) {
    if (sealed ||
        index >= 8 ||
        !TickerMode.valuesOf(context).enabled ||
        MediaQuery.disableAnimationsOf(context)) {
      return false;
    }
    if (!scheduled) {
      scheduled = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        sealed = true;
      });
    }
    return played.add(id);
  }

  @override
  Widget build(BuildContext context) =>
      _EntranceData(state: this, child: widget.child);
}

class _EntranceData extends InheritedWidget {
  const _EntranceData({required this.state, required super.child});
  final EntranceScopeState state;
  @override
  bool updateShouldNotify(_EntranceData oldWidget) => false;
}

class EntranceItem extends StatefulWidget {
  const EntranceItem({
    super.key,
    required this.id,
    required this.index,
    required this.child,
  });
  final Object id;
  final int index;
  final Widget child;
  @override
  State<EntranceItem> createState() => _EntranceItemState();
}

class _EntranceItemState extends State<EntranceItem> {
  bool? _animate;
  @override
  Widget build(BuildContext context) {
    if (!TickerMode.valuesOf(context).enabled) return widget.child;
    _animate ??=
        context
            .dependOnInheritedWidgetOfExactType<_EntranceData>()
            ?.state
            .claim(widget.id, widget.index, context) ??
        false;
    if (!_animate! || MediaQuery.disableAnimationsOf(context)) {
      return widget.child;
    }
    return widget.child
        .animate(delay: Duration(milliseconds: widget.index * 40))
        .fadeIn(duration: 220.ms)
        .slideY(begin: .06, end: 0, duration: 220.ms);
  }
}
