import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/app/bloc/data_bloc/data_notes_bloc.dart';
import 'package:notesapp/app/bloc/lastmodified_blo/last_modified_bloc.dart';
import 'package:notesapp/app/bloc/menu_home_bloc/menu_home_bloc.dart';
import 'package:notesapp/app/router/app_pages.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Color.fromARGB(255, 241, 241, 241),
      ),
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DataNotesBloc(),
        ),
        BlocProvider(
          create: (context) => LastModifiedBloc(),
        ),
        BlocProvider(
          create: (context) => MenuHomeBloc(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}
