import 'package:dva_dart/dva_dart.dart' as Dva;
import 'package:flutter/widgets.dart';
import 'connector.dart';

// abstract class View<T, D> extends StatelessWidget {
//   final Key key;
//   final D dispatch;
//   final T state;
//   View({this.key, this.dispatch, this.state}) : super(key: key);

//   Widget buildView(T state, D dispatch);
// }

// abstract class DvaView extends View {
//   @override
//   Widget build(BuildContext context) {
//     return DvaConnector(
//         key: key,
//         builder: (BuildContext context, dynamic data,
//             DvaDispatch<Dva.Action> dispatch) {
//           return buildView(data, dispatch);
//         });
//   }
// }
