
import 'package:dio/dio.dart';
import '../../init/network/models/api_classes.dart';
import '../../init/network/models/base_error.dart';
import '../../init/network/models/base_request_model.dart';
import '../../init/network/models/base_response_model.dart';
import '../../constants/network/error_types.dart';
import 'bloc/network_bloc.dart';
import 'models/request_failed.dart';
import 'models/unmodified_response_model.dart';

/// It allows us to perform [NetworkManagement] class internet operations with a single instance in a performance and manageable way.
//* this class ensures that only http requests are made and results are converted from required classes to objects.
/// [NetworkBloc] objects are responsible for transmitting result objects within the application.
class NetworkManagement{
  static NetworkManagement? _instance;
  static NetworkManagement get instance{
    _instance ??= NetworkManagement._init();
    return _instance!;
  }

  late final Dio _dio;

  Dio get dio => _dio;

  /// [_responseModelReturner] converts the result of the internet transaction to the required response object
  ApiClasses _responseModelReturner(Response<dynamic> response, BaseResponseModel? responseModel){
    Map<int, Function()> objectLiteral = {
      401: (){
        return BaseError(errorType: ApiErrorTypes.authorizationError, message: response.data["description"], requestOptions: response.requestOptions);
      },
      404: (){
        return BaseError(errorType: ApiErrorTypes.dataNotFound, message: response.data["description"], requestOptions: response.requestOptions);
      },
      407: () async{
        return BaseError(errorType: ApiErrorTypes.expiredRefreshToken, message: response.data ["error"], requestOptions: response.requestOptions);
      },
      400: (){
        return BaseError(errorType: ApiErrorTypes.invalidValue, message: response.data["error"], requestOptions: response.requestOptions);
      },
      412: (){
        return BaseError(errorType: ApiErrorTypes.jwtError, message: response.data["error"], requestOptions: response.requestOptions);
      },
      416: (){
        return BaseError(errorType: ApiErrorTypes.logicalError, message: response.data["error"], requestOptions: response.requestOptions);
      },
      500: (){
        return BaseError(errorType: ApiErrorTypes.serverError, message: "an error occured on server", requestOptions: response.requestOptions);
      },
      422: (){
        return BaseError(errorType: ApiErrorTypes.joiError, message: response.data.toString(), requestOptions: response.requestOptions);
      },
      484: (){
        return BaseError(errorType: ApiErrorTypes.pricingError, message: response.data.toString(), requestOptions: response.requestOptions);
      },
      200: (){
        return responseModel == null ? UnmodifiedResponseDataModel(data: response.data) : responseModel.fromResponse(response.data);
      }, 
    };
    return objectLiteral[response.statusCode] == null ? RequestFailed(): objectLiteral[response.statusCode]!();
  }

  NetworkManagement._init(){
    // BaseOptions objects create configuration in internet operations with dio package.
    final BaseOptions baseOptions = BaseOptions(
      baseUrl: "https://reqres.in/api",
    );
    _dio = Dio(baseOptions);

  }

  // method for get requests
  Future<ApiClasses> getDio(String path,{BaseRequestModel? requestModel, BaseResponseModel? responseModel, Map<String, dynamic>? queryParameters}) async{
    final response = await _dio.get(path, queryParameters: queryParameters);
    return _responseModelReturner(response, responseModel);
  }

  // method for post requests
  Future<ApiClasses> postDio(String path,{
    BaseRequestModel? requestModel, 
    BaseResponseModel? responseModel, 
    Map<String, dynamic>? query,
  }) async{
    final response = await _dio.post(path, data: requestModel?.toJson(), queryParameters: query);
    return _responseModelReturner(response, responseModel);
  }

  // method for delete requests
  Future<ApiClasses> deleteDio(String path,{BaseRequestModel? requestModel, BaseResponseModel? responseModel}) async{
    final response = await _dio.delete(path, data: requestModel?.toJson());
    return _responseModelReturner(response, responseModel);
  }

  // method for put requests
  Future<ApiClasses> putDio(String path,{
    BaseRequestModel? requestModel, 
    BaseResponseModel? responseModel,
    Map<String, dynamic>? query,
  }) async{
    final response = await _dio.put(path, data: requestModel?.toJson(), queryParameters: query);
    return _responseModelReturner(response, responseModel);
  }
}
