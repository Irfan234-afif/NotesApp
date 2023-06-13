import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notesapp/app/bloc/data_bloc/data_notes_bloc.dart';
import 'package:notesapp/app/bloc/menu_home_bloc/menu_home_bloc.dart';
import 'package:notesapp/app/util/const.dart';
import 'package:notesapp/model/data_notes_model.dart';

class SliverAppBarHome extends SliverPersistentHeaderDelegate {
  const SliverAppBarHome({
    required this.maxHeaderExtent,
    required this.minHeaderExtent,
  });

  final double maxHeaderExtent;
  final double minHeaderExtent;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final size = MediaQuery.of(context);
    return BlocBuilder<MenuHomeBloc, MenuHomeState>(
      builder: (context, menuState) {
        List<DataNote> dataIsSelected = [];
        final onLongPress = menuState.onLongPress;
        return AnimatedPadding(
          curve: Curves.fastOutSlowIn,
          duration: const Duration(milliseconds: 400),
          padding: platformAndroid
              ? EdgeInsets.only(
                  top: onLongPress
                      ? 0
                      : size.viewPadding.top + size.size.height * 0.015,
                  right: onLongPress ? 0 : 16,
                  left: onLongPress ? 0 : 16,
                )
              : EdgeInsets.only(
                  top: onLongPress ? 0 : size.padding.top,
                  right: onLongPress ? 0 : 16,
                  left: onLongPress ? 0 : 16,
                ),
          child: AnimatedContainer(
            padding: EdgeInsets.only(top: onLongPress ? size.padding.top : 0),
            curve: Curves.fastOutSlowIn,
            duration: const Duration(milliseconds: 400),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 241, 241, 241),
              borderRadius: BorderRadius.circular(onLongPress ? 0 : 50),
            ),
            child: onLongPress
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      IconButton(
                        onPressed: () {
                          context.read<MenuHomeBloc>().add(MenuEventDeactive());
                          context
                              .read<DataNotesBloc>()
                              .add(DataNoteEventDeactive());
                        },
                        icon: const Icon(
                          Icons.close,
                          size: 30,
                          color: Color.fromARGB(255, 117, 117, 117),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: BlocBuilder<DataNotesBloc, DataNotesState>(
                          builder: (context, state) {
                            int allIsSelected = 0;

                            for (var element in state.dataNote) {
                              if (element.isSelected == true) {
                                allIsSelected++;
                                dataIsSelected.add(element);
                              }
                            }
                            return Text(
                              allIsSelected.toString(),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            );
                          },
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if (dataIsSelected.length != 0) {
                            for (var element in dataIsSelected) {
                              context
                                  .read<DataNotesBloc>()
                                  .add(DataNotesEventDelete(dataNote: element));
                            }
                            context
                                .read<MenuHomeBloc>()
                                .add(MenuEventDeactive());
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                duration: Duration(milliseconds: 1500),
                                content: Text('Notes berhasil di hapus'),
                              ),
                            );
                          }
                        },
                        icon: const Icon(
                          Icons.delete_outline_rounded,
                        ),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Builder(builder: (ctx) {
                        return IconButton(
                          padding: const EdgeInsets.only(left: 10),
                          onPressed: () {
                            Scaffold.of(ctx).openDrawer();
                          },
                          icon: const Icon(Icons.menu_rounded),
                        );
                      }),
                      const Expanded(
                        child: TextField(
                          autocorrect: false,
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            hintText: "Search your notes",
                            hintStyle: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        padding: const EdgeInsets.only(right: 10),
                        splashRadius: 10,
                        onPressed: () {},
                        icon: const Icon(
                          Icons.grid_view_outlined,
                          color: Color.fromARGB(255, 117, 117, 117),
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }

  @override
  double get maxExtent => maxHeaderExtent;

  @override
  double get minExtent => minHeaderExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
