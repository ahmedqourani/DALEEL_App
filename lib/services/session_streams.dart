// Temporary in-memory demo data. No authentication, uploads or remote writes.
import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import '../models/app_user.dart';
import '../models/listing.dart';
import '../models/chat.dart';
import '../models/swap_request.dart';
import '../models/review.dart';

enum AuthStatus { unknown, signedOut, signedIn }
class DemoStore {
  DemoStore._();
  static final instance = DemoStore._();
  static const me = AppUser(id: 'demo-me', name: 'طالب تجريبي', email: 'demo@example.invalid');
  static const peer = AppUser(id: 'demo-peer', name: 'زميل تجريبي', email: 'peer@example.invalid');
  final updates = StreamController<void>.broadcast(sync: true);
  final Map<String, Stream<dynamic>> _streams = {};
  final users = <String, AppUser>{me.id: me, peer.id: peer};
  final favorites = <String>{'demo-book'};
  final listings = <Listing>[
    Listing(id: 'demo-book', ownerId: peer.id, ownerName: peer.name,
      title: 'كتاب جامعي تجريبي', description: 'بيانات للمعاينة فقط، وليست إعلاناً حقيقياً.',
      category: 'كتب ومراجع', condition: 'جيد', images: [], wantedInReturn: 'أدوات مكتبية',
      status: ListingStatus.available, createdAt: DateTime(2026, 1, 1)),
    Listing(id: 'demo-mine', ownerId: me.id, ownerName: me.name,
      title: 'أدوات رسم تجريبية', description: 'مثال محلي لا يتم حفظه على الإنترنت.',
      category: 'أدوات فنية وإبداعية', condition: 'كالجديد', images: [], wantedInReturn: 'كتاب',
      status: ListingStatus.available, createdAt: DateTime(2026, 1, 2)),
  ];
  final requests = <SwapRequest>[
    SwapRequest(id: 'demo-request', listingId: 'demo-book', listingTitle: 'كتاب جامعي تجريبي',
      listingImage: '', ownerId: peer.id, ownerName: peer.name, requesterId: me.id,
      requesterName: me.name, offeredListingId: 'demo-mine', offeredTitle: 'أدوات رسم تجريبية',
      offeredImage: '', message: 'طلب تجريبي للمعاينة فقط', status: SwapStatus.pending,
      createdAt: DateTime(2026, 1, 3)),
  ];
  final chats = <Chat>[
    Chat(id: 'demo-chat', requestId: 'demo-request', participantIds: [me.id, peer.id],
      participantNames: {me.id: me.name, peer.id: peer.name}, lastMessage: 'أهلاً، دي رسالة تجريبية',
      lastMessageAt: DateTime(2026, 1, 3), lastSenderId: peer.id),
  ];
  final messages = <String, List<ChatMessage>>{
    'demo-chat': [ChatMessage(id: 'demo-message', senderId: peer.id, text: 'أهلاً، دي رسالة تجريبية', createdAt: DateTime(2026, 1, 3))],
  };
  final reviews = <Review>[];
  final notifications = <AppNotification>[
    AppNotification(id: 'demo-notification', title: 'تنبيه تجريبي', body: 'البيانات هنا محلية فقط.',
      type: 'request', relatedId: 'demo-request', read: false, createdAt: DateTime(2026, 1, 3)),
  ];
  void changed() => updates.add(null);
  Stream<T> watch<T>(String key, T Function() read) => _streams.putIfAbsent(key, () =>
    Stream<T>.multi((sink) {
      sink.add(read());
      final sub = updates.stream.listen((_) => sink.add(read()));
      sink.onCancel = sub.cancel;
    }, isBroadcast: true)) as Stream<T>;
}
final _db = DemoStore.instance;
class AuthProvider extends ChangeNotifier {
  AuthStatus status = AuthStatus.signedOut;
  AppUser? profile;
  bool busy = false;
  String? error;
  String? get uid => profile?.id;
  Future<bool> signIn(String email, String password) async {
    profile = DemoStore.me;
    status = AuthStatus.signedIn;
    notifyListeners();
    return true;
  }
  Future<bool> signUp(String name, String email, String password) async {
    await signIn(email, password);
    profile = DemoStore.me.copyWith(name: name);
    _db.users[profile!.id] = profile!;
    _db.changed(); notifyListeners(); return true;
  }
  Future<bool> signInWithGoogle(String serverClientId) => signIn('', '');
  Future<bool> sendPasswordReset(String email) async => true;
  Future<void> signOut() async {profile = null;status = AuthStatus.signedOut;notifyListeners();}
}
class ListingsProvider extends ChangeNotifier {
  bool busy = false;
  String? error;
  String query = '';
  String? filterCategory;
  String? filterCondition;
  Stream<List<Listing>> watchAvailable() => _db.watch('listings', () => _db.listings.where((l) => l.status == ListingStatus.available).toList());
  Stream<List<Listing>> watchByCategory(String category) => _db.watch('category:$category', () => _db.listings.where((l) => l.category == category).toList());
  Stream<List<Listing>> watchMine(String uid) => _db.watch('my-listings:$uid', () => _db.listings.where((l) => l.ownerId == uid).toList());
  Stream<Listing?> watchOne(String id) => _db.watch('listing:$id', () => _db.listings.where((l) => l.id == id).firstOrNull);
  List<Listing> applySearch(List<Listing> all) => all.where((l) =>
    (filterCategory == null || l.category == filterCategory) &&
    (filterCondition == null || l.condition == filterCondition) &&
    ('${l.title} ${l.description}').toLowerCase().contains(query.trim().toLowerCase())).toList();
  void setQuery(String value) {query = value;notifyListeners();}
  void setFilters({String? category, String? condition}) {filterCategory = category;filterCondition = condition;notifyListeners();}
  void clearFilters() {filterCategory = null;filterCondition = null;notifyListeners();}
  Future<bool> createListing(Listing listing, List<File> photos) async {
    _db.listings.add(Listing(id: 'local-${DateTime.now().microsecondsSinceEpoch}',
      ownerId: listing.ownerId, ownerName: listing.ownerName, title: listing.title,
      description: listing.description, category: listing.category, condition: listing.condition,
      images: const [], wantedInReturn: listing.wantedInReturn, status: listing.status, createdAt: listing.createdAt));
    _db.changed(); return true;
  }
  Future<void> deleteListing(String id) async {_db.listings.removeWhere((l) => l.id == id);_db.changed();}
}
class RequestsProvider extends ChangeNotifier {
  bool busy = false;
  String? error;
  Stream<List<SwapRequest>> watchIncoming(String uid) => _db.watch('incoming:$uid', () => _db.requests.where((r) => r.ownerId == uid).toList());
  Stream<List<SwapRequest>> watchOutgoing(String uid) => _db.watch('outgoing:$uid', () => _db.requests.where((r) => r.requesterId == uid).toList());
  Stream<SwapRequest?> watchOne(String id) => _db.watch('request:$id', () => _db.requests.where((r) => r.id == id).firstOrNull);
  Future<String?> sendRequest(SwapRequest request) async {
    final id = 'local-${DateTime.now().microsecondsSinceEpoch}';
    _db.requests.add(_copy(request, request.status, id: id));_db.changed();return id;
  }
  SwapRequest _copy(SwapRequest r, SwapStatus status, {String? id}) => SwapRequest(
    id: id ?? r.id, listingId: r.listingId, listingTitle: r.listingTitle, listingImage: r.listingImage,
    ownerId: r.ownerId, ownerName: r.ownerName, requesterId: r.requesterId,
    requesterName: r.requesterName, offeredListingId: r.offeredListingId,
    offeredTitle: r.offeredTitle, offeredImage: r.offeredImage, message: r.message,
    status: status, createdAt: r.createdAt, ownerRated: r.ownerRated, requesterRated: r.requesterRated);
  void _status(SwapRequest r, SwapStatus status) {
    final i = _db.requests.indexWhere((v) => v.id == r.id);
    if(i >= 0) {_db.requests[i] = _copy(r, status);_db.changed();}
  }
  Future<void> accept(SwapRequest r) async {_status(r, SwapStatus.accepted);}
  Future<void> decline(SwapRequest r) async {_status(r, SwapStatus.declined);}
  Future<void> cancel(String id) async {final r = _db.requests.where((v) => v.id == id).firstOrNull;if(r != null) {_status(r, SwapStatus.cancelled);}}
  Future<void> complete(SwapRequest r) async {_status(r, SwapStatus.completed);}
}
class ChatProvider extends ChangeNotifier {
  Stream<List<Chat>> watchMine(String uid) => _db.watch('chats:$uid', () => _db.chats.where((c) => c.participantIds.contains(uid)).toList());
  Stream<List<ChatMessage>> watchMessages(String chatId) => _db.watch('messages:$chatId', () => List<ChatMessage>.of(_db.messages[chatId] ?? []));
  Future<Chat?> findByRequest(String requestId) async => _db.chats.where((c) => c.id == requestId || c.requestId == requestId).firstOrNull;
  Future<Chat> getOrCreateChat({required String requestId, required String ownerId, required String ownerName, required String requesterId, required String requesterName}) async =>
    _create(requestId, requestId, ownerId, ownerName, requesterId, requesterName);
  Future<Chat> getOrCreateDirectChat({required String myId, required String myName, required String otherId, required String otherName}) async =>
    _create('direct-${([myId, otherId]..sort()).join('-')}', '', myId, myName, otherId, otherName);
  Chat _create(String id, String requestId, String a, String an, String b, String bn) {
    final old = _db.chats.where((c) => c.id == id).firstOrNull;
    if(old != null) {return old;}
    final c = Chat(id: id, requestId: requestId, participantIds: [a,b], participantNames: {a:an,b:bn}, lastMessage: '', lastMessageAt: DateTime.now());
    _db.chats.add(c);_db.changed();return c;
  }
  Future<void> markRead(String chatId, String uid, DateTime seenAt) async {}
  Future<void> send(String chatId, String senderId, String text) async {
    (_db.messages[chatId] ??= []).add(ChatMessage(id: 'local-${DateTime.now().microsecondsSinceEpoch}', senderId: senderId, text: text, createdAt: DateTime.now()));
    _db.changed();
  }
}
class ProfileProvider extends ChangeNotifier {
  Stream<int> watchCompletedSwapCount(String uid) => _db.watch('completed:$uid', () => _db.requests.where((r) => r.status == SwapStatus.completed && (r.ownerId == uid || r.requesterId == uid)).length);
  Stream<AppUser?> watchUser(String uid) => _db.watch('user:$uid', () => _db.users[uid]);
  Stream<Set<String>> watchFavoriteIds(String uid) => _db.watch('favorites:$uid', () => Set<String>.of(_db.favorites));
  Stream<List<Review>> watchReviewsFor(String uid) => _db.watch('reviews:$uid', () => _db.reviews.where((r) => r.targetUserId == uid).toList());
  Stream<List<AppNotification>> watchNotifications(String uid) => _db.watch('notifications:$uid', () => List<AppNotification>.of(_db.notifications));
  Future<void> toggleFavorite(String uid, String listingId, bool isFav) async {
    if(isFav) {_db.favorites.remove(listingId);} else {_db.favorites.add(listingId);}_db.changed();
  }
  Future<void> updateProfile(String uid, Map<String,dynamic> fields) async {
    final user = _db.users[uid];if(user == null) {return;}
    _db.users[uid] = user.copyWith(name: fields['name'], phone: fields['phone'], bio: fields['bio'], photoUrl: fields['photoUrl']);_db.changed();
  }
  Future<void> addReview(Review review) async {_db.reviews.add(review);_db.changed();}
  Future<void> markNotificationRead(String uid, String id) async {}
}
