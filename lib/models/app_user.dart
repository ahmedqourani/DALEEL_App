// UI-only data contract. Replaced by production model in stage 06.

class AppUser {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String bio;
  final String photoUrl;

    final double ratingAvg;
  final int ratingCount;

  const AppUser({
    required this.id,
    required this.name,
    required this.email,
    this.phone = '',
    this.bio = '',
    this.photoUrl = '',
    this.ratingAvg = 0,
    this.ratingCount = 0,
  });

  

    Map<String, dynamic> toMap() => {
    'name': name,
    'email': email,
    'phone': phone,
    'bio': bio,
    'photoUrl': photoUrl,
    'ratingAvg': ratingAvg,
    'ratingCount': ratingCount,
  };

    AppUser copyWith({
    String? name,
    String? phone,
    String? bio,
    String? photoUrl,
  }) {
    return AppUser(
      id: id,
      name: name ?? this.name,
      email: email,
      phone: phone ?? this.phone,
      bio: bio ?? this.bio,
      photoUrl: photoUrl ?? this.photoUrl,
      ratingAvg: ratingAvg,
      ratingCount: ratingCount,
    );
  }
}
