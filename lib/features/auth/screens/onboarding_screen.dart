import 'package:flutter/material.dart';
import '../../../core/constants/app_routes.dart';
import 'intro_art.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _page = 0;
  void _skip() => Navigator.pushReplacementNamed(context, AppRoutes.login);
  void _next() {
    if (_page < 2) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } else {
      _skip();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => PageView.builder(
    controller: _controller,
    itemCount: 3,
    onPageChanged: (i) => setState(() => _page = i),
    itemBuilder: (_, i) => dalilOnboardingPage(i, onNext: _next, onSkip: _skip),
  );
}
