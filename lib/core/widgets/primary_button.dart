import 'package:flutter/services.dart';
import 'motion_feedback.dart';
import 'package:flutter/material.dart';

import '../constants/app_sizes.dart';

/// ---------------------------------------------------------------------------
/// PrimaryButton - the olive pill button used across the app.
/// Pass [busy] to show a spinner instead of the label while saving.
/// ---------------------------------------------------------------------------
class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool busy;

  /// Explicit opt-in for the small set of important commit/account actions.
  final bool haptic;

  /// Set true for destructive actions (red, e.g. Log out).
  final bool danger;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.busy = false,
    this.haptic = false,
    this.danger = false,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return PressFeedback(
      enabled: !busy && onPressed != null,
      child: SizedBox(
        height: AppSizes.buttonHeight,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: busy || onPressed == null
              ? null
              : () {
                  if (haptic) HapticFeedback.lightImpact();
                  onPressed!();
                },
          style: danger
              ? ElevatedButton.styleFrom(backgroundColor: scheme.error)
              : null,
          child: busy
              ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : Text(label),
        ),
      ),
    );
  }
}
