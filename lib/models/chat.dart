// UI-only data contract. Replaced by production model in stage 06.

class Chat {
  final String id;
  final String requestId;
  final List<String> participantIds;

    final Map<String, String> participantNames;

  final String lastMessage;
  final DateTime lastMessageAt;
  final String lastSenderId;
  final Map<String, DateTime> readAt;

    String? peerIdFor(String viewerUid) => viewerUid.isEmpty
      ? null
      : participantIds
            .where((id) => id.isNotEmpty && id != viewerUid)
            .firstOrNull;

  String peerSavedNameFor(String viewerUid) =>
      participantNames[peerIdFor(viewerUid)]?.trim() ?? '';

  bool isUnreadFor(String uid) =>
      uid.isNotEmpty &&
      lastMessage.isNotEmpty &&
      lastSenderId.isNotEmpty &&
      lastSenderId != uid &&
      (readAt[uid] == null || lastMessageAt.isAfter(readAt[uid]!));

  const Chat({
    required this.id,
    required this.requestId,
    required this.participantIds,
    required this.participantNames,
    required this.lastMessage,
    required this.lastMessageAt,
    this.lastSenderId = '',
    this.readAt = const {},
  });



  Map<String, dynamic> toMap() => {
    'requestId': requestId,
    'participantIds': participantIds,
    'participantNames': participantNames,
    'lastMessage': lastMessage,
    'lastMessageAt': lastMessageAt,
  };
}

class ChatMessage {
  final String id;
  final String senderId;
  final String text;
  final DateTime createdAt;

  const ChatMessage({
    required this.id,
    required this.senderId,
    required this.text,
    required this.createdAt,
  });


}
