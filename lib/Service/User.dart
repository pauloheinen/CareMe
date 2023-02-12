class User {
  final int? id;
  final String username;
  final String? name;
  final String? password;
  final String? email;
  final String? cellphone;
  final String? about;
  final bool? caregiver;
  final String? image;

  const User({
    required this.id,
    required this.username,
    required this.name,
    required this.password,
    required this.email,
    required this.cellphone,
    required this.about,
    required this.caregiver,
    required this.image,
  });


  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      name: json['name'],
      password: json['password'],
      email: json['email'],
      cellphone: json['cellphone'],
      about: json['about'],
      caregiver: json['caregiver'],
      image: json['image'].toString(),
    );
  }

  Map<String, dynamic> toJson()
  {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['username'] = username;
    data['name'] = name;
    data['password'] = password;
    data['email'] = email;
    data['cellphone'] = cellphone;
    data['about'] = about;
    data['caregiver'] = caregiver;
    data['image'] = image.toString();

    return data;
  }
}
