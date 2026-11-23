// UI-only data contract. Replaced by production model in stage 06.

enum SwapStatus { pending, accepted, declined, completed, cancelled }

class SwapRequest {
  final String id;

  // The listing being asked for.
  final String listingId;
  final String listingTitle;
  final String listingImage;
  final String ownerId;
  final String ownerName;

  // The requester and the item they offer in return.
  final String requesterId;
  final String requesterName;
  final String offeredListingId;
  final String offeredTitle;
  final String offeredImage;

  final String message;
  final SwapStatus status;
  final DateTime createdAt;

    final bool ownerRated;
  final bool requesterRated;

  const SwapRequest({
    required this.id,
    required this.listingId,
    required this.listingTitle,
    required this.listingImage,
    required this.ownerId,
    required this.ownerName,
    required this.requesterId,
    required this.requesterName,
    required this.offeredListingId,
    required this.offeredTitle,
    required this.offeredImage,
    required this.message,
    required this.status,
    required this.createdAt,
    this.ownerRated = false,
    this.requesterRated = false,
  });



  Map<String, dynamic> toMap() => {
    'listingId': listingId,
    'listingTitle': listingTitle,
    'listingImage': listingImage,
    'ownerId': ownerId,
    'ownerName': ownerName,
    'requesterId': requesterId,
    'requesterName': requesterName,
    'offeredListingId': offeredListingId,
    'offeredTitle': offeredTitle,
    'offeredImage': offeredImage,
    'message': message,
    'status': status.name,
    'createdAt': createdAt,
    'ownerRated': ownerRated,
    'requesterRated': requesterRated,
  };
}
