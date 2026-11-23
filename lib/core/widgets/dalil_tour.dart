import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

/// Keys are owned by the shell, not by global widget instances.
class DalilTour extends InheritedWidget {
  const DalilTour({
    super.key,
    required this.targets,
    required this.replay,
    required super.child,
  });
  final List<GlobalKey> targets;
  final VoidCallback replay;
  static DalilTour? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<DalilTour>();
  @override
  bool updateShouldNotify(DalilTour oldWidget) => targets != oldWidget.targets;
}

class TourTarget extends StatelessWidget {
  const TourTarget({
    super.key,
    required this.step,
    required this.title,
    required this.description,
    required this.child,
  });
  final int step;
  final String title;
  final String description;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final tour = DalilTour.of(context);
    if (tour == null) return child;
    final scheme = Theme.of(context).colorScheme;
    return Showcase(
      key: tour.targets[step],
      title: title,
      description: description,
      tooltipBackgroundColor: scheme.surface,
      textColor: scheme.onSurface,
      titleTextStyle: TextStyle(
        color: scheme.primary,
        fontWeight: FontWeight.bold,
      ),
      targetBorderRadius: BorderRadius.circular(20),
      disableMovingAnimation: true,
      disableScaleAnimation: true,
      child: child,
    );
  }
}

final dalilTourObserver = RouteObserver<PageRoute<dynamic>>();
