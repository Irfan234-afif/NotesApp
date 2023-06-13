part of 'last_modified_bloc.dart';

class LastModifiedState {
  final String lastModified;

  LastModifiedState({required this.lastModified});
}

class LastModifiedInitial extends LastModifiedState {
  LastModifiedInitial({required super.lastModified});
}

class LastModifiedUpdate extends LastModifiedState {
  LastModifiedUpdate({required super.lastModified});
}
