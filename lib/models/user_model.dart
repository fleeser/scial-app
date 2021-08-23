class UserModel {
  final String? imageUrl;
  final List<String> events;

  const UserModel({ 
    this.imageUrl,
    required this.events
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      imageUrl: map['image'],
      events: List<String>.from(map['events'])
    );
  }
}