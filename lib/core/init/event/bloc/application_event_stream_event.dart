part of 'application_event_stream_bloc.dart';

@immutable
abstract class ApplicationEventStreamEvent {}

class EmergencyCallCanceledEvent extends ApplicationEventStreamEvent{}

class EmergencyCallSubmittedEvent extends ApplicationEventStreamEvent{
  EmergencyCallSubmittedEvent();
}

class RestartAppEvent extends ApplicationEventStreamEvent{
  RestartAppEvent();
}

class AccountDeletedEvent extends ApplicationEventStreamEvent{
  AccountDeletedEvent();
}
