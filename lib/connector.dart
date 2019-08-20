import 'dart:async';
import 'package:dva_dart/dva_dart.dart' as DvaDart;
import 'package:flutter/widgets.dart';
import 'provider.dart';

typedef DvaWidgetBuilder<B, S, D> = Widget Function(
    B context, S state, D dispatch);

typedef DvaDispatch<T> = void Function(T action);

class DvaConnector<M> extends ConnectorBase {
  final DvaWidgetBuilder<BuildContext, DvaModels, DvaDispatch<DvaDart.Action>>
      builder;
  final List<String> listenTo;
  final BuildContext context;

  DvaDart.DvaStore get _store => DvaProvider.of(context);

  DvaConnector(
      {Key key,
      @required this.builder,
      @required this.listenTo,
      @required this.context})
      : super(key: key, listenTo: listenTo, context: context);

  @override
  Widget build(BuildContext context, models) {
    return builder(context, DvaModels(models), _store.dispatch);
  }
}

abstract class ConnectorBase<M> extends StatefulWidget {
  final List<String> listenTo;
  final BuildContext context;
  const ConnectorBase({Key key, this.listenTo, this.context}) : super(key: key);

  Widget build(BuildContext context, List<ListenModel<Stream, M>> models);

  @override
  State<ConnectorBase<M>> createState() => _ConnectorBase<M>();
}

class _ConnectorBase<M> extends State<ConnectorBase<M>> {
  List<String> _listenTo;
  DvaDart.DvaStore _store;
  List<ListenModel<Stream, M>> _listenModels;

  @override
  void initState() {
    super.initState();
    _listenTo = widget.listenTo;
    _store = DvaProvider.of(widget.context);
    _listenModels = _getListenModels();
    _subscribe();
  }

  List<ListenModel<Stream, M>> _getListenModels() {
    return List.generate(_listenTo.length, (index) {
      return ListenModel<Stream, M>(
          _listenTo[index],
          _store.getStreamAsBroadcast(_listenTo[index]),
          _store.getInitalState(_listenTo[index]));
    });
  }

  void _subscribe() {
    _listenModels.forEach((m) {
      var bStream = m.stream;
      m.subscription = bStream.listen((onState) {
        setState(() {
          m.currentState = onState;
        });
      });
    });
  }

  void _unsubscribe() {
    _listenModels.forEach((m) {
      if (m.subscription != null) {
        m.subscription.cancel();
        m.subscription = null;
      }
    });
  }

  @override
  void dispose() {
    _unsubscribe();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.build(context, _listenModels);

  // @override
  // void didUpdateWidget(ConnectorBase<M> oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   _unsubscribe();
  // if (oldWidget.bloc.state != widget.bloc.state) {
  //   if (_subscription != null) {
  //     _unsubscribe();
  //     _state = widget.bloc.currentState;
  //   }
  //   _subscribe();
  // }
  //}
}

class ListenModel<S, M> {
  String nameSpace;
  S stream;
  M initialState;
  M currentState;
  StreamSubscription<M> subscription;
  ListenModel(this.nameSpace, this.stream, this.initialState);
  ListenModel.cancel() {
    subscription.cancel();
  }
}

class DvaModels {
  List<ListenModel> models;
  DvaModels(this.models);
  getState(String nameSpace) {
    return this.getCurrentState(nameSpace) ?? this.getInitialState(nameSpace);
  }

  getCurrentState(String nameSpace) {
    return models.singleWhere((m) => m.nameSpace == nameSpace).currentState;
  }

  getInitialState(String nameSpace) {
    return models.singleWhere((m) => m.nameSpace == nameSpace).initialState;
  }
}
