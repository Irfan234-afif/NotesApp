part of 'data_notes_bloc.dart';

abstract class DataNotesState {
  final List<DataNote> dataNote;
  const DataNotesState({
    required this.dataNote,
  });

  List<Object> get props => [dataNote];
}

class DataNotesInitial extends DataNotesState {
  DataNotesInitial() : super(dataNote: []);
}

class DataNotesStateAdd extends DataNotesState {
  const DataNotesStateAdd({required super.dataNote});
}

class DataNotesStateDelete extends DataNotesState {
  const DataNotesStateDelete({required super.dataNote});
}

class DataNotesStateUpdate extends DataNotesState {
  const DataNotesStateUpdate({required super.dataNote});
}
