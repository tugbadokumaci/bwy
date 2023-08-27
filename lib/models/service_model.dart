import 'package:json_annotation/json_annotation.dart';

part 'service_model.g.dart';

@JsonSerializable()
class ServiceModel {
  int productId;
  int userId;
  String domainName;
  String productType;
  String cycle;
  DateTime finishDate;
  int price;

  ServiceModel(
      {required this.productId,
      required this.userId,
      required this.domainName,
      required this.productType,
      required this.cycle,
      required this.finishDate,
      required this.price});

  factory ServiceModel.fromJson(Map<String, dynamic> json) => _$ServiceModelFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceModelToJson(this);
}
