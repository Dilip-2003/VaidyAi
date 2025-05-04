class VaidyaiUser {
  final String email;
  final String name;
  final String phone;

  VaidyaiUser({
    required this.email,
    required this.name,
    required this.phone,
  });

  factory VaidyaiUser.fromJson(Map<String, dynamic> json) {
    return VaidyaiUser(
      email: json['email'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
    );
  }
}
