import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_dict/model/response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Saved extends StatefulWidget {
  @override
  _SavedState createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  List<ResponseModel> _responseModel;

  @override
  void initState() {
      super.initState();
      // TODO: ajust savement at sharedpreference and put it in the right place.
      // getWords().then((value) => _responseModel = value);
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
            itemCount: _responseModel?.length ?? 0,
            // padding: EdgeInsets.all(16.0),
            itemBuilder: (context, item) {
              return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: ListTile(
                    title: Text('Word'),
                    subtitle: Text('The meaning of the word'),
                    trailing: IconButton(icon: Icon(Icons.cancel)),
                  ));
            }),
      ),
    );
  }
}
