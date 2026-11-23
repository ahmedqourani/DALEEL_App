// UI-only data contract. Replaced by production model in stage 06.

enum ListingStatus { available, swapped }

class Listing {
  final String id;
  final String ownerId;
  final String ownerName;
  final String title;
  final String description;
  final String category;
  final String condition; // New / Like new / Good / Fair
  final List<String> images;

    final String wantedInReturn;

  final ListingStatus status;
  final DateTime createdAt;

  const Listing({
    required this.id,
    required this.ownerId,
    required this.ownerName,
    required this.title,
    required this.description,
    required this.category,
    required this.condition,
    required this.images,
    required this.wantedInReturn,
    required this.status,
    required this.createdAt,
  });



  Map<String, dynamic> toMap() => {
    'ownerId': ownerId,
    'ownerName': ownerName,
    'title': title,
    // Lowercase copy used by the search screen (Firestore has no ILIKE).
    'titleLower': title.toLowerCase(),
    'description': description,
    'category': category,
    'condition': condition,
    'images': images,
    'wantedInReturn': wantedInReturn,
    'status': status.name,
    'createdAt': createdAt,
  };
}
