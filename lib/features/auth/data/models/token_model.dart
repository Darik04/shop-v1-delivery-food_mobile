
import 'package:shopv1deliveryfood_mobile/features/auth/domain/entities/token_entity.dart';

class TokenModel extends TokenEntity{
  TokenModel({
    required String token,
    required bool registered,

  }) : super(token, registered);

  factory TokenModel.fromJson(Map<String, dynamic> json) => TokenModel(
    token: json['token'],
    registered: json['registered'],

  );
}