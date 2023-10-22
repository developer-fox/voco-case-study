// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'application_event_stream_bloc.dart';

abstract class ApplicationEventStreamState {}

class ApplicationEventStreamInitial extends ApplicationEventStreamState {}

// ignore: must_be_immutable
class EmergencyCallCanceledState extends ApplicationEventStreamState {
  bool isEventHandled;
  EmergencyCallCanceledState(
    {required this.isEventHandled,}
  );
}

class EmergencyCallSubmittedState extends ApplicationEventStreamState {
  bool isEventHandled;
  EmergencyCallSubmittedState(
    {required this.isEventHandled,}
  );
}

class RestartAppState extends ApplicationEventStreamState{
  RestartAppState();
}

class AccountDeletedState extends ApplicationEventStreamState {
  bool isEventHandled;
  AccountDeletedState({
    required this.isEventHandled,
  });
}
