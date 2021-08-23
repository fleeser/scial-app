class UserModel {
  final String? imageUrl;

  const UserModel({ this.imageUrl });

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(imageUrl: map['image']);
}