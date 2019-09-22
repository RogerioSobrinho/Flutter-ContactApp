import 'dart:async';

import 'package:contacts/models/contact.dart';

class HomeListBloc {
  HomeListBloc() {
    getList();
  }

  ModelContact contact = ModelContact();

  final _controller = StreamController<List<Map>>.broadcast();

  get lists => _controller.stream;

  dispose() {
    _controller.close();
  }

  getList() async {
    _controller.sink.add(await contact.list());
  }
}
