import 'package:dva_dart/dva_dart.dart';
import 'state.dart';
import '../../services/thumb.dart';

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
    var added = await minus(payload.payload);
    yield PutEffect(key: 'updateState', payload: Payload<int>(added));
  },
});
