import 'dart:io';

import 'package:equatable/equatable.dart';

class CityEntity extends Equatable {
  final int id;
  final String name;
  final int code;
  CityEntity(
      {required this.id,
      required this.name,
      required this.code
      });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'code': code
    };
  }

  @override
  List<Object> get props => [
        id,
        name,
        code
      ];
}
