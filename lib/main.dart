import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logic/cubit/notes/notes_cubit.dart';
import 'presentation/screens/screens.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotesCubit(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Notes App',
        home: HomeScreen(),
      ),
    );
  }
}
