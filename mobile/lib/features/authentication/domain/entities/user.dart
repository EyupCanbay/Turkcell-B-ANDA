class User {
  final int id;
  final String name;
  final String email;
  final String? city;
  final String? university;
  final String? skillLevel;

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.city,
    this.university,
    this.skillLevel,
  });
}
