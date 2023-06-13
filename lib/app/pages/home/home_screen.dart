import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:notesapp/app/bloc/data_bloc/data_notes_bloc.dart';
import 'package:notesapp/app/bloc/menu_home_bloc/menu_home_bloc.dart';
import 'package:notesapp/app/pages/home/appbar/sliverappbar_persistent.dart';
import 'package:notesapp/app/util/const.dart';
import 'package:notesapp/model/data_notes_model.dart';

import '../../router/app_pages.dart';
import 'bottom_navbar/bottom_navbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //MediaQuery
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;

    return BlocBuilder<DataNotesBloc, DataNotesState>(
      builder: (context, dataState) {
        //inputing data dari state bloc
        List<DataNote> dataNote = dataState.dataNote;
        var itemCount = dataNote.length;

        return BlocBuilder<MenuHomeBloc, MenuHomeState>(
          builder: (context, menuHomeState) {
            final onLongPress = menuHomeState.onLongPress;

            //Variable untuk mengetahui berapa jumlah item yang di select
            int allisSelect = 0;
            dataNote.forEach((element) {
              if (element.isSelected == true) {
                allisSelect++;
              }
            });

            return Scaffold(
              drawer: Drawer(),
              body: Stack(
                children: [
                  CustomScrollView(
                    slivers: [
                      SliverPersistentHeader(
                        floating: true,
                        delegate: SliverAppBarHome(
                          maxHeaderExtent: size.height * 0.118,
                          minHeaderExtent: size.height * 0.118,
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 20),
                        sliver: SliverGrid.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                          ),
                          itemCount: itemCount,
                          itemBuilder: (context, index) {
                            bool selected = dataNote[index].isSelected;
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: BorderSide(
                                  strokeAlign: 0.2,
                                  width: selected ? 1 : 0.4,
                                  color: selected
                                      ? Colors.black87
                                      : Color.fromARGB(255, 146, 146, 146),
                                ),
                              ),
                              elevation: 3,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(9),
                                onLongPress: () {
                                  if (!onLongPress) {
                                    context
                                        .read<MenuHomeBloc>()
                                        .add(MenuEventActive());
                                    dataNote[index].isSelected = true;
                                  }
                                },
                                onTap: () {
                                  if (!onLongPress) {
                                    context.goNamed(Routes.note,
                                        queryParameters: {
                                          'index': "$index",
                                        },
                                        extra: dataNote[index]);
                                  } else {
                                    if (selected) {
                                      context.read<DataNotesBloc>().add(
                                          DataNotesEventUpdate(
                                              oldDataNote: dataNote[index],
                                              newDataNote: dataNote[index]
                                                ..isSelected = false));
                                      if (allisSelect == 1 &&
                                          dataNote[index].isSelected == false) {
                                        context
                                            .read<MenuHomeBloc>()
                                            .add(MenuEventDeactive());
                                      }
                                    } else {
                                      context.read<DataNotesBloc>().add(
                                          DataNotesEventUpdate(
                                              oldDataNote: dataNote[index],
                                              newDataNote: dataNote[index]
                                                ..isSelected = true));
                                    }
                                  }
                                },
                                child: Center(
                                  child: Text(dataNote[index].content!),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  if (itemCount == 0)
                    SizedBox(
                      height: mediaQuery.size.height,
                      // mediaQuery.padding.top -
                      // size.height * 0.015 -
                      // 50 -
                      // mediaQuery.padding.bottom,
                      width: mediaQuery.size.width,
                      child: Center(
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.lightbulb_outline_rounded,
                              color: KColor1,
                              size: 120,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Notes you add appear here',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
              bottomNavigationBar: BottomNavigationBarHome(
                  mediaQuery: mediaQuery, itemCount: itemCount),
            );
          },
        );
      },
    );
  }
}
