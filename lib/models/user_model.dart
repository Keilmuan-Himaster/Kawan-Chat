class UserModel {
  String uid, phoneNumber, firstName, lastName, imageUrl, fullName;

  UserModel(
      {required this.uid,
      required this.phoneNumber,
      required this.firstName,
      required this.fullName,
      required this.lastName,
      required this.imageUrl});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      uid: json['uid'] ?? "",
      phoneNumber: json['phone_number'] ?? "",
      firstName: json['first_name'] ?? "",
      lastName: json['last_name'] ?? "",
      fullName: json['full_name'] ?? "",
      imageUrl: json['image_url'] ?? "");

  Map<String, dynamic> toJson() => {
        "phone_number": phoneNumber,
        "uid": uid,
        "first_name": firstName.toLowerCase(),
        "last_name": lastName.toLowerCase(),
        "image_url": imageUrl,
        "full_name": fullName.toLowerCase()
      };
}

final UserModel userMock = UserModel(
    uid: "1",
    phoneNumber: "08008080",
    firstName: "Saya",
    fullName: "Saya",
    lastName: "",
    imageUrl:
        "https://firebasestorage.googleapis.com/v0/b/chat-app-18b71.appspot.com/o/images%2Fimage_picker2658158406564520688.png?alt=media&token=16e35178-910b-43f8-9dcc-94c452a40213");
