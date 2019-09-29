// import 'package:contacts/pages/about/about.dart';
// import 'package:contacts/pages/contact/contact-add.dart';
// import 'package:contacts/pages/contact/contact-view.dart';
// import 'package:contacts/pages/home/homeBloc.dart';
import 'package:exemplo/src/about/about_page.dart';
import 'package:exemplo/src/contact/add_page.dart';
import 'package:exemplo/src/contact/view_page.dart';
import 'package:exemplo/src/home/home_bloc.dart';
import 'package:exemplo/src/home/home_module.dart';
import 'package:exemplo/src/shared/models/contact.dart';
import 'package:flutter/material.dart';

class ContactList extends StatefulWidget {
  final List<Map> items;

  ContactList({this.items}) : super();
  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  Offset _tapPosition;
  final bloc = HomeModule.to.getBloc<HomeBloc>(); //pega a injeção do BLoC

  void _onTapDown(TapDownDetails details) {
    _tapPosition = details.globalPosition;
    print(_tapPosition);
  }

  Column column(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          child: Icon(
            Icons.list,
            size: 120,
          ),
        ),
        SizedBox(height: 20),
        Center(
          child: Text(
            'Sua lista de contatos está vazia',
            style: TextStyle(fontSize: 18),
          ),
        ),
        SizedBox(height: 20),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddPage()),
            );
          },
          child: Text(
            "ADICIONAR CONTATO",
            style: TextStyle(
              color: Colors.indigo,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 20),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AboutPage()),
            );
          },
          child: Text(
            "SOBRE",
            style: TextStyle(
              color: Colors.indigo,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();

    if (widget.items.length == 0) {
      return column(context);
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
            width: MediaQuery.of(context).size.width,
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
              leading: CircleAvatar(
                child: Text(
                  item['name'].substring(0, 1).toUpperCase(),
                  style: TextStyle(fontSize: 26, color: Colors.white60),
                ),
              ),
              title: Text(
                item['name'],
                style: TextStyle(fontSize: 17),
              ),
              subtitle: item['phoneNumber'].toString().isNotEmpty
                  ? Text(item['phoneNumber'])
                  : null,
              onTap: () {
                bloc.setContact(item);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewPage()),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
