

import 'package:shopv1deliveryfood_mobile/features/address/domain/entities/address_entity.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/domain/entities/user_entity.dart';

getCheckedAddress(UserEntity userEntity){
  String address = '';
  if(userEntity.city != null){
    address = userEntity.city!.name;
  }
  if(userEntity.street != null && userEntity.street != ''){
    address += (userEntity.city != null 
      ? ', ${userEntity.street}' 
      : userEntity.street)!;
  }
  if(userEntity.homeNumber != null && userEntity.homeNumber != ''){
    address += (userEntity.city != null || userEntity.street != null 
      ? ' ${userEntity.homeNumber}' 
      : userEntity.homeNumber)!;
  }
  return address;  
}

getCheckedAddressFromAddress(AddressEntity addressEntity){
  String address = '';
  if(addressEntity.city != null){
    address = addressEntity.city!.name;
  }
  if(addressEntity.street != null && addressEntity.street != ''){
    address += (addressEntity.city != null 
      ? ', ${addressEntity.street}' 
      : addressEntity.street);
  }
  if(addressEntity.homeNumber != null && addressEntity.homeNumber != ''){
    address += (addressEntity.city != null || addressEntity.street != null 
      ? ' ${addressEntity.homeNumber}' 
      : addressEntity.homeNumber);
  }
  return address;  
}