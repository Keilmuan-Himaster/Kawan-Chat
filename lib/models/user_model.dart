class UserModel {
  String uid, phoneNumber, firstName, lastName, imageUrl;

  UserModel(
      {required this.uid,
      required this.phoneNumber,
      required this.firstName,
      required this.lastName,
      required this.imageUrl});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      uid: json['uid'] ?? "",
      phoneNumber: json['phone_number'] ?? "",
      firstName: json['first_name'] ?? "",
      lastName: json['last_name'] ?? "",
      imageUrl: json['image_url'] ?? "");

  Map<String, dynamic> toJson() => {
        "phone_number": phoneNumber,
        "first_name": firstName.toLowerCase(),
        "last_name": lastName.toLowerCase(),
        "image_url": imageUrl
      };
}
