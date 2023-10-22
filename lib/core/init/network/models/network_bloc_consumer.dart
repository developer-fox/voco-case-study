
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants/navigation/navigation_constants.dart';
import '../../../constants/network/error_types.dart';
import '../../../init/network/bloc/network_bloc.dart';
import '../../../init/network/models/request_failed.dart';
import '../../navigation/navigation_service.dart';
import 'base_response_model.dart';
import 'network_bloc_builder.dart';
import "network_bloc_listener.dart";

//
/// It is a combination of [NetworkBlocListener] and [NetworkBlocBuilder], similar to [BlocConsumer].
//
class NetworkBlocConsumer<T extends BaseResponseModel<T>> extends StatelessWidget {
  final Widget Function(BuildContext context, )? onLoadingBuilder;
  final Widget Function(BuildContext context, NetworkSuccess<T> successObject)? onSuccessBuilder;
  final Widget Function(BuildContext context, NetworkError error)? onJoiErrorBuilder;
  final Widget Function(BuildContext context, NetworkError error)? onInvalidValueErrorBuilder;
  final Widget Function(BuildContext context, NetworkError error)? onLogicalErrorBuilder;
  final Widget Function(BuildContext context, NetworkError error)? onDataNotFoundErrorBuilder;
  final Widget Function(BuildContext context, NetworkError error)? onAuthorizationErrorBuilder;
  final Widget Function(BuildContext context, NetworkError error)? onExpiredRefreshTokenBuilder;
  final void Function(BuildContext context, )? onLoadingListener;
  final void Function(BuildContext context, NetworkSuccess<T> successObject)? onSuccessListener;
  final void Function(BuildContext context, NetworkError error)? onJoiErrorListener;
  final void Function(BuildContext context, NetworkError error)? onInvalidValueErrorListener;
  final void Function(BuildContext context, NetworkError error)? onLogicalErrorListener;
  final void Function(BuildContext context, NetworkError error)? onDataNotFoundErrorListener;
  final void Function(BuildContext context, NetworkError error)? onAuthorizationErrorListener;
  final void Function(BuildContext context, NetworkError error)? onExpiredRefreshTokenListener;
  final bool Function(NetworkBlocState previous, NetworkBlocState current)? buildWhen;
  final bool Function(NetworkBlocState previous, NetworkBlocState current)? listenWhen;
  final Widget Function(BuildContext context, NetworkError error)? onErrorOfAllBuilding;
  final void Function(BuildContext context, NetworkError error)? onErrorOfAllListening;
  final Widget Function(BuildContext context, RequestFailed failedObject)? onRequestFailedBuilding;
  final void Function(BuildContext context, RequestFailed failedObject)? onRequestFailedListening;
  final bool? finishWithOnErrorOfAllListening;

  const NetworkBlocConsumer({
    Key? key,
    this.onRequestFailedBuilding,
    this.onRequestFailedListening,
    this.onLoadingBuilder,
    this.onSuccessBuilder,
    this.onJoiErrorBuilder,
    this.onInvalidValueErrorBuilder,
    this.onLogicalErrorBuilder,
    this.onDataNotFoundErrorBuilder,
    this.onAuthorizationErrorBuilder,
    this.onExpiredRefreshTokenBuilder,
    this.onLoadingListener,
    this.onSuccessListener,
    this.onJoiErrorListener,
    this.onInvalidValueErrorListener,
    this.onLogicalErrorListener,
    this.onDataNotFoundErrorListener,
    this.onAuthorizationErrorListener,
    this.onExpiredRefreshTokenListener,
    this.buildWhen,
    this.listenWhen,
    this.onErrorOfAllBuilding,
    this.onErrorOfAllListening,
    this.finishWithOnErrorOfAllListening,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NetworkBloc<T>, NetworkBlocState>(
      listenWhen: listenWhen,
      buildWhen: buildWhen,
      builder:(context, state) {
        if(state is NetworkLoading){
          return onLoadingBuilder?.call(context, ) ?? Container();
        }
        else if(state is NetworkSuccess<T>){
          return onSuccessBuilder?.call(context, state) ?? Container();
        }
        else if(state is NetworkError){
          if(state.error.errorType == ApiErrorTypes.invalidValue){
            return onInvalidValueErrorBuilder?.call(context, state) ?? Container();
          }
          else if(state.error.errorType == ApiErrorTypes.logicalError){
            return onLogicalErrorBuilder?.call(context, state) ?? Container();
          }
          else if(state.error.errorType == ApiErrorTypes.joiError){
            return onJoiErrorBuilder?.call(context, state) ?? Container();
          }
          else if(state.error.errorType == ApiErrorTypes.authorizationError){
            return onAuthorizationErrorBuilder?.call(context, state) ?? Container();
          }
          else if(state.error.errorType == ApiErrorTypes.dataNotFound){
            return onDataNotFoundErrorBuilder?.call(context, state) ?? Container();
          }
          else if(state.error.errorType == ApiErrorTypes.expiredRefreshToken){
            return onExpiredRefreshTokenBuilder?.call(context, state) ?? Container();
          }
          else{
            return Container();
          }
        }
        else{
          return onRequestFailedBuilding?.call(context, state as RequestFailed) ?? Container();
        }
      },
      listener:(context, state) {
        if(state is NetworkLoading){
          onLoadingListener?.call(context, );
        }
        else if(state is NetworkSuccess<T>){
          onSuccessListener?.call(context, state);
        }
        else if(state is NetworkError){
          if(finishWithOnErrorOfAllListening == true) {
            onErrorOfAllBuilding?.call(context, state);
            return; 
          }
          else{
            onErrorOfAllBuilding?.call(context, state);
          }
          if(state.error.errorType == ApiErrorTypes.invalidValue){
            onInvalidValueErrorListener?.call(context, state);
          }
          else if(state.error.errorType == ApiErrorTypes.logicalError){
            onLogicalErrorListener?.call(context, state);
          }
          else if(state.error.errorType == ApiErrorTypes.joiError){
            onJoiErrorListener?.call(context, state);
          }
          else if(state.error.errorType == ApiErrorTypes.authorizationError){
            onAuthorizationErrorListener?.call(context, state);
          }
          else if(state.error.errorType == ApiErrorTypes.dataNotFound){
            onDataNotFoundErrorListener?.call(context, state);
          }
          else if(state.error.errorType == ApiErrorTypes.expiredRefreshToken){
            onExpiredRefreshTokenListener != null ? onExpiredRefreshTokenListener!(context, state) : () async {
              NavigationService.instance.navigateToPageClear(path: NavigationConstants.login_view);
            }();
          }
          else{
            return;
          }
        }
        else{
          onRequestFailedListening?.call(context, state as RequestFailed);        
        }
      },
    );
  }
}

