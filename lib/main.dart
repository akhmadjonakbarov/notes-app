import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/logic/cubit/notes/notes_cubit.dart';
import 'presentation/screens/screens.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => NotesCubit(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Notes App',
        home: HomeScreen(),
      ),
    );
  }
}
