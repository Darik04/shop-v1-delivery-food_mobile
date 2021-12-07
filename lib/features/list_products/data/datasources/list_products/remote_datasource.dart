import 'package:dio/dio.dart';
import 'package:shopv1deliveryfood_mobile/core/error/exceptions.dart';
import 'package:shopv1deliveryfood_mobile/core/services/database/auth_params.dart';
import 'package:shopv1deliveryfood_mobile/core/services/network/endpoints.dart';
import 'package:shopv1deliveryfood_mobile/features/home/data/models/product_model.dart';
import 'package:shopv1deliveryfood_mobile/features/home/domain/entities/product_entity.dart';
import 'package:shopv1deliveryfood_mobile/features/list_products/data/models/pagination_model.dart';
import 'package:shopv1deliveryfood_mobile/features/list_products/domain/entities/pagination_entity.dart';
import 'package:shopv1deliveryfood_mobile/features/list_products/domain/enums/sort_enum.dart';

import '../../../../../locator.dart';

abstract class ListProductsRemoteDataSource {
  Future<PaginaitonEntity> getListProducts(int? categoryId, int page, SortByEnum sortByEnum);

}

class ListProductsRemoteDataSourceImpl
    implements ListProductsRemoteDataSource {
  final Dio dio;

  ListProductsRemoteDataSourceImpl({required this.dio});
  Map<String, String> headers = {
    "Accept": "application/json",
    "Content-Type": "application/json",
    
  };


  //Get product 
  @override
  Future<PaginaitonEntity> getListProducts(int? categoryId, int page, SortByEnum sortByEnum) async {
    print('Category: ${categoryId}');

    if(sl<AuthConfig>().token != null){
      headers.addAll({"Authorization": "Token ${sl<AuthConfig>().token}"});
    }

    //sorting
    String sort = '';
    if(sortByEnum == SortByEnum.priceUp)
      sort = 'price_up';
    else if(sortByEnum == SortByEnum.priceDown)
      sort = 'price_down';
    else
      sort = 'created_at';


    Response response = await dio.get(categoryId != null 
                                        ? Endpoints.getProductsByCategoryId.getPath(params: [categoryId, page, sort])
                                        : Endpoints.getHomeProducts.getPath(params: [page, sort]),
        options: Options(
            followRedirects: false,
            validateStatus: (status) => status! < 499,
            headers: headers));
    if (response.statusCode == 200) {
      List<ProductEntity> items = (response.data['results'] as List)
            .map((json) => ProductModel.fromJson(json))
            .toList();
      PaginaitonEntity paginaiton = PaginationModel.fromJson(response.data);

      paginaiton.results = items;
      return paginaiton;
    } else if(response.statusCode == 400){
      throw ServerException(message: response.data['detail']);
    } else if(response.statusCode == 404){
      return PaginaitonEntity(results: [], prevUrl: null, nextUrl: null);
    } else {
      throw ServerException(message: 'Ошибка с сервером');
    }
  }






}
