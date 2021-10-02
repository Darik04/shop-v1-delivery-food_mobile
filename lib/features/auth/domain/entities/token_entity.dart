import 'package:equatable/equatable.dart';

class TokenEntity extends Equatable {
  final bool registered;
  final String token;

  TokenEntity(this.token, this.registered);

  @override
  List<Object> get props => [token, registered];
}
