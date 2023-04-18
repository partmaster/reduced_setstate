// setstate_store.dart

import 'package:flutter/widgets.dart';
import 'package:reduced/reduced.dart';

import 'inherited_widgets.dart';

typedef EventSourceRegistrar<S> = void Function(Store<S> store);

class ReducedProvider<S> extends StatefulWidget {
  const ReducedProvider({
    super.key,
    required this.initialState,
    this.onEventDispatched,
    this.initializer,
    this.eventSourceRegistrars,
    required this.child,
  });

  final S initialState;
  final Widget child;
  final EventListener<S>? onEventDispatched;
  final Future<Event<S>>? initializer;
  final List<EventSourceRegistrar<S>>? eventSourceRegistrars;

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
    widget.initializer?.then((event) {
      process(event);
      widget.eventSourceRegistrars?.forEach((e) => e(this));
    });
  }

  @override
  void didUpdateWidget(covariant ReducedProvider<S> oldWidget) {
    widget.eventSourceRegistrars?.forEach((e) => e(this));
    super.didUpdateWidget(oldWidget);
  }

  @override
  S get state => _state;

  @override
  process(event) => setState(() {
        _state = event(_state);
        widget.onEventDispatched?.call(
          _state,
          this,
          event,
          UniqueKey(),
        );
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
