// setstate_store.dart

import 'package:flutter/widgets.dart';
import 'package:reduced/reduced.dart';

import 'inherited_widgets.dart';

class ReducedProvider<S> extends StatefulWidget {
  const ReducedProvider({
    super.key,
    required this.initialState,
    this.onEventDispatched,
    required this.child,
  });

  final S initialState;
  final Widget child;
  final EventListener<S>? onEventDispatched;

  @override
  State<ReducedProvider> createState() => ReducedProviderState<S>();
}

class ReducedProviderState<S> extends State<ReducedProvider<S>>
    implements Store<S> {
  late S _state;

  @override
  initState() {
    super.initState();
    _state = widget.initialState;
  }

  @override
  S get state => _state;

  @override
  process(event) => setState(() {
        _state = event(_state);
        widget.onEventDispatched?.call(this, event, UniqueKey());
      });

  @override
  build(context) => InheritedValueWidget(
        value: ReducedStoreAndState(this),
        child: widget.child,
      );
}

class ReducedStoreAndState<S> {
  ReducedStoreAndState(this.store) : state = store.state;

  final Store<S> store;
  final S state;

  @override
  get hashCode => Object.hash(store, state);

  @override
  operator ==(other) =>
      other is ReducedStoreAndState &&
      state == other.state &&
      store == other.store;
}
