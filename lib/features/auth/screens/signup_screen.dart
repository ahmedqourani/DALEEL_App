import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_routes.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../providers/auth_provider.dart';

/// ---------------------------------------------------------------------------
/// SignUpScreen - "Create New Account": name, email, password, confirm,
/// olive Create Account button + Google button, matching the Figma layout.
/// ---------------------------------------------------------------------------
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final auth = context.read<AuthProvider>();
    final ok = await auth.signUp(_name.text, _email.text, _password.text);
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
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizes.pagePadding),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  AppStrings.createNewAccount,
                  style: text.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  AppStrings.signUpSubtitle,
                  style: text.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: AppSizes.lg),
                AppTextField(
                  label: AppStrings.fullName,
                  controller: _name,
                  prefixIcon: Icons.person_outline,
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? AppStrings.fieldRequired
                      : null,
                ),
                const SizedBox(height: AppSizes.md),
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
                const SizedBox(height: AppSizes.md),
                AppTextField(
                  label: AppStrings.confirmPassword,
                  controller: _confirm,
                  obscure: true,
                  prefixIcon: Icons.lock_outline,
                  validator: (v) => v != _password.text
                      ? AppStrings.passwordsDontMatch
                      : null,
                ),
                const SizedBox(height: AppSizes.lg),
                PrimaryButton(
                  label: AppStrings.createAccount,
                  busy: auth.busy,
                  onPressed: _submit,
                ),
                const SizedBox(height: AppSizes.md),
                OutlinedButton.icon(
                  onPressed: auth.busy
                      ? null
                      : () async {
                          final a = context.read<AuthProvider>();
                          final ok = await a.signInWithGoogle(
                            AppStrings.googleServerClientId,
                          );
                          if (!context.mounted) return;
                          if (ok) {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              AppRoutes.home,
                              (_) => false,
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  a.error ?? AppStrings.somethingWentWrong,
                                ),
                              ),
                            );
                          }
                        },
                  icon: const Icon(Icons.g_mobiledata, size: 28),
                  label: const Text(AppStrings.signInWithGoogle),
                ),
                const SizedBox(height: AppSizes.lg),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppStrings.haveAccount, style: text.bodyMedium),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Text(
                        AppStrings.login,
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
