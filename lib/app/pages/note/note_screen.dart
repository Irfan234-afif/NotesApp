import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:notesapp/app/bloc/data_bloc/data_notes_bloc.dart';
import 'package:notesapp/app/bloc/lastmodified_blo/last_modified_bloc.dart';
import 'package:notesapp/app/util/const.dart';
import 'package:notesapp/model/data_notes_model.dart';

class NotesScreen extends StatelessWidget {
  NotesScreen({
    super.key,
    this.dataNote,
    required this.index,
  });

  final DataNote? dataNote;
  final String index;

  TextEditingController boardController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  FocusNode boardFous = FocusNode();

  @override
  Widget build(BuildContext context) {
    final createdDateTime = DateTime.now();
    final mediaQuery = MediaQuery.of(context);

    var content = dataNote?.content;
    boardController.text = content ?? '';

    if (dataNote == null) {
      var newDateTime =
          '${DateFormat.yMMMd().format(DateTime.now())} ${DateFormat.Hm().format(DateTime.now())}';
      context
          .read<LastModifiedBloc>()
          .add(LastModifiedEventUpdate(lasModified: newDateTime));
    } else {
      var newDateTime =
          '${DateFormat.yMMMd().format(dataNote!.lastModified!)} ${DateFormat.Hm().format(dataNote!.lastModified!)}';
      context
          .read<LastModifiedBloc>()
          .add(LastModifiedEventUpdate(lasModified: newDateTime));
    }

    return Scaffold(
      backgroundColor: KcolorBasic,
      appBar: buildAppBarNote(context, createdDateTime),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 15,
        ),
        physics: const ClampingScrollPhysics(),
        children: [
          Center(
            child: BlocBuilder<LastModifiedBloc, LastModifiedState>(
              builder: (context, state) {
                return Text(
                  state.lastModified,
                );
              },
            ),
          ),
          TextField(
            controller: titleController,
            onChanged: (value) {
              //membuat dateTime terbaru
              var newDateTime =
                  '${DateFormat.yMMMd().format(DateTime.now())} ${DateFormat.Hm().format(DateTime.now())}';
              //update var dateTime
              context
                  .read<LastModifiedBloc>()
                  .add(LastModifiedEventUpdate(lasModified: newDateTime));
            },
            decoration: const InputDecoration(
              hintText: "Title",
              hintStyle: TextStyle(
                fontSize: 25,
              ),
              border: InputBorder.none,
            ),
          ),
          TextField(
            controller: boardController,
            focusNode: boardFous,
            maxLines: null,
            onChanged: (value) {
              var newDateTime =
                  '${DateFormat.yMMMd().format(DateTime.now())} ${DateFormat.Hm().format(DateTime.now())}';
              context
                  .read<LastModifiedBloc>()
                  .add(LastModifiedEventUpdate(lasModified: newDateTime));
            },
            decoration: InputDecoration(
              constraints: BoxConstraints(
                  minHeight: mediaQuery.size.height -
                      mediaQuery.padding.top -
                      125 -
                      mediaQuery.padding.bottom),
              hintText: "Notes",
              border: InputBorder.none,
            ),
          ),
        ],
      ),
      // bottomNavigationBar: Container(
      //   height: 80,
      //   padding: EdgeInsets.only(
      //     bottom: mediaQuery.padding.bottom,
      //     left: 16,
      //     right: 16,
      //   ),
      //   decoration: BoxDecoration(
      //     color: KcolorBasic,
      //     border: Border(
      //       top: BorderSide(
      //         color: Colors.black,
      //         width: 0.2,
      //       ),
      //     ),
      //   ),
      //   child: Row(
      //     children: [

      //     ],
      //   ),
      // ),
    );
  }

  AppBar buildAppBarNote(BuildContext context, DateTime createdDateTime) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        onPressed: () async {
          if (dataNote == null) {
            if (boardController.text.isNotEmpty ||
                titleController.text.isNotEmpty) {
              context.read<DataNotesBloc>().add(
                    DataNotesEventAdd(
                      dataNote: DataNote(
                        content: boardController.text,
                        title: titleController.text,
                        created: createdDateTime,
                        lastModified: DateTime.now(),
                      ),
                    ),
                  );
            }
          } else {
            var content = dataNote!.content;
            var title = dataNote!.title;
            var flagUpdate = titleController.text != title ||
                boardController.text != content;
            if (flagUpdate) {
              context.read<DataNotesBloc>().add(
                    DataNotesEventUpdate(
                      oldDataNote: dataNote!,
                      newDataNote: DataNote(
                        content: boardController.text,
                        title: titleController.text,
                        created: dataNote!.created,
                        lastModified: DateTime.now(),
                      ),
                    ),
                  );
            }
          }
          context.pop();
        },
        icon: Icon(
          Icons.arrow_back_rounded,
          color: Colors.black54,
          size: 28,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            boardFous.unfocus();
            if (dataNote != null) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: EdgeInsets.only(
                        top: 45, left: 15, right: 15, bottom: 25),
                    content: Text('Note will be delete. Confirm?',
                        textAlign: TextAlign.center),
                    actions: [
                      OutlinedButton(
                        onPressed: () {
                          context.pop();
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.black87),
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          context
                              .read<DataNotesBloc>()
                              .add(DataNotesEventDelete(dataNote: dataNote!));
                        },
                        child: Text(
                          'Confirm',
                          style: TextStyle(color: Colors.black87),
                        ),
                      ),
                    ],
                  );
                },
              );
              // context
              //     .read<DataNotesBloc>()
              //     .add(DataNotesEventDelete(dataNote: dataNote!));
            } else {
              context.pop();
            }
          },
          icon: Icon(
            Icons.delete_outlined,
            color: const Color.fromARGB(221, 65, 65, 65),
            size: 25,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.add_alert_outlined,
            color: const Color.fromARGB(221, 65, 65, 65),
            size: 25,
          ),
        ),
      ],
    );
  }
}
