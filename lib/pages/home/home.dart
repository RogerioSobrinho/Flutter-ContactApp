import 'package:flutter/material.dart';

import 'package:contacts/pages/home/homeBloc.dart';
import 'package:contacts/widgets/HomeList.dart';
import 'package:contacts/layout.dart';

class HomePage extends StatefulWidget {
  static String tag = 'home-page';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeListBloc listaBloc = HomeListBloc();
  @override
  Widget build(BuildContext context) {
    final content = StreamBuilder<List<Map>>(
        stream: listaBloc.lists,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(child: Text('Carregando...'));
            default:
              if (snapshot.hasError) {
                print(snapshot.error);
                return Text('Error: ${snapshot.error}');
              } else {
                return HomeList(
                  items: snapshot.data,
                  listaBloc: this.listaBloc,
                );
              }
          }
        });

    return Layout.getContent(context, content, true, true);
  }
}
