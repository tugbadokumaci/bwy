import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  int userId;
  String userName;
  String userSurname;
  int userBalance;
  String userEmail;
  String userPassword;

  UserModel(
      {required this.userId,
      required this.userName,
      required this.userSurname,
      required this.userBalance,
      required this.userEmail,
      required this.userPassword});

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
