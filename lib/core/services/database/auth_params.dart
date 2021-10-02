

import 'package:shopv1deliveryfood_mobile/features/auth/domain/entities/user_entity.dart';

enum AuthenticatedOption {
  unauthenticated, 
  authenticated
}

extension AuthenticatedOptionExtension on AuthenticatedOption {
  String get key {
    switch (this) {
      case AuthenticatedOption.unauthenticated:
        return 'unauthenticated';
      case AuthenticatedOption.authenticated:
        return 'authenticated';
    }
  }
}

class AuthConfig {
  String? token;
  String? phone;
  UserEntity? userEntity;
  AuthenticatedOption? authenticatedOption;
  
  AuthConfig({
    this.token, 
    this.userEntity, 
    this.phone,
    this.authenticatedOption
  });
}
