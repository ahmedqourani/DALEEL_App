/// ---------------------------------------------------------------------------
/// AppRoutes - every named route in the app.
/// Navigation is always done with Navigator.pushNamed(context, AppRoutes.x),
/// as required by the project spec (no go_router).
/// ---------------------------------------------------------------------------
class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String signUp = '/signup';
  static const String forgotPassword = '/forgot-password';
  static const String resetEmailSent = '/reset-email-sent';

  /// Shell screen holding the bottom navigation bar.
  static const String home = '/home';
  static const String categories = '/categories';
  static const String categoryListings = '/category-listings';
  static const String search = '/search';

  static const String listingDetails = '/listing-details';
  static const String addListing = '/add-listing';
  static const String myListings = '/my-listings';

  static const String sendSwapRequest = '/send-swap-request';
  static const String requestDetails = '/request-details';
  static const String swapRequestSent = '/swap-request-sent';

  static const String chats = '/chats';
  static const String chatRoom = '/chat-room';

  static const String editProfile = '/edit-profile';
  static const String userProfile = '/user-profile';
  static const String rateUser = '/rate-user';

  static const String notifications = '/notifications';
  static const String notFound = '/not-found';
}
