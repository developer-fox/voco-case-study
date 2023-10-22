part of 'network_bloc.dart';

abstract class NetworkEvent {}

/// http requests are forwarded to [NetworkBloc] via the[requestMethod] object in the [HttpRequestEvent]. 
///
/// The [NetworkBloc] object runs the method that will return the [ApiClasses] defined in this [HttpRequestEvent] and waits for the result and then processes the result.
class HttpRequestEvent extends NetworkEvent {
  final Future<ApiClasses> requestMethod;
  HttpRequestEvent({
    required this.requestMethod,
  });
}

class SocketEvent<T extends BaseResponseModel<T>> extends NetworkEvent {
  final T dataModel;
  SocketEvent({
    required this.dataModel,
  });
}

