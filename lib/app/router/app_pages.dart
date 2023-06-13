import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notesapp/app/pages/home/home_screen.dart';
import 'package:notesapp/app/pages/note/note_screen.dart';
import 'package:notesapp/model/data_notes_model.dart';

part './app_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: Routes.home,
      builder: (context, state) => HomeScreen(),
      routes: [
        GoRoute(
          path: 'note',
          name: Routes.note,
          builder: (context, state) => NotesScreen(
            index: state.queryParameters['index'] ?? '0',
            dataNote: state.extra as DataNote?,
          ),
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: NotesScreen(index: state.queryParameters['index']!),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        ),
      ],
    ),
  ],
);
