import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_dict/controller/dict_cubit.dart';
import 'package:my_dict/model/response_model.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Word extends StatelessWidget {
  final ResponseModel words;

  Word(this.words);

  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                icon: Icon(Icons.bookmark_outline),
                onPressed: () => null
                // TODO: ajust savement at sharedpreference and put it in the right place.
                // saveWords(words)
                )
          ],
        ),
        body: wordResultPage(context, words));
  }

  Widget wordResultPage(BuildContext context, ResponseModel responseModel) {
    return Container(
      margin: EdgeInsets.all(16.0),
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${responseModel.word}', style: TextStyle(fontSize: 30)),
            SizedBox(height: 8.0),
            Text('${responseModel.phonetics.first.text}'),
            SizedBox(height: 20.0),
            Text('${responseModel.meanings.first.definitions.first.example}'),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: IconButton(
                onPressed: () => _play(responseModel.phonetics.first.audio),
                icon: Icon(Icons.play_circle_outline_rounded),
                color: Colors.grey,
                iconSize: 100,
              ),
            ),
          ]),
    );
  }

  _play(String url) async {
    int result = await _audioPlayer.setUrl(url);
    _audioPlayer.resume();
    if (result == 1) {
      // success
    }
  }

  Future saveWords(ResponseModel model) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    List<ResponseModel> saved = List<ResponseModel>();
    saved = await getWords();

    bool exists = saved != null
        ? saved.contains((element) => element.word == model.word)
        : false;

    if (!exists && saved != null) {
      saved.add(model);
      var encoded = jsonEncode(saved);
      await pref.setStringList("words", [encoded]);
    } else if (!exists && saved == null) {
      saved = [model];
      var encoded = jsonEncode(saved);
      await pref.setStringList("words", [encoded]);
    }
  }

  Future<List<ResponseModel>> getWords() async {
    var repo = await SharedPreferences.getInstance();

    try {
      var result = repo.get('words');
      if (result != null) {
        var decoded =
            jsonDecode(result).map((item) => ResponseModel.fromJson(item));
        return decoded;
      }
    } catch (e) {
      throw e;
    }
  }
}
