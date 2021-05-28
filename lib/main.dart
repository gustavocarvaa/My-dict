import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_dict/controller/dict_cubit.dart';
import 'package:my_dict/repository/word_repository.dart';
import 'package:my_dict/views/home/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My dict',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => DictionaryCubit(WordRepository()),
        child: HomePage()),
    );
  }
}