import 'package:contacts/pages/contact/contact-edit.dart';
import 'package:contacts/pages/home/homeBloc.dart';
import 'package:flutter/material.dart';

import '../layout.dart';

class HomeList extends StatefulWidget {
  final List<Map> items;
  final HomeListBloc listaBloc;

  HomeList({this.items, this.listaBloc}) : super();
  @override
  _HomeListState createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> {
  Offset _tapPosition;

  void _onTapDown(TapDownDetails details) {
    _tapPosition = details.globalPosition;
    print(_tapPosition);
  }

  @override
  Widget build(BuildContext context) {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();

    if (widget.items.length == 0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text('Nenhum contato cadastrado'),
          ),
        ],
      );
    }

    return ListView.builder(
      itemCount: widget.items.length,
      itemBuilder: (BuildContext context, int index) {
        Map item = widget.items[index];
        return GestureDetector(
          onTapDown: _onTapDown,
          onLongPress: () {
            showMenu(
              context: context,
              items: [
                PopupMenuItem(
                  child: Text("Editar"),
                ),
                PopupMenuItem(
                  child: Text("Excluir"),
                ),
              ],
              position: RelativeRect.fromRect(
                _tapPosition & Size(40, 40), // smaller rect, the touch area
                Offset.zero & overlay.size, // Bigger rect, the entire screen
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(color: Layout.primary()),
            width: MediaQuery.of(context).size.width,
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
              leading: CircleAvatar(
                child: Text(item['name'].substring(0, 1).toUpperCase()),
                backgroundColor: Layout.secondary(),
              ),
              title: Text(
                item['name'],
                style: TextStyle(
                  color: Layout.dark(),
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(item['phoneNumber']),
              onTap: () {
                ContactEditPage.contact = item;
                Navigator.of(context).pushNamed(ContactEditPage.tag);
              },
            ),
          ),
        );
      },
    );
  }
}
