import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
part 'application_event_stream_event.dart';
part 'application_event_stream_state.dart';

class ApplicationEventStreamBloc extends Bloc<ApplicationEventStreamEvent, ApplicationEventStreamState> {
  ApplicationEventStreamBloc() : super(ApplicationEventStreamInitial()) {
    on<EmergencyCallCanceledEvent>((event, emit) {
      return emit(EmergencyCallCanceledState(isEventHandled: false));
    });
    on<EmergencyCallSubmittedEvent>((event, emit) => emit(EmergencyCallSubmittedState(isEventHandled: false)));
    on<RestartAppEvent>((event, emit) {
      return emit(RestartAppState());
    });
    on<AccountDeletedEvent>((event, emit) => emit(AccountDeletedState(isEventHandled: false)));
  }
}