part of 'network_bloc.dart';

abstract class NetworkBlocState {}

class RequestInitial extends NetworkBlocState {}

/// [NetworkLoading] is added to the stream before the http request is made. In this way, what needs to be loading the installation can be done by the subscribers.
/// optionally, previously retrieved data for pagination operations can be kept in objects of [NetworkLoading].
class NetworkLoading<T> extends NetworkBlocState {
  final T? paginationDatas;
  NetworkLoading({this.paginationDatas});
}

///When the http request is successful, these [NetworkSuccess] objects are added to the stream. In this way, subscribers can take necessary actions. 
/// With the defined [T] type, it is specified what kind of data the operation will return.
class NetworkSuccess<T extends BaseResponseModel<T>> extends NetworkBlocState {
  final T data;
  NetworkSuccess({
    required this.data,
  });
}

/// [NetworkError] objects are added to the stream when the http request results in an error
/// Thanks to the [BaseError] object in it, subscribers can take actions related to the error.
class NetworkError extends NetworkBlocState {
  final BaseError error;
  NetworkError({
    required this.error,
  });
}