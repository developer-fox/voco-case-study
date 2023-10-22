import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/api_classes.dart';
import '../models/base_error.dart';
import '../models/base_response_model.dart';
part 'network_event.dart';
part 'network_bloc_state.dart';

/// [NetworkBloc] is the block class defined to effectively transfer internet transactions within the application.
/// Thanks to the [T] type given to it, it knows what type of data the response result will return, and when the operation is successful, it adds the data it receives to the stream as a [T] object in a [NetworkSuccess].
/// if the http request returns an [BaseError] object, it streams that object as a [BaseError] object in [NetworkError].
class NetworkBloc<T extends BaseResponseModel<T>> extends Bloc<NetworkEvent, NetworkBlocState> {
  static Connectivity connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _subscription;
  Future<ApiClasses>? lastRequestMethod;
  NetworkBloc() : super(RequestInitial()) {
    _subscription = connectivity.onConnectivityChanged.listen((event) {
      if(event != ConnectivityResult.none && lastRequestMethod != null) add(HttpRequestEvent(requestMethod: lastRequestMethod!));
    });
    on<HttpRequestEvent>(_onSendRequest);
    on<SocketEvent<T>>(_onSocketEvent);
  }

  /// When the [HttpRequestEvent] event is triggered, it runs the method that will return objects from the [ApiClasses] class in that event. emits [NetworkLoading] before starting. It makes the necessary publications according to the result after the run.
  Future<void> _onSendRequest(HttpRequestEvent event, Emitter<NetworkBlocState> emit) async {
    emit(NetworkLoading());
    lastRequestMethod = event.requestMethod;
    final fetchResult = await event.requestMethod;
    if(fetchResult is BaseError){
      emit(NetworkError(error: fetchResult));
    }
    if(fetchResult is T){
      emit(NetworkSuccess<T>(data: fetchResult));
    }
  }

  void _onSocketEvent(SocketEvent<T> event, Emitter<NetworkBlocState> emit){
    emit(
      NetworkSuccess<T>(data: event.dataModel)
    );
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}