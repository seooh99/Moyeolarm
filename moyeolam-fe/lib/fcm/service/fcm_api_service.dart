import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../common/const/address_config.dart';
import '../model/arlet_service_model.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: BASE_URL)
class ApiService{
  factory ApiService(Dio dio) = _ApiService;

  @GET('alerts')
Future<List<ApiArletModel>> getPosts() {
    // TODO: implement getPosts
    throw UnimplementedError();
  }

}