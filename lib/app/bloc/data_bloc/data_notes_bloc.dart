import 'package:bloc/bloc.dart';

import 'package:notesapp/model/data_notes_model.dart';

part 'data_notes_event.dart';
part 'data_notes_state.dart';

class DataNotesBloc extends Bloc<DataNotesEvent, DataNotesState> {
  DataNotesBloc() : super(DataNotesInitial()) {
    on<DataNotesEventAdd>((event, emit) {
      final state = this.state;
      emit(DataNotesStateAdd(
          dataNote: List.from(state.dataNote)..add(event.dataNote)));
    });
    on<DataNotesEventDelete>((event, emit) {
      final state = this.state;
      emit(DataNotesStateDelete(
          dataNote: List.from(state.dataNote)..remove(event.dataNote)));
    });
    on<DataNotesEventUpdate>(
      (event, emit) {
        final state = this.state;
        // for (var element in state.dataNote) {
        //   if (element == event.oldDataNote) {
        //     print('oi');
        //     element = event.newDataNote;
        //   }
        // }
        List<DataNote> allData = List.from(state.dataNote);
        int index = allData.indexOf(event.oldDataNote);
        allData[index] = event.newDataNote;
        emit(DataNotesStateUpdate(dataNote: allData));
      },
    );
    on<DataNoteEventDeactive>(
      (event, emit) {
        final state = this.state;
        List<DataNote> allData = List.from(state.dataNote);
        allData.forEach((element) {
          element.isSelected = false;
        });
        emit(DataNotesStateUpdate(dataNote: allData));
      },
    );
  }
}
