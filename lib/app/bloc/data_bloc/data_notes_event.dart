part of 'data_notes_bloc.dart';

abstract class DataNotesEvent {}

class DataNotesEventAdd extends DataNotesEvent {
  final DataNote dataNote;

  DataNotesEventAdd({
    required this.dataNote,
  });
}

class DataNotesEventDelete extends DataNotesEvent {
  final DataNote dataNote;

  DataNotesEventDelete({
    required this.dataNote,
  });
}

class DataNotesEventUpdate extends DataNotesEvent {
  final DataNote oldDataNote;
  final DataNote newDataNote;

  DataNotesEventUpdate({
    required this.oldDataNote,
    required this.newDataNote,
  });
}

class DataNoteEventDeactive extends DataNotesEvent {
  // final bool isSelected;

  // DataNoteEventDeactive({required this.isSelected});
}
