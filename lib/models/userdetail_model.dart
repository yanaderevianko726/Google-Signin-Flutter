
class UserDetail {
  String? userId;
  String? firstName;
  String? lastName;
  String? username;
  String? email;
  String? password;
  String? mobile;
  String? age;
  String? gender;
  String? image;
  String? address;
  String? city;
  String? country;
  String? state;

  UserDetail({
    this.userId = '',
    this.firstName = '',
    this.lastName = '',
    this.username = '',
    this.email = '',
    this.password = '',
    this.mobile = '',
    this.age = '',
    this.gender = '',
    this.image = '',
    this.address = '',
    this.city = '',
    this.country = '',
    this.state = '',
  });

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
    userId: json["userId"] ?? '',
    firstName: json["firstName"] ?? '',
    lastName: json["lastName"] ?? '',
    username: json["username"] ?? '',
    email: json["email"] ?? '',
    password: json["password"] ?? '',
    mobile: json["mobile"] ?? '',
    age: json["age"] ?? '',
    gender: json["gender"] ?? '',
    image: json["image"],
    address: json["address"] ?? '',
    city: json["city"] ?? '',
    country: json["country"] ?? '',
    state: json["state"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "firstName": firstName,
    "lastName": lastName,
    "username": username,
    "email": email,
    "password": password,
    "mobile": mobile,
    "age": age,
    "gender": gender,
    "image": image,
    "address": address,
    "city": city,
    "country": country,
    "state": state,
  };
}

