import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import '../../../core/widgets/dalil_logo.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_routes.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../providers/auth_provider.dart';

/// ---------------------------------------------------------------------------
/// LoginScreen - email/password + Google sign-in, matching the Figma:
/// logo, title, two white fields, "Forget password?", olive Log In button,
/// "or", white Google button, sign-up link at the bottom.
/// ---------------------------------------------------------------------------
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final auth = context.read<AuthProvider>();
    final ok = await auth.signIn(_email.text, _password.text);
    if (!mounted) return;
    if (ok) {
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (_) => false);
    } else {
      _password.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(auth.error ?? AppStrings.somethingWentWrong)),
      );
    }
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _google() async {
    final auth = context.read<AuthProvider>();
    // serverClientId is read from the centralized constant (see AppStrings
    // docs/README): the Web client ID from google-services.json.
    final ok = await auth.signInWithGoogle(AppStrings.googleServerClientId);
    if (!mounted) return;
    if (ok) {
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (_) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(auth.error ?? AppStrings.somethingWentWrong)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final text = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizes.pagePadding),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppSizes.xl),
                // Small cream logo, like the splash.
                Center(child: const DalilLogo(size: 84)),
                const SizedBox(height: AppSizes.lg),
                Text(
                  AppStrings.login,
                  style: text.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  AppStrings.loginSubtitle,
                  style: text.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: AppSizes.lg),
                AppTextField(
                  label: AppStrings.email,
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.email_outlined,
                  validator: (v) => (v == null || !v.contains('@'))
                      ? AppStrings.invalidEmail
                      : null,
                ),
                const SizedBox(height: AppSizes.md),
                AppTextField(
                  label: AppStrings.password,
                  controller: _password,
                  obscure: true,
                  prefixIcon: Icons.lock_outline,
                  validator: (v) => (v == null || v.length < 6)
                      ? AppStrings.shortPassword
                      : null,
                ),
                // "Forget password?" link under the fields.
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoutes.forgotPassword),
                    child: const Text(AppStrings.forgotPassword),
                  ),
                ),
                PrimaryButton(
                  label: AppStrings.login,
                  haptic: true,
                  busy: auth.busy,
                  onPressed: _submit,
                ),
                const SizedBox(height: AppSizes.md),
                // "or" divider.
                Row(
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.sm,
                      ),
                      child: Text(
                        AppStrings.orDivider,
                        style: text.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: AppSizes.md),
                OutlinedButton.icon(
                  onPressed: auth.busy
                      ? null
                      : () {
                          HapticFeedback.lightImpact();
                          _google();
                        },
                  icon: const Icon(Icons.g_mobiledata, size: 28),
                  label: const Text(AppStrings.signInWithGoogle),
                ),
                const SizedBox(height: AppSizes.lg),
                // Bottom link to sign up.
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppStrings.noAccount, style: text.bodyMedium),
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, AppRoutes.signUp),
                      child: Text(
                        AppStrings.signUp,
                        style: text.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
