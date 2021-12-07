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
import 'package:shopv1deliveryfood_mobile/features/cart/domain/usecases/clear_cart.dart';
import 'package:shopv1deliveryfood_mobile/features/cart/domain/usecases/delete_from_cart.dart';
import 'package:shopv1deliveryfood_mobile/features/favorites/domain/usecases/add_to_favorite.dart';
import 'package:shopv1deliveryfood_mobile/features/favorites/domain/usecases/get_favorite_products.dart';
import 'package:shopv1deliveryfood_mobile/features/home/domain/usecases/get_home_products.dart';
import 'package:shopv1deliveryfood_mobile/features/home/presentation/bloc/home/home_bloc.dart';
import 'package:shopv1deliveryfood_mobile/features/list_products/domain/usecases/get_products.dart';
import 'package:shopv1deliveryfood_mobile/features/main/presentation/bloc/main_screen/main_screen_bloc.dart';
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
import 'features/cart/data/datasources/cart/remote_datasource.dart';
import 'features/cart/data/repositories/cart_repository_impl.dart';
import 'features/cart/domain/repositories/login/cart_repository.dart';
import 'features/cart/domain/usecases/add_to_cart.dart';
import 'features/cart/domain/usecases/get_cart_products.dart';
import 'features/cart/presentation/bloc/cart/cart_bloc.dart';
import 'features/favorites/data/datasources/list_products/remote_datasource.dart';
import 'features/favorites/data/repositories/favorite_products_repository_impl.dart';
import 'features/favorites/domain/repositories/login/favorite_products_repository.dart';
import 'features/favorites/domain/usecases/delete_from_favorite.dart';
import 'features/favorites/presentation/bloc/favorite/favorite_bloc.dart';
import 'features/home/data/datasources/login/remote_datasource.dart';
import 'features/home/data/repositories/home_repository_impl.dart';
import 'features/home/domain/repositories/login/home_repository.dart';
import 'features/home/domain/usecases/get_categories.dart';
import 'features/list_products/data/datasources/list_products/remote_datasource.dart';
import 'features/list_products/data/repositories/list_products_repository_impl.dart';
import 'features/list_products/domain/repositories/login/list_products_repository.dart';
import 'features/list_products/presentation/bloc/list_products/list_products_bloc.dart';
import 'features/profile/data/datasources/profile/remote_datasource.dart';
import 'features/profile/data/repositories/profile_repository_impl.dart';
import 'features/profile/domain/repositories/profile/profile_repository.dart';
import 'features/profile/presentation/bloc/profile/profile_bloc.dart';
import 'features/promotions/data/datasources/promo/remote_datasource.dart';
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




  //Main Screen 
  //Blocs
  sl.registerFactory<MainScreenBloc>(
    () => MainScreenBloc(),
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








  // List products
  //Datasources
  sl.registerLazySingleton<ListProductsRemoteDataSource>(
    () => ListProductsRemoteDataSourceImpl(dio: sl()),
  );

  //Repositories
  sl.registerLazySingleton<ListProductsRepository>(
    () => ListProductsRepositoryImpl(sl(), sl()),
  );

  //UseCases
  sl.registerLazySingleton(() => GetProducts(sl()));

  //Blocs
  sl.registerFactory<ListProductsBloc>(
    () => ListProductsBloc(sl()),
  );




  // Favorite 
  //Datasources
  sl.registerLazySingleton<FavoriteProductsRemoteDataSource>(
    () => FavoriteProductsRemoteDataSourceImpl(dio: sl()),
  );

  //Repositories
  sl.registerLazySingleton<FavoriteProductsRepository>(
    () => FavoriteProductsRepositoryImpl(sl(), sl()),
  );

  //UseCases
  sl.registerLazySingleton(() => GetFavoriteProducts(sl()));
  sl.registerLazySingleton(() => AddToFavorite(sl()));
  sl.registerLazySingleton(() => DeleteFromFavorite(sl()));

  //Blocs
  sl.registerFactory<FavoriteBloc>(
    () => FavoriteBloc(sl(), sl(), sl()),
  );











  // Cart 
  //Datasources
  sl.registerLazySingleton<CartRemoteDataSource>(
    () => CartRemoteDataSourceImpl(dio: sl()),
  );

  //Repositories
  sl.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(sl(), sl()),
  );

  //UseCases
  sl.registerLazySingleton(() => GetCartProducts(sl()));
  sl.registerLazySingleton(() => AddToCart(sl()));
  sl.registerLazySingleton(() => DeleteFromCart(sl()));
  sl.registerLazySingleton(() => ClearCart(sl()));

  //Blocs
  sl.registerFactory<CartBloc>(
    () => CartBloc(sl(), sl(), sl(), sl()),
  );
}
