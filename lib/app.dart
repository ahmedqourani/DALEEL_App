import 'core/widgets/dalil_tour.dart';
import 'core/widgets/theme_reveal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/constants/app_routes.dart';
import 'services/notification_service.dart';
import 'core/constants/app_strings.dart';
import 'core/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'providers/theme_provider.dart';
import 'features/auth/screens/forgot_password_screen.dart';
import 'features/auth/screens/login_screen.dart';
import 'features/auth/screens/onboarding_screen.dart';
import 'features/auth/screens/signup_screen.dart';
import 'features/auth/screens/splash_screen.dart';


import 'features/home/screens/categories_screen.dart';
import 'features/home/screens/category_listings_screen.dart';

import 'features/home/screens/shell_screen.dart';











/// ---------------------------------------------------------------------------
/// DalilApp - the root widget.
/// Arabic RTL app (locale ar), theme from AppTheme, named routes only.
/// Every route in the app is declared here in onGenerateRoute.
/// ---------------------------------------------------------------------------
class DalilApp extends StatelessWidget {
  const DalilApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeProvider>().isDark;
    return ThemeReveal(
      child: MaterialApp(
        title: AppStrings.appName,
        navigatorKey: dalilNavigatorKey,
        navigatorObservers: [dalilTourObserver],
        debugShowCheckedModeBanner: false,
        themeAnimationDuration: Duration.zero,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: isDark ? ThemeMode.dark : ThemeMode.light,

        // ---- Arabic RTL setup ----
        locale: const Locale('ar'),
        supportedLocales: const [Locale('ar')],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],

        // ---- Named routes (Navigator.pushNamed everywhere) ----
        initialRoute: AppRoutes.splash,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case AppRoutes.splash:
              return _page(const SplashScreen(), settings);
            case AppRoutes.onboarding:
              return _page(const OnboardingScreen(), settings);
            case AppRoutes.login:
              return _page(const LoginScreen(), settings);
            case AppRoutes.signUp:
              return _page(const SignUpScreen(), settings);
            case AppRoutes.forgotPassword:
              return _page(const ForgotPasswordScreen(), settings);
            case AppRoutes.resetEmailSent:
              return _page(const ResetEmailSentScreen(), settings);
            case AppRoutes.home:
              return _page(const ShellScreen(), settings);
            case AppRoutes.categories:
              return _page(const CategoriesScreen(), settings);
            case AppRoutes.categoryListings:
              return _page(const CategoryListingsScreen(), settings);
            case AppRoutes.search:
              return _page(const _PendingStageScreen(), settings);
            case AppRoutes.listingDetails:
              return _page(const _PendingStageScreen(), settings);
            case AppRoutes.addListing:
              return _page(const _PendingStageScreen(), settings);
            case AppRoutes.myListings:
              return _page(const _PendingStageScreen(), settings);
            case AppRoutes.sendSwapRequest:
              return _page(const _PendingStageScreen(), settings);
            case AppRoutes.requestDetails:
              return _page(const _PendingStageScreen(), settings);
            case AppRoutes.swapRequestSent:
              return _page(const _PendingStageScreen(), settings);
            case AppRoutes.chats:
              return _page(const _PendingStageScreen(), settings);
            case AppRoutes.chatRoom:
              return _page(const _PendingStageScreen(), settings);
            case AppRoutes.editProfile:
              return _page(const _PendingStageScreen(), settings);
            case AppRoutes.userProfile:
              return _page(const _PendingStageScreen(), settings);
            case AppRoutes.rateUser:
              return _page(const _PendingStageScreen(), settings);
            case AppRoutes.notifications:
              return _page(const _PendingStageScreen(), settings);
            case AppRoutes.notFound:
              return _page(const NotFoundScreen(), settings);
            default:
              return _page(const NotFoundScreen(), settings);
          }
        },
      ),
    );
  }

  /// Wrap a screen in a route, carrying any arguments along.
  static MaterialPageRoute _page(Widget screen, RouteSettings settings) {
    return MaterialPageRoute(builder: (_) => screen, settings: settings);
  }
}

/// ---------------------------------------------------------------------------
/// NotFoundScreen - styled after the Figma "Not Found" frame.
/// Shown for unknown routes and empty search results.
/// ---------------------------------------------------------------------------
class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.search_off, size: 72, color: AppColors.primary),
              const SizedBox(height: 16),
              Text(AppStrings.noResultsTitle, style: text.titleMedium),
              const SizedBox(height: 8),
              Text(
                AppStrings.noResultsBody,
                style: text.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.home,
                  (_) => false,
                ),
                child: const Text(AppStrings.browseCategories),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Temporary route destination, not a finished feature screen.
class _PendingStageScreen extends StatelessWidget {
  const _PendingStageScreen();
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(), body: const Center(child: Text('الجزء ده لسه في مرحلة تالية')));
}
