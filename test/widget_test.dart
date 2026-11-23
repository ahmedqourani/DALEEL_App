import 'dart:io';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swap_app/main.dart';
import 'package:swap_app/app.dart';
import 'package:swap_app/providers/auth_provider.dart';
import 'package:swap_app/providers/listings_provider.dart';
import 'package:swap_app/services/session_streams.dart' show DemoStore;
import 'package:swap_app/services/notification_service.dart';
import 'package:swap_app/core/constants/app_routes.dart';

const routePaths = {
  'onboarding': AppRoutes.onboarding, 'login': AppRoutes.login,
  'signUp': AppRoutes.signUp, 'forgotPassword': AppRoutes.forgotPassword,
  'resetEmailSent': AppRoutes.resetEmailSent, 'home': AppRoutes.home,
  'categories': AppRoutes.categories, 'categoryListings': AppRoutes.categoryListings,
  'search': AppRoutes.search, 'listingDetails': AppRoutes.listingDetails,
  'addListing': AppRoutes.addListing, 'myListings': AppRoutes.myListings,
  'sendSwapRequest': AppRoutes.sendSwapRequest, 'requestDetails': AppRoutes.requestDetails,
  'swapRequestSent': AppRoutes.swapRequestSent, 'chats': AppRoutes.chats,
  'chatRoom': AppRoutes.chatRoom, 'editProfile': AppRoutes.editProfile,
  'userProfile': AppRoutes.userProfile, 'rateUser': AppRoutes.rateUser,
  'notifications': AppRoutes.notifications,
};
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() {SharedPreferences.setMockInitialValues({'dalil_home_tour_v1_seen':true});});
  test('demo auth and search are local', () async {
    final auth = AuthProvider();
    expect(await auth.signIn('demo@example.invalid', 'not-a-real-password'), isTrue);
    expect(auth.uid, DemoStore.me.id);
    final listings = ListingsProvider();
    listings.setQuery('كتاب');
    expect(listings.applySearch(await listings.watchAvailable().first), isNotEmpty);
    listings.setQuery('does-not-exist');
    expect(listings.applySearch(await listings.watchAvailable().first), isEmpty);
    await auth.signOut();expect(auth.uid, isNull);auth.dispose();listings.dispose();
  });
  final routes = <String>['onboarding','login','signUp','forgotPassword','resetEmailSent'];
  for(final name in routes) {
    testWidgets('stage 2 named route $name', (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      for(final font in {'Zain':'assets/fonts/zain/Zain-Regular.ttf',
        'Poppins':'assets/fonts/poppins/Poppins-Regular.ttf',
        'Changa':'assets/fonts/changa/Changa-ExtraBold.ttf'}.entries) {
        await (FontLoader(font.key)..addFont(rootBundle.load(font.value))).load();
      }
      final configFile = File('.dart_tool/package_config.json').absolute;
      final packages = jsonDecode(configFile.readAsStringSync())['packages'] as List;
      final flutter = packages.firstWhere((p) => p['name'] == 'flutter');
      final package = Directory.fromUri(configFile.uri.resolve(flutter['rootUri'] as String)).uri;
      final iconFile = File.fromUri(package.resolve('../../bin/cache/artifacts/material_fonts/MaterialIcons-Regular.otf'));
      await (FontLoader('MaterialIcons')..addFont(Future.value(ByteData.sublistView(iconFile.readAsBytesSync())))).load();
      final boundary = GlobalKey();
      await tester.pumpWidget(RepaintBoundary(key:boundary, child:const DalilDemo()));
      await tester.pump();await tester.pump(const Duration(milliseconds:500));
      final context = tester.element(find.byType(DalilApp));
      await context.read<AuthProvider>().signIn('demo@example.invalid', 'demo-only');
      await tester.pump();
      final db = DemoStore.instance;
      final args = <String,Object>{
        'categoryListings':'كتب ومراجع', 'listingDetails':db.listings.first.id,
        'sendSwapRequest':db.listings.first, 'requestDetails':db.requests.first.id,
        'rateUser':db.requests.first, 'chatRoom':db.chats.first,
        'userProfile':DemoStore.peer.id,
      };
      dalilNavigatorKey.currentState!.pushNamed(routePaths[name]!, arguments:args[name]);
      await tester.pump();await tester.pump(const Duration(seconds:1));
      await tester.pump(const Duration(milliseconds:100));
      for(var frame = 0; frame < 4; frame++) {
        await tester.pump(const Duration(seconds:1));
      }
      expect(tester.takeException(), isNull);
      expect(find.text('الجزء ده لسه في مرحلة تالية'), findsNothing);
      final captureName = switch (2) {2=>'onboarding',3=>'home',4=>'listingDetails',_=>'chatRoom'};
      if(name == captureName) {
        await tester.runAsync(() async {
          final image = await (boundary.currentContext!.findRenderObject() as RenderRepaintBoundary).toImage();
          final data = await image.toByteData(format: ui.ImageByteFormat.png);
          await File('build/team-stage-2.png').writeAsBytes(data!.buffer.asUint8List());
          image.dispose();
        });
      }
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump(const Duration(seconds:2));
    });
  }
}
