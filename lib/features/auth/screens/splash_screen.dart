import 'package:flutter/material.dart';
import 'intro_art.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_routes.dart';
import '../../../providers/auth_provider.dart';

/// Vector-drawn brand screen while the auth state settles.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _routed = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final status = context.watch<AuthProvider>().status;
    if (!_routed && status != AuthStatus.unknown) {
      _routed = true;
      WidgetsBinding.instance.addPostFrameCallback((_) => _route());
    }
  }

  void _route() {
    if (!mounted) return;
    final status = context.read<AuthProvider>().status;
    final dest = switch (status) {
      AuthStatus.signedIn => AppRoutes.home,
      AuthStatus.signedOut => AppRoutes.onboarding,
      AuthStatus.unknown => AppRoutes.onboarding,
    };
    Navigator.pushReplacementNamed(context, dest);
  }

  @override
  Widget build(BuildContext context) => dalilSplashContent();
}
