import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:dva_dart/dva_dart.dart' as Dva;
import 'package:dva_flutter/connector.dart';
import '../../models/states.dart';
import 'page.dart';

Widget playPageContainer({context, routeTo}) {
  return DvaConnector(
    context: context,
    key: Key('PlayPage'),
    listenTo: ['counter', 'play'],
    builder: (BuildContext context, DvaModels models, dispatch) {
      PlayerState playerState = models.getState('play');
      CounterState counterState = models.getState('counter');
      return PlayPage(
        counter: counterState.counter,
        play: () => dispatch(Dva.createAction('play/play')(null)),
        pause: () => dispatch(Dva.createAction('play/pause')(null)),
        stop: () => dispatch(Dva.createAction('play/stop')(null)),
        jump: () => Navigator.push(
              context,
              CupertinoPageRoute(
                  fullscreenDialog: true, builder: (context) => routeTo),
            ),
        status: playerState.status,
        asyncAdd: (int counter) => dispatch(
            Dva.createAction('counter/asyncAdd')(Dva.Payload(counter))),
      );
    },
  );
}
