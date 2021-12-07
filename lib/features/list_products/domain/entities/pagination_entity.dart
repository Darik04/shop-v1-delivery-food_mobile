import 'package:equatable/equatable.dart';

class PaginaitonEntity extends Equatable {
  String? nextUrl; 
  String? prevUrl; 
  int? count;
  List<dynamic> results;

  PaginaitonEntity( {
    this.nextUrl,
    this.prevUrl,
    this.count,
    required this.results,
    
  });

  @override
  List<Object> get props => [
    results
  ];
}
