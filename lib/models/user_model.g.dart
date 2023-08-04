// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      userId: json['userId'] as int,
      userName: json['userName'] as String,
      userSurname: json['userSurname'] as String,
      userBalance: json['userBalance'] as int,
      userEmail: json['userEmail'] as String,
      userPassword: json['userPassword'] as String,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'userSurname': instance.userSurname,
      'userBalance': instance.userBalance,
      'userEmail': instance.userEmail,
      'userPassword': instance.userPassword,
    };
