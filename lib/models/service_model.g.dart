// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceModel _$ServiceModelFromJson(Map<String, dynamic> json) => ServiceModel(
      productId: json['productId'] as int,
      userId: json['userId'] as int,
      domainName: json['domainName'] as String,
      productType: json['productType'] as String,
      cycle: json['cycle'] as String,
      finishDate: DateTime.parse(json['finishDate'] as String),
    );

Map<String, dynamic> _$ServiceModelToJson(ServiceModel instance) => <String, dynamic>{
      'productId': instance.productId,
      'userId': instance.userId,
      'domainName': instance.domainName,
      'productType': instance.productType,
      'cycle': instance.cycle,
      'finishDate': instance.finishDate.toIso8601String(),
    };
