import 'package:flutter/material.dart';
import 'package:my_dict/consts.dart';
import 'package:my_dict/controller/dict_cubit.dart';
import 'package:my_dict/model/response_model.dart';
import 'package:my_dict/views/bookmarkeds/saved.dart';
import 'package:my_dict/views/details/word.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<DictionaryCubit>();

    return Scaffold(
      body: BlocListener(
        listener: (context, state) {
          if(state is WordSearchedState) Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Word(state?.words),
            ),
          );
        },
        bloc: cubit,
        child: searchPage(context, cubit),
        /*cubit.state is WordSearchedState
          ? wordResultPage(context, cubit.words)
          : searchPage(context, cubit),*/
      ),

      /*AnimatedCrossFade(
        crossFadeState: cubit.state is WordSearchedState
            ? CrossFadeState.showSecond
            : CrossFadeState.showFirst,
        firstChild: searchPage(context, cubit),
        secondChild: wordResultPage(context, cubit),
        duration: const Duration(milliseconds: 1000),
        firstCurve: Curves.easeInOut,
        secondCurve: Curves.easeIn,
        sizeCurve: Curves.bounceOut,
        layoutBuilder: (topChild, topChildKey, bottomChild, bottomChildKey) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Positioned(key: bottomChildKey, top: 200, child: bottomChild),
              Positioned(key: topChildKey, child: topChild)
            ],
          );
        },
      ),*/
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.bookmark_outline),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Saved()));
        },
        heroTag: Text('Salvas'),
      ),
    );
  }

  Widget searchPage(BuildContext context, DictionaryCubit cubit) {
    return Container(
      margin: EdgeInsets.all(16.0),
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          'MyDict',
          style: TextStyle(fontSize: 30.0),
        ),
        Text('Busca rápida de palavras.'),
        SizedBox(height: 16.0),
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: 'Digite aqui',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16.0),
        cubit.state is WordSearchingState
            ? Container(
                margin: EdgeInsets.only(top: 8.0),
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white10,
                ),
              )
            : ElevatedButton(
                onPressed: () {
                  cubit.getWordMeaning(_controller.text);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search),
                    SizedBox(
                      width: 8.0,
                      height: 40,
                    ),
                    Text(
                      'Buscar',
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                )),
      ]),
    );
  }

 /* Widget wordResultPage(BuildContext context, ResponseModel model) {
    return Container(
      margin: EdgeInsets.all(16.0),
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${model.word}', style: TextStyle(fontSize: 30)),
            SizedBox(height: 8.0),
            Text('ɡrəʊ'),
            SizedBox(height: 20.0),
            Text('Become larger or greater over a period of time; increase.'),
          ]),
    );
  } */
}
