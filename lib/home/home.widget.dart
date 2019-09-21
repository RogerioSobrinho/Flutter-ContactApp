import 'package:contacts/about/about.widget.dart';
import 'package:contacts/create/create.widget.dart';
import 'package:contacts/search/search.widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Text("Contacts"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchPage()),
              );
            },
          )
        ],
      ),
      body: myListView(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreatePage()),
          );
        },
        child: Icon(Icons.add),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(0),
          children: [
            UserAccountsDrawerHeader(
              accountEmail: Text("Akram.aic193@Gmail.com"),
              accountName: Text("Akram Chauhan"),
              currentAccountPicture: CircleAvatar(
                child: Text("P"),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text("About Us"),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget myListView(BuildContext context) {
  final titles = [
    'Rogerio Sobrinho',
    'Jhonny',
    'Pedro',
    'Marcio',
    'Adriano',
    'Ana',
    'Maria',
    'Jessica',
    'Kamila'
  ];

  return ListView.builder(
    itemCount: titles.length,
    itemBuilder: (context, index) {
      return ListTile(
        leading: CircleAvatar(
          child: Text(titles[index].substring(0, 1).toUpperCase()),
        ),
        title: Text(titles[index]),
        subtitle: Text("+55 11123456789"),
        onTap: () {},
      );
    },
  );
}
