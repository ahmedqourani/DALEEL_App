// UI-only data contract. Replaced by production model in stage 06.

class Review {
  final String id;
  final String targetUserId;
  final String authorId;
  final String authorName;
  final int rating; // 1-5 stars
  final String comment;
  final String requestId;
  final DateTime createdAt;

  const Review({
    required this.id,
    required this.targetUserId,
    required this.authorId,
    required this.authorName,
    required this.rating,
    required this.comment,
    required this.requestId,
    required this.createdAt,
  });



  Map<String, dynamic> toMap() => {
    'targetUserId': targetUserId,
    'authorId': authorId,
    'authorName': authorName,
    'rating': rating,
    'comment': comment,
    'requestId': requestId,
    'createdAt': createdAt,
  };
}

class AppNotification {
  final String id;
  final String title;
  final String body;

    final String type;

    final String relatedId;
  final bool read;
  final DateTime createdAt;

  const AppNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.relatedId,
    required this.read,
    required this.createdAt,
  });


}
