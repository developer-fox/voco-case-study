
import '../../../init/network/models/base_response_model.dart';

/// If the method that will make the http request is not given an object that inherits class [BaseResponseModel], the mentioned method automatically creates an object of class [UnmodifiedResponseDataModel] and passes it to the corresponding block stream.
// 
class UnmodifiedResponseDataModel extends BaseResponseModel<UnmodifiedResponseDataModel> {
  late dynamic data;
  UnmodifiedResponseDataModel({
    required this.data,
  });
  @override
  UnmodifiedResponseDataModel fromResponse(Object jsonData) {
    return UnmodifiedResponseDataModel(data: jsonData);
  }
}