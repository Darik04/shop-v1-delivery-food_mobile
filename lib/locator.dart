import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shopv1deliveryfood_mobile/core/services/database/auth_params.dart';
import 'package:shopv1deliveryfood_mobile/core/services/network/network_info.dart';
import 'package:shopv1deliveryfood_mobile/features/address/data/datasources/remote_datasource.dart';
import 'package:shopv1deliveryfood_mobile/features/address/domain/repositories/city_repository.dart';
import 'package:shopv1deliveryfood_mobile/features/address/domain/usecases/get_cities.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/data/datasources/login/local_datasource.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/domain/usecases/get_token_local.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/domain/usecases/get_user_info.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/domain/usecases/logout.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/domain/usecases/send_sms.dart';
import 'package:shopv1deliveryfood_mobile/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:shopv1deliveryfood_mobile/features/home/domain/usecases/get_home_products.dart';
import 'package:shopv1deliveryfood_mobile/features/home/presentation/bloc/home/home_bloc.dart';
import 'package:shopv1deliveryfood_mobile/features/profile/domain/usecases/send_code_for_change_phone.dart';
import 'package:shopv1deliveryfood_mobile/features/profile/domain/usecases/update_phone.dart';
import 'package:shopv1deliveryfood_mobile/features/profile/domain/usecases/update_user_info.dart';
import 'package:shopv1deliveryfood_mobile/features/profile/presentation/bloc/change_number/change_number_bloc.dart';
import 'package:shopv1deliveryfood_mobile/features/promotions/data/repositories/promotions_repository_impl.dart';

import 'core/services/network/config.dart';
import 'features/address/data/repositories/login_repository_impl.dart';
import 'features/address/presentation/bloc/city/city_bloc.dart';
import 'features/auth/data/datasources/login/remote_datasource.dart';
import 'features/auth/data/repositories/login_repository_impl.dart';
import 'features/auth/domain/repositories/login/login_repository.dart';
import 'features/auth/domain/usecases/auth_signin.dart';
import 'features/auth/domain/usecases/register.dart';
import 'features/home/data/datasources/login/remote_datasource.dart';
import 'features/home/data/repositories/home_repository_impl.dart';
import 'features/home/domain/repositories/login/home_repository.dart';
import 'features/home/domain/usecases/get_categories.dart';
import 'features/profile/data/datasources/profile/remote_datasource.dart';
import 'features/profile/data/repositories/profile_repository_impl.dart';
import 'features/profile/domain/repositories/profile/profile_repository.dart';
import 'features/profile/presentation/bloc/profile/profile_bloc.dart';
import 'features/promotions/data/datasources/login/remote_datasource.dart';
import 'features/promotions/domain/repositories/login/promotions_repository.dart';
import 'features/promotions/domain/usecases/get_promotions.dart';
import 'features/promotions/presentation/bloc/promotions/promotions_bloc.dart';

final sl = GetIt.instance;

void setupInjections() {

  //! External
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  sl.registerFactory<Dio>(
    () => Dio(BaseOptions(
      baseUrl: Config.url.url,
    )),
  );
  ///Authentication
  sl.registerLazySingleton<AuthConfig>(() => AuthConfig());
  //Datasources
  sl.registerLazySingleton<AuthenticationRemoteDataSource>(
    () => AuthenticationRemoteDataSourceImpl(dio: sl()),
  );
  sl.registerLazySingleton<AuthenticationLocalDataSource>(
    () => AuthenticationLocalDataSourceImpl(),
  );

  //Repositories
  sl.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(sl(), sl(), sl()),
  );

  //UseCases
  sl.registerLazySingleton(() => AuthSignIn(sl()));
  sl.registerLazySingleton(() => SendSMS(sl()));
  sl.registerLazySingleton(() => GetUserInfo(sl()));
  sl.registerLazySingleton(() => GetTokenLocal(sl()));
  sl.registerLazySingleton(() => Logout(sl()));
  sl.registerLazySingleton(() => Register(sl()));

  //Blocs
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(sl(), sl(), sl(), sl(), sl(), sl()),
  );





  // Cities
  //Datasources
  sl.registerLazySingleton<CityRemoteDataSource>(
    () => CityRemoteDataSourceImpl(dio: sl()),
  );

  //Repositories
  sl.registerLazySingleton<CityRepository>(
    () => CityRepositoryImpl(sl(), sl()),
  );

  //UseCases
  sl.registerLazySingleton(() => GetAllCities(sl()));

  //Blocs
  sl.registerFactory<CityBloc>(
    () => CityBloc(sl()),
  );



  // Home
  //Datasources
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(dio: sl()),
  );

  //Repositories
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(sl(), sl()),
  );

  //UseCases
  sl.registerLazySingleton(() => GetCategories(sl()));
  sl.registerLazySingleton(() => GetHomeProductsWithPagination(sl()));

  //Blocs
  sl.registerFactory<HomeBloc>(
    () => HomeBloc(sl(), sl()),
  );






  // Promotions
  //Datasources
  sl.registerLazySingleton<PromotionsRemoteDataSource>(
    () => PromotionsRemoteDataSourceImpl(dio: sl()),
  );

  //Repositories
  sl.registerLazySingleton<PromotionsRepository>(
    () => PromotionsRepositoryImpl(sl(), sl()),
  );

  //UseCases
  sl.registerLazySingleton(() => GetPromotionsWithPagination(sl()));

  //Blocs
  sl.registerFactory<PromotionsBloc>(
    () => PromotionsBloc(sl()),
  );




  // Profile and change phone
  //Datasources
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(dio: sl()),
  );

  //Repositories
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(sl(), sl()),
  );

  //UseCases
  sl.registerLazySingleton(() => UpdateUserInfo(sl()));
  sl.registerLazySingleton(() => SendCodeForChangePhone(sl()));
  sl.registerLazySingleton(() => UpdatePhoneNumber(sl()));

  //Blocs
  sl.registerFactory<ProfileBloc>(
    () => ProfileBloc(sl()),
  );
  sl.registerFactory<ChangeNumberBloc>(
    () => ChangeNumberBloc(sl(), sl()),
  );
}
