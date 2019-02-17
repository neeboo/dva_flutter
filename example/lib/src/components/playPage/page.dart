import 'package:flutter/material.dart';

class PlayPage extends StatelessWidget {
  final Function play;
  final Function pause;
  final Function stop;
  final Function jump;
  final Function asyncAdd;
  final String status;
  final int counter;
  PlayPage(
      {this.play,
      this.pause,
      this.stop,
      this.jump,
      this.status,
      this.asyncAdd,
      this.counter});
  @override
  Widget build(BuildContext context) {
    print('you have clicked $counter times');
    print('the music is $status');
    List<Widget> buttons = new List<Widget>();
    buttons.add(new IconButton(
        onPressed: () => play(),
        iconSize: 64.0,
        icon: new Icon(Icons.play_arrow),
        color: Colors.cyan));

    buttons.add(new IconButton(
        onPressed: () => pause(),
        iconSize: 64.0,
        icon: new Icon(Icons.pause),
        color: Colors.cyan));

    buttons.add(new IconButton(
        onPressed: () => stop(),
        iconSize: 64.0,
        icon: new Icon(Icons.stop),
        color: Colors.cyan));

    var c = new Column(
      children: [
        new Row(
            children: buttons,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly),
        Text(
          'The Music is:',
        ),
        Text(
          '$status',
          style: Theme.of(context).textTheme.display1,
        ),
        Container(
          child: new FlatButton(
            child: Text(
              'Click Page',
              style: TextStyle(color: Colors.white),
            ),
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 20),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))),
            color: Colors.deepOrange,
            onPressed: () => jump(),
          ),
          margin: EdgeInsets.symmetric(vertical: 40.0),
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
    return Scaffold(
        appBar: AppBar(
          title: Text('Player'),
        ),
        body: Center(
          child: c,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => asyncAdd(counter),
          tooltip: 'Increment',
          child: Icon(Icons.thumb_up),
        ));
  }
}
