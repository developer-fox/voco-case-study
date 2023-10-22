
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../init/network/bloc/network_bloc.dart';
import '../../init/network/models/base_response_model.dart';
import '../../init/network/models/network_bloc_builder.dart';
import '../../init/network/models/network_bloc_listener.dart';

class BaseViewModel<RequestEnum extends Enum> {
  List<BaseViewModelRequestItem> requests;
  BaseViewModel({
    required this.requests,
  });

  BaseViewModelRequestItem fromRequests(RequestEnum enumValue){
    for(BaseViewModelRequestItem request in requests) {
      if(request.enumValue == enumValue) return request;
    }
    throw Exception("request not found");
  }

}


class BaseViewModelRequestItem<ResponseModel extends BaseResponseModel<ResponseModel>, RequestEnum extends Enum> {
  RequestEnum enumValue;
  late BlocProvider blocProvider;
  NetworkBlocBuilder? requestBuilder;
  NetworkBlocListener? requestListener;
  BaseViewModelRequestItem({
    required this.enumValue,
    this.requestBuilder,
    this.requestListener,
  }) {
    blocProvider = BlocProvider(create: ((context) => NetworkBloc<ResponseModel>())); 
  }
  
}
