part of 'menu_home_bloc.dart';

class MenuHomeState {
  final bool onLongPress;

  MenuHomeState({required this.onLongPress});
}

class MenuHomeInitial extends MenuHomeState {
  MenuHomeInitial({required super.onLongPress});
}

class MenuState extends MenuHomeState {
  MenuState({required super.onLongPress});
}
