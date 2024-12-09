import 'dart:core';
import 'package:json_annotation/json_annotation.dart';
part 'expanses.g.dart';

@JsonSerializable(explicitToJson: true)
class Expanses {
  @JsonKey(name: '_id')
  String? id;
  String authorId;
  String name;
  String? description;
  double amount;
  String currency;
  String? placeOfPurchase;
  String category;

  Expanses({
    this.id,
    required this.authorId,
    required this.name,
    this.description,
    required this.amount,
    required this.currency,
    this.placeOfPurchase,
    required this.category,
  });

  factory Expanses.fromJson(Map<String, dynamic> json) {
    return _$ExpansesFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ExpansesToJson(this);
}
