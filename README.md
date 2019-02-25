# dva_flutter

Combine BloC and dva_dart together

## Getting Started

1. Read `BackGround` first.
2. Example: [dva_flutter_example](https://github.com/neeboo/dva_flutter_example).

## Usage

1. create State

state.dart:

```dart
import 'package:dva_dart/dva_dart.dart';

class CounterState implements DvaState<int> {
  final int counter;
  CounterState(this.counter);
}
```

2. create model and write some effect

model.dart:

```dart
import 'package:dva_dart/dva_dart.dart';
import 'state.dart';

Future add(int p) async {
  return await p + 1;
}

Future minus(int p) async {
  return await p - 1;
}

DvaModel counterPageModel =
    DvaModel(nameSpace: 'counter', initialState: CounterState(0), reducers: {
  'updateState': (DvaState<int> state, Payload<int> payload) {
    return CounterState(payload.payload);
  },
}, effects: {
  'asyncAdd': (Payload<int> payload) async* {
    var added = await add(payload.payload);
    yield PutEffect(key: 'updateState', payload: Payload<int>(added));
  },
  'asyncMinus': (Payload<int> payload) async* {
    var minused = await minus(payload.payload);
    yield PutEffect(key: 'updateState', payload: Payload<int>(minused));
  },
});
```

3. use connector to wrap up your widget

container.dart

```dart
import 'package:flutter/material.dart';
import 'package:dva_dart/dva_dart.dart';
import 'package:dva_flutter/connector.dart';
import 'state.dart';
import 'widget.dart';

Widget counterPageContainer({context}) {
  return DvaConnector(
    context: context,
    key: Key('CounterPage'),
    listenTo: ['counter'],
    builder: (BuildContext context, DvaModels models, dispatch) {
      CounterState counterState = models.getState('counter');
      return CounterPageWidget(
        title: 'Counter',
        counter: counterState.counter,
        asyncAdd: (int counter) => dispatch(
            createAction('counter/asyncAdd')(Dva.Payload(counter))),
        asyncMinus: (int counter) => dispatch(
            createAction('counter/asyncMinus')(Dva.Payload(counter))),
      );
    },
  );
}
```

widget.dart

```dart
import 'package:flutter/material.dart';

class CounterPageWidget extends StatelessWidget {
  final String title;
  final int counter;
  final Function asyncMinus;
  final Function asyncAdd;

  CounterPageWidget({this.title, this.counter, this.asyncMinus,this.asyncAdd});
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
              '${this.counter}',
              style: Theme.of(context).textTheme.display1,
            ),
            IconButton(
                onPressed: () {
                    this.asyncAdd(counter);
                },
                icon: Icon(
                    Icons.thumb_up,
                    color: Colors.black,
                    size: 32.0,
                ),
            ),
            IconButton(
                onPressed: () {
                    this.asyncMinus(counter);
                },
                icon: Icon(
                    Icons.thumb_down,
                    color: Colors.black,
                    size: 32.0,
                ),
            ),
          ],
        ),
      ),
    );
  }
}

```

4. put models toghther and create store

```dart
import 'package:dva_dart/dva_dart.dart';
import 'model.dart';

final DvaStore store =
    DvaStore(models: [counterPageModel]);
```

5. put store in the main

```dart

import 'package:flutter/material.dart';
import 'package:dva_dart/dva_dart.dart';
import 'package:dva_flutter/provider.dart';
import 'store.dart';
import 'container.dart';


// -----

void main() {
  runApp(new MyApp(store));
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

class PlayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return playPageContainer(context: context);
  }
}


```

## BackGround

There are a lot of resolutions for flutter's state managing.

`redux_dart` and `BloC` are both great libs to start with.

`redux_dart` is mainly for react developers, but it's not easy to configure, especially when people are not javascript developers originally.

`Bloc` is using `rxdart` and using the `Stream/Sink` related solotions, which is recommended by Flutter official.

However, when it comes to real project development, things are getting hard.

When you are trying to make a side-effect call to server or simply trying to get states from other executions,

both `Bloc` and `redux_dart` are hard to use.

Luckily, in `javascript/react` world, we have `DvaJS` to ease the pain, which combines `redux`,`redux_saga` together, only 8 APIs to remember and easy to configure your app.

It comes to an idea that if we try using the `Bloc` and `DvaJS` together, we can use `Stream/Sink` and `rxdart` as the state listener, and use `Reducer`,`ActionDispatcher` and `SideEffect` as the data model configuration, things should works and may ease the pain.

For that, I make `dva_dart` and `dva_flutter`.

- DvaProvider -- `dva_flutter`
- DvaConnector -- `dva_flutter`
- DvaModel -- `dva_dart`
- DvaStore -- `dva_dart`
- DvaEffect (PutEffect, CallEffect) -- `dva_dart`
- DvaState -- `dva_dart`
- Action -- `dva_dart`
- Payload -- `dva_dart`
