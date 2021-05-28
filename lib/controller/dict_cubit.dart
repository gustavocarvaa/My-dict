import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_dict/model/response_model.dart';
import 'package:my_dict/repository/word_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DictionaryCubit extends Cubit<DictionaryState> {
  final WordRepository _repository;

  DictionaryCubit(this._repository) : super(NoWordSearchedState());

  Future getWordMeaning(String word) async {
    try {
      if (word == null) {
        emit(ErrorState('Type a word before search'));
      } else {
        emit(WordSearchingState());

        final result = await _repository.getWord(word);
        
        emit(WordSearchedState(result));
        emit(NoWordSearchedState());
      }
    } on Exception catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}

abstract class DictionaryState {}

class NoWordSearchedState extends DictionaryState {}

class WordsSavedState extends DictionaryState {
  final List<ResponseModel> words;

  WordsSavedState(this.words);
}

class WordSearchingState extends DictionaryState {}

class WordSearchedState extends DictionaryState {
  final ResponseModel words;

  WordSearchedState(this.words);
}

class ErrorState extends DictionaryState {
  final message;

  ErrorState(this.message);
}
