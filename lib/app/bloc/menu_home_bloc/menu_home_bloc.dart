import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'menu_home_event.dart';
part 'menu_home_state.dart';

class MenuHomeBloc extends Bloc<MenuHomeEvent, MenuHomeState> {
  MenuHomeBloc() : super(MenuHomeInitial(onLongPress: false)) {
    on<MenuEventActive>((event, emit) {
      emit(MenuState(onLongPress: true));
    });
    on<MenuEventDeactive>((event, emit) {
      emit(MenuState(onLongPress: false));
    });
  }
}
