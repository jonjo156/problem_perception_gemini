class UserModel {
  final String uid;
  final String email;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? gender;
  final String? dateOfBirth;

  UserModel({
    required this.uid,
    required this.email,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.gender,
    this.dateOfBirth,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phoneNumber: json['phoneNumber'],
    );
  }
}
