import 'package:exemplo/src/contact/add_page.dart';
import 'package:exemplo/src/shared/widgets/ContactList.dart';
import 'package:flutter/material.dart';

import 'home_bloc.dart';
import 'home_module.dart';

class HomePage extends StatefulWidget {
  static String tag = 'home-page';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final bloc = HomeModule.to.getBloc<HomeBloc>(); //pega a injeção do BLoC
  Widget appBarTitle = new Text("Contatos");
  Icon actionIcon = new Icon(Icons.search);
  Color color = Colors.indigo;
  final TextEditingController _cSearch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bloc.getListContact();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: StreamBuilder(
          stream: bloc.buttonSearchOut,
          builder: (conext, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
              return Text('Error: ${snapshot.error}');
            } else {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }

              if (snapshot.data) {
                return AppBar(
                  title: appBarTitle,
                  backgroundColor: color,
                  actions: <Widget>[
                    IconButton(
                      icon: actionIcon,
                      onPressed: () {
                        setState(() {
                          if (this.actionIcon.icon == Icons.search) {
                            this.actionIcon = new Icon(
                              Icons.close,
                              color: Colors.indigo,
                            );
                            this.color = Colors.white;
                            this.appBarTitle = new TextField(
                              controller: _cSearch,
                              style: new TextStyle(
                                color: Colors.indigo,
                              ),
                              autofocus: true,
                              // onChanged: bloc.getListBySearch(_cSearch.text),
                              decoration: new InputDecoration(
                                  prefixIcon: new Icon(Icons.search,
                                      color: Colors.indigo),
                                  hintText: "Pesquisar contatos",
                                  hintStyle:
                                      new TextStyle(color: Colors.indigo)),
                            );
                          } else {
                            this.actionIcon = new Icon(
                              Icons.search,
                            );
                            this.color = Colors.indigo;
                            this.appBarTitle = new Text("Contatos");
                            // bloc.getListContact();
                          }
                        });
                      },
                    ),
                  ],
                );
              } else {
                return AppBar(
                  title: Text("Contatos"),
                );
              }
            }
          },
        ),
      ),
      body: StreamBuilder(
        stream: bloc.listContactOut,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            print(snapshot.error);
            return Text('Error: ${snapshot.error}');
          } else {
            bloc.setVisibleButtonSearch(snapshot.data.length > 0);
            return ContactList(items: snapshot.data);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPage()),
          );
        },
      ),
    );
  }
}
