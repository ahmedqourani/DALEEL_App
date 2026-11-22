import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';

// Foundation only. Intentionally no feature screens or data layer.
void main() => runApp(const DalilFoundation());
class DalilFoundation extends StatelessWidget {
  const DalilFoundation({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: AppTheme.light,
    darkTheme: AppTheme.dark,
    home: const SizedBox.shrink(),
  );
}
