import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'providers/auth_provider.dart';
import 'providers/listings_provider.dart';
import 'providers/requests_provider.dart';
import 'providers/misc_providers.dart';
import 'providers/theme_provider.dart';
void main() => runApp(const DalilDemo());
// The visible demo label stays until the production bootstrap replaces this file.
class DalilDemo extends StatelessWidget {
  const DalilDemo({super.key});
  @override
  Widget build(BuildContext context) => MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthProvider()),
      ChangeNotifierProvider(create: (_) => ListingsProvider()),
      ChangeNotifierProvider(create: (_) => RequestsProvider()),
      ChangeNotifierProvider(create: (_) => ChatProvider()),
      ChangeNotifierProvider(create: (_) => ProfileProvider()),
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
    ],
    child: const Directionality(textDirection: TextDirection.rtl,
      child: Banner(message: 'تجريبي', location: BannerLocation.topEnd,
        textStyle: TextStyle(fontFamily: 'Zain', fontSize: 12, color: Colors.white), color: Colors.orange, child: DalilApp())),
  );
}
