import 'package:bloc/bloc.dart';

part 'last_modified_event.dart';
part 'last_modified_state.dart';

class LastModifiedBloc extends Bloc<LastModifiedEvent, LastModifiedState> {
  LastModifiedBloc() : super(LastModifiedInitial(lastModified: '')) {
    on<LastModifiedEventUpdate>((event, emit) {
      emit(LastModifiedUpdate(lastModified: event.lasModified));
    });
  }
}
