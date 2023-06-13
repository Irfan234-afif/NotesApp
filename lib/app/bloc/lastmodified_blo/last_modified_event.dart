part of 'last_modified_bloc.dart';

abstract class LastModifiedEvent {}

class LastModifiedEventUpdate extends LastModifiedEvent {
  final String lasModified;

  LastModifiedEventUpdate({required this.lasModified});
}
