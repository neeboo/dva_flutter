import 'package:dva_dart/dva_dart.dart';
import 'state.dart';

DvaModel playPageModel =
    DvaModel(nameSpace: 'play', initialState: PlayerState.initial(), reducers: {
  'updateState': (DvaState state, Payload<PlayerState> payload) {
    return payload.payload;
  }
}, effects: {
  'play': (Payload<String> payload) async* {
    yield PutEffect(
        key: 'updateState',
        payload: Payload<PlayerState>(PlayerState.playing()));
  },
  'stop': (Payload<String> payload) async* {
    yield PutEffect(
        key: 'updateState',
        payload: Payload<PlayerState>(PlayerState.stopped()));
  },
  'pause': (Payload<String> payload) async* {
    yield PutEffect(
        key: 'updateState',
        payload: Payload<PlayerState>(PlayerState.paused()));
  }
});
