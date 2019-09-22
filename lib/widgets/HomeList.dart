import 'package:contacts/pages/home/homeBloc.dart';
import 'package:flutter/material.dart';

class HomeList extends StatefulWidget {
  final List<Map> items;
  final HomeListBloc listaBloc;

  HomeList({this.items, this.listaBloc}) : super();
  @override
  _HomeListState createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> {
  @override
  Widget build(BuildContext context) {
    // Item default
    if (widget.items.length == 0) {
      return ListView(
        children: <Widget>[
          Center(
            child: Text('No registered contacts'),
          ),
        ],
      );
    }

    return ListView.builder(
      itemCount: widget.items.length,
      itemBuilder: (BuildContext context, int index) {
        Map item = widget.items[index];
        return ListTile(
          leading: CircleAvatar(
            child: Text(item['firstName'].substring(0, 1).toUpperCase()),
          ),
          title: Text(
              item['firstName'] + (item['lastName'] ? item['lastName'] : '')),
          subtitle: Text(item['phoneNumber']),
          onTap: () {},
        );
      },
    );
  }
}

// Widget _myListView(BuildContext context) {
//   // final titles = [
//   //   'Rogerio Sobrinho',
//   //   'Jhonny',
//   //   'Pedro',
//   //   'Marcio',
//   //   'Adriano',
//   //   'Ana',
//   //   'Maria',
//   //   'Jessica',
//   //   'Kamila'
//   // ];

//   return ListView.builder(
//     itemCount: titles.length,
//     itemBuilder: (context, index) {
//       return ListTile(
//         leading: CircleAvatar(
//           child: Text(titles[index].substring(0, 1).toUpperCase()),
//         ),
//         title: Text(titles[index]),
//         subtitle: Text("+55 11123456789"),
//         onTap: () {},
//       );
//     },
//   );
// }
