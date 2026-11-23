/// ---------------------------------------------------------------------------
/// AppSizes - all spacing and radius values in one place.
/// Screens never hardcode padding: they use these constants so the whole
/// app stays consistent and is easy to tweak before the defense.
/// ---------------------------------------------------------------------------
class AppSizes {
  AppSizes._();

  // ---- Spacing (margins / paddings) ----
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;

  /// Default horizontal page padding used by most screens.
  static const double pagePadding = 20;

  // ---- Corner radius ----
  /// Cards, images, small containers.
  static const double radiusCard = 16;

  /// Buttons and text fields (the Figma uses fully rounded "pill" shapes).
  static const double radiusPill = 28;

  /// Small chips and tags.
  static const double radiusChip = 20;

  // ---- Component heights ----
  static const double buttonHeight = 52;
  static const double categoryTile = 76;

  // ---- Image sizes ----
  static const double listingCardImage = 140;
  static const double avatarRadius = 36;
}
