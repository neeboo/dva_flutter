import 'package:flutter/material.dart';
import 'package:dva_dart/dva_dart.dart' as Dva;
import 'package:dva_flutter/connector.dart';
import '../../models/states.dart';
import 'page.dart';

Widget counterPageContainer({context}) {
  return DvaConnector(
    context: context,
    key: Key('CounterPage'),
    listenTo: ['counter'],
    builder: (BuildContext context, DvaModels models, dispatch) {
      CounterState counterState = models.getState('counter');
      return CounterPage(
        title: 'Counter',
        counter: counterState.counter,
        asyncMinus: (int counter) => dispatch(
            Dva.createAction('counter/asyncMinus')(Dva.Payload(counter))),
      );
    },
  );
}
