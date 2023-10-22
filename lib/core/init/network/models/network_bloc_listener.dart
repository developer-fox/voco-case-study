
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants/navigation/navigation_constants.dart';
import '../../../constants/network/error_types.dart';
import '../../../init/network/bloc/network_bloc.dart';
import '../../../init/network/models/request_failed.dart';
import '../../navigation/navigation_service.dart';
import 'base_response_model.dart';
import "api_classes.dart";
import 'network_bloc_builder.dart';

// The results of http requests are transmitted within the application using bloc streams.
//
/// [NetworkBlocListener] is a BlocListener for running methods using data (must be objects of class [ApiClasses]) added to block streams within the application as a result of http requests.
//
/// Thanks to [NetworkBlocListener]'s properties that are produced to use different objects that can be derived from the results of http requests, it becomes easier to manage internet transactions within the context of method running.
//
/// The type [T] inherited from the [BaseResponseModel] class passed to this class is passed to the [NetworkBlocListener]'s listener method, which will be executed if the http request is successful. In this way, the developer knows what kind of data to use if the operation is successful, at the same time this [NetworkBlocListener] object only tracks [T] type returns.
//
class NetworkBlocListener<T extends BaseResponseModel<T>> extends BlocListener<NetworkBloc<T>, NetworkBlocState>{
  /// The [onLoading] property is for the method to be executed while waiting for the response.
  final void Function(BuildContext context)? onLoading;
  ///If the http request returns with a success code, the [onSuccess] property is executed.
  final void Function(BuildContext context, NetworkSuccess<T> successObject)? onSuccess;
  /// if the request returns an error and it is a joi error, method [onJoiError] is executed.
  //
  /// joi errors are errors related to data validation operations. A special status code is reserved for this type of error on the server side.
  final void Function(BuildContext context, NetworkError error)? onJoiError;
  /// if the request returns an error and it is a invalid value error, method [onInvalidValueError] is executed.
  final void Function(BuildContext context, NetworkError error)? onInvalidValueError;
  /// if the request returns an error and it is a logical error, method [onLogicalError] is executed.
  final void Function(BuildContext context, NetworkError error)? onLogicalError;
  /// if the request returns an error and it is a authorization error, method [onAuthorizationError] is executed.
  final void Function(BuildContext context, NetworkError error)? onDataNotFoundError;
  /// if the request returns an error and it is a authorization error, method [onAuthorizationError] is executed.
  final void Function(BuildContext context, NetworkError error)? onAuthorizationError;
  /// if the request returns an error and it is a expired refresh token error, method [onExpiredRefreshToken] is executed.
  /// In this system, json web tokens are used for session operations.
  final void Function(BuildContext context, NetworkError error)? onExpiredRefreshToken;
  /// If we want, we can define a single method to be built for all error types. If [onErrorOfAll] is not null, only this method is run and built in all error types.
  /// Unlike [NetworkBlocBuilder], in [NetworkBlocListener] the method [onErrorOfAll] may optionally not prevent the execution of methods that are specifically defined for different error conditions.
  final void Function(BuildContext context, NetworkError error)? onErrorOfAll;
  /// if the request returns an error and it is a server error, method [onServerError] is executed.
  final void Function(BuildContext context, NetworkError error)? onServerError;
  final void Function(BuildContext context, NetworkError error)? onPricingError;
  /// if http request action is failed, [onRequestFailed] method is executed.
  final void Function(BuildContext context, RequestFailed failedObject)? onRequestFailed;
  /// [finishWithOnErrorOfAll] determines whether method [onErrorOfAll] prevents it from running other specially designated error methods. The default value is false.
  final bool finishWithOnErrorOfAll;

  NetworkBlocListener({
    super.key, 
    super.listenWhen,
    super.child,
    this.onRequestFailed,
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
    this.onPricingError,
    this.finishWithOnErrorOfAll = false,
    super.bloc,
  }): super(
    listener: (context, state) {
        if(state is NetworkLoading){
          onLoading?.call(context);
        }
        else if(state is NetworkSuccess<T>){
          onSuccess?.call(context, state);
        }
        else if(state is NetworkError){
          if(finishWithOnErrorOfAll){
            return onErrorOfAll?.call(context, state);
          }
          else{
            onErrorOfAll?.call(context, state);
            if(state.error.errorType == ApiErrorTypes.invalidValue){
              onInvalidValueError?.call(context, state);
            }
            else if(state.error.errorType == ApiErrorTypes.logicalError){
              onLogicalError?.call(context, state);
            }
            else if(state.error.errorType == ApiErrorTypes.joiError){
              onJoiError?.call(context, state);
            }
            else if(state.error.errorType == ApiErrorTypes.authorizationError){
              onAuthorizationError?.call(context, state);
            }
            else if(state.error.errorType == ApiErrorTypes.dataNotFound){
              onDataNotFoundError?.call(context, state);
            }
            else if(state.error.errorType == ApiErrorTypes.serverError){
              onServerError?.call(context, state);
            }
            else if(state.error.errorType == ApiErrorTypes.pricingError){
              onPricingError?.call(context, state);
            }
            else if(state.error.errorType == ApiErrorTypes.expiredRefreshToken){
              onExpiredRefreshToken != null ? onExpiredRefreshToken(context, state) : () async {
                NavigationService.instance.navigateToPageClear(path: NavigationConstants.login_view);
              }();
            }
            else{
              return;
            }
          }
        }
        else{
          onRequestFailed?.call(context, state as RequestFailed);
        }
      },
    );  
}
