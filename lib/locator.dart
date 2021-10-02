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

import 'core/services/network/config.dart';
import 'features/address/data/repositories/login_repository_impl.dart';
import 'features/address/presentation/bloc/city_bloc.dart';
import 'features/auth/data/datasources/login/remote_datasource.dart';
import 'features/auth/data/repositories/login_repository_impl.dart';
import 'features/auth/domain/repositories/login/login_repository.dart';
import 'features/auth/domain/usecases/auth_signin.dart';

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

  //Blocs
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(sl(), sl(), sl(), sl(), sl()),
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
}
