
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants/network/error_types.dart';
import '../../../init/network/bloc/network_bloc.dart';
import '../../../init/network/models/request_failed.dart';
import '../../../constants/navigation/navigation_constants.dart';
import '../../navigation/navigation_service.dart';
import "api_classes.dart";
import 'base_response_model.dart';

// The results of http requests are transmitted within the application using bloc streams.
//
/// [NetworkBlocBuilder] is a widget for building widgets using data (must be objects of class [ApiClasses]) added to block streams within the application as a result of http requests.
//
/// Thanks to [NetworkBlocBuilder]'s properties that are produced to use different objects that can be derived from the results of http requests, it becomes easier to manage internet transactions within the context of widget building.
//
/// The type [T] inherited from the [BaseResponseModel] class passed to this class is passed to the build method, which will be executed if the http request is successful. In this way, the developer knows what kind of data to use if the operation is successful, at the same time this [NetworkBlocBuilder] object only tracks [T] type returns.
//
class NetworkBlocBuilder<T extends BaseResponseModel<T>> extends StatelessWidget {
  /// The [onLoading] property is for widget that will be built while waiting for the response
  final Widget Function(BuildContext context, )? onLoading;
  ///If the http request returns with a success code, the [onSuccess] property is executed.
  final Widget Function(BuildContext context, NetworkSuccess<T> successObject)? onSuccess;
  /// if the request returns an error and it is a joi error, method [onJoiError] is executed.
  //
  /// joi errors are errors related to data validation operations. A special status code is reserved for this type of error on the server side.
  final Widget Function(BuildContext context, NetworkError error)? onJoiError;
  /// if the request returns an error and it is a invalid value error, method [onInvalidValueError] is executed.
  final Widget Function(BuildContext context, NetworkError error)? onInvalidValueError;
  /// if the request returns an error and it is a logical error, method [onLogicalError] is executed.
  final Widget Function(BuildContext context, NetworkError error)? onLogicalError;
  /// if the request returns an error and it is a data not found error, method [onDataNotFoundError] is executed.
  final Widget Function(BuildContext context, NetworkError error)? onDataNotFoundError;
  /// if the request returns an error and it is a authorization error, method [onAuthorizationError] is executed.
  final Widget Function(BuildContext context, NetworkError error)? onAuthorizationError;
  /// if the request returns an error and it is a expired refresh token error, method [onExpiredRefreshToken] is executed.
  /// In this system, json web tokens are used for session operations.
  final Widget Function(BuildContext context, NetworkError error)? onExpiredRefreshToken;
  /// If we want, we can define a single method to be built for all error types. If [onErrorOfAll] is not null, only this method is run and built in all error types.
  final Widget Function(BuildContext context, NetworkError error)? onErrorOfAll;
  /// if the request returns an error and it is a server error, method [onServerError] is executed.
  final Widget Function(BuildContext context, NetworkError error)? onServerError;
  final Widget Function(BuildContext context, NetworkError error)? onPricingError;
  /// if http request action is failed, [onRequestFailed] method is executed.
  final Widget Function(BuildContext context, RequestFailed failedObject)? onRequestFailed;
  /// [buildWhen] can be used to define in which situations the build process will occur.
  final bool Function(NetworkBlocState previous, NetworkBlocState current)? buildWhen;
  final NetworkBloc<T>? bloc;

  const NetworkBlocBuilder({
    Key? key,
    this.onLoading,
    this.onSuccess,
    this.onJoiError,
    this.onInvalidValueError,
    this.onLogicalError,
    this.onDataNotFoundError,
    this.onAuthorizationError,
    this.onExpiredRefreshToken,
    this.onErrorOfAll,
    this.onServerError,
    this.onRequestFailed,
    this.buildWhen,
    this.onPricingError,
    this.bloc,
  }) : super(key: key);

  /// Widgets instanced from [NetworkBlocBuilder] are built by block streams that will pass a [NetworkSuccess] object in itself, which will only return the [T] object as data if successful, as seen here.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkBloc<T>, NetworkBlocState>(
      buildWhen: buildWhen,
      bloc: bloc,
      builder:(context, state) {
        if(state is NetworkLoading){
          return onLoading?.call(context, ) ?? Container();
        }
        else if(state is NetworkSuccess<T>){
          return onSuccess?.call(context, state) ?? Container();
        }
        else if(state is NetworkError){
          if(onErrorOfAll != null) onErrorOfAll!(context,state);
          if(state.error.errorType == ApiErrorTypes.invalidValue){
            return onInvalidValueError?.call(context, state) ?? Container();
          }
          else if(state.error.errorType == ApiErrorTypes.logicalError){
            return onLogicalError?.call(context, state) ?? Container();
          }
          else if(state.error.errorType == ApiErrorTypes.joiError){
            return onJoiError?.call(context, state) ?? Container();
          }
          else if(state.error.errorType == ApiErrorTypes.authorizationError){
            return onAuthorizationError?.call(context, state) ?? Container();
          }
          else if(state.error.errorType == ApiErrorTypes.dataNotFound){
            return onDataNotFoundError?.call(context, state) ?? Container();
          }
          else if(state.error.errorType == ApiErrorTypes.pricingError){
            return onPricingError?.call(context, state) ?? Container();
          }
          else if(state.error.errorType == ApiErrorTypes.expiredRefreshToken){
            NavigationService.instance.navigateToPageClear(path: NavigationConstants.login_view);
            return onExpiredRefreshToken?.call(context, state) ?? Container();
          }
          else if(state.error.errorType == ApiErrorTypes.serverError){
            return onServerError?.call(context, state) ?? Container();
          }
          else{
            return Container();
          }
        }
        else{
          return onRequestFailed?.call(context, state as RequestFailed) ?? Container();
        }
      },  
    );
  }
}
