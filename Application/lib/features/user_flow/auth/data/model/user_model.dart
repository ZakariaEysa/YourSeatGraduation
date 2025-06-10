import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0) // Ensure the typeId is unique within your app
class UserModel extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String email;

  @HiveField(2)
  String password;

  @HiveField(3)
  String dateOfBirth;

  @HiveField(4)
  String? image;
  @HiveField(5)
  final String? gender; // Optional, sourced from photoURL in Firebase
  @HiveField(6)
  final String? location; // Optional, sourced from photoURL in Firebase

  UserModel({
    required this.name,
    required this.email,
    required this.password,
    required this.dateOfBirth,
    this.image,
    this.gender,
    this.location,
  });

  @override
  String toString() {
    return 'UserModel(name: $name, email: $email, password: $password, dateOfBirth: $dateOfBirth, image: $image, gender: $gender, location: $location)';
  }
}
