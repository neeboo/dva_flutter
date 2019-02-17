import 'package:flutter/material.dart';

class CounterPage extends StatelessWidget {
  final String title;
  final int counter;
  final Function asyncMinus;

  CounterPage({this.title, this.counter, this.asyncMinus});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        onPressed: () => asyncMinus(counter),
        tooltip: 'Decrement',
        child: Icon(Icons.thumb_down),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
