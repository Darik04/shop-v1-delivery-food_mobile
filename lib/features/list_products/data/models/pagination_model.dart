
import 'package:shopv1deliveryfood_mobile/features/address/data/models/city_model.dart';
import 'package:shopv1deliveryfood_mobile/features/home/domain/entities/category_entity.dart';
import 'package:shopv1deliveryfood_mobile/features/list_products/domain/entities/pagination_entity.dart';

class PaginationModel extends PaginaitonEntity{
  PaginationModel({
    String? nextUrl, 
    String? prevUrl,
    int? count,
    required List<dynamic> results 
  }) : super(
    nextUrl: nextUrl,
    prevUrl: prevUrl,
    count: count,
    results: results
  );

  factory PaginationModel.fromJson(Map<String, dynamic> json) => PaginationModel(
    nextUrl: json['links']['next'],
    prevUrl: json['links']['previous'],
    count: json['count'],
    results: []
    
  );
}