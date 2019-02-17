import 'package:flutter/material.dart';
import 'package:dva_dart/dva_dart.dart';
import 'package:dva_flutter/provider.dart';
import './components/testpage/container.dart' as counterPage;
import './components/playPage/container.dart' as playPage;

class PlayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return playPage.playPageContainer(context: context, routeTo: TestPage());
  }
}

class TestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return counterPage.counterPageContainer(context: context);
  }
}

class MyApp extends StatelessWidget {
  final DvaStore store;
  MyApp(this.store);
  @override
  Widget build(BuildContext context) {
    return DvaProvider<DvaStore>(
      child: new MaterialApp(
        initialRoute: '/',
        title: 'Streams Demo',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: PlayPage(),
      ),
      store: store,
    );
  }
}
