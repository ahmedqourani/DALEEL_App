import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';
import '../../../core/widgets/dalil_tour.dart';
import 'package:flutter/material.dart';
import '../../../services/notification_service.dart';

import '../../../core/constants/app_routes.dart';
import '../../../core/widgets/app_bottom_bar.dart';
import 'home_screen.dart';
import '../../requests/screens/swap_requests_screen.dart';
import '../../favorites/screens/favorites_screen.dart';
import '../../profile/screens/profile_screen.dart';

/// ---------------------------------------------------------------------------
/// ShellScreen - the bottom navigation shell (Home / Requests / Favorites /
/// Profile), styled like the Figma's light-olive pill nav bar.
/// A floating "+" button opens Add Listing from any tab.
/// ---------------------------------------------------------------------------
class ShellScreen extends StatefulWidget {
  const ShellScreen({super.key});

  @override
  State<ShellScreen> createState() => _ShellScreenState();
}

class _ShellScreenState extends State<ShellScreen> with RouteAware {
  int _index = 0;
  final _targets = List.generate(5, (_) => GlobalKey());
  late final ShowcaseView _tour;
  bool _interrupted = false;
  PageRoute<dynamic>? _subscribed;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route is PageRoute<dynamic> && route != _subscribed) {
      dalilTourObserver.unsubscribe(this);
      _subscribed = route;
      dalilTourObserver.subscribe(this, route);
    }
  }

  @override
  void didPushNext() {
    if (_tour.isShowcaseRunning) {
      _interrupted = true;
      _tour.dismiss();
      _interrupted = false;
    }
  }

  static const _seenKey = 'dalil_home_tour_v1_seen';
  Future<void> _markSeen() async {
    if (_interrupted) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_seenKey, true);
  }

  Future<void> _maybeTour() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted ||
        prefs.getBool(_seenKey) == true ||
        ModalRoute.of(context)?.isCurrent != true ||
        _index != 0) {
      return;
    }
    _tour.startShowCase(_targets);
  }

  void _replay() {
    setState(() => _index = 0);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && ModalRoute.of(context)?.isCurrent == true) {
        _tour.startShowCase(_targets);
      }
    });
  }

  @override
  void dispose() {
    dalilTourObserver.unsubscribe(this);
    _tour.unregister();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tour = ShowcaseView.register(
      onFinish: _markSeen,
      onDismiss: (_) => _markSeen(),
      disableMovingAnimation: true,
      disableScaleAnimation: true,
      globalTooltipActions: [
        TooltipActionButton(
          type: TooltipDefaultActionType.previous,
          backgroundColor: const Color(0xFF075E6B),
          textStyle: const TextStyle(color: Colors.white),
          name: 'السابق',
          hideActionWidgetForShowcase: [_targets.first],
        ),
        const TooltipActionButton(
          type: TooltipDefaultActionType.next,
          backgroundColor: Color(0xFF075E6B),
          textStyle: TextStyle(color: Colors.white),
          name: 'التالي',
        ),
        const TooltipActionButton(
          type: TooltipDefaultActionType.skip,
          backgroundColor: Color(0xFF075E6B),
          textStyle: TextStyle(color: Colors.white),
          name: 'تخطي',
        ),
      ],
    );
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      NotificationService.instance.navigationReady = true;
      await NotificationService.instance.openPending();
      await _maybeTour();
    });
  }

  // One screen per tab; they stay alive while switching.
  static const _tabs = [
    HomeScreen(),
    SwapRequestsScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return DalilTour(
      targets: _targets,
      replay: _replay,
      child: Scaffold(
        // Palette blobs sit behind the tabs so the glass surfaces have
        // something soft to blur over.
        body: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: IndexedStack(
            index: _index,
            children: [
              for (var i = 0; i < _tabs.length; i++)
                HeroMode(
                  enabled: _index == i,
                  child: TickerMode(enabled: _index == i, child: _tabs[i]),
                ),
            ],
          ),
        ),

        // Dedicated bottom action area: the add button cannot cover listings.
        bottomNavigationBar: AppBottomBar(
          index: _index,
          onSelected: (index) => setState(() => _index = index),
          onAdd: () => Navigator.pushNamed(context, AppRoutes.addListing),
        ),
      ),
    );
  }
}
