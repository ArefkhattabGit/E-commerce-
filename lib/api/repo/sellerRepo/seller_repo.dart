import 'package:final_poject_sw_engineering/api/apiResponse/api_response.dart';
import 'package:final_poject_sw_engineering/model/TSellerCreateProduct.dart';
import 'package:final_poject_sw_engineering/model/TUpdate.dart';

import '../../../model/TSellerShowProduct.dart';

abstract class SellerRepo{

  Future<BaseApiResponse<TSellerCreateProduct>> postCreateProduct({required Map<String,dynamic> body});
  Future<BaseApiResponse<TSellerShowSellerProduct>> getSellerProductsPublished();
  Future<BaseApiResponse> deleteSellerProductsPublished(int id);
  Future<BaseApiResponse<TUpdate>> UpdateProd({required int productId,required Map<String,dynamic> body});

 }