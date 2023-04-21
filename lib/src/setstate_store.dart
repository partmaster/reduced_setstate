// setstate_store.dart

import 'package:flutter/widgets.dart';
import 'package:reduced/reduced.dart';

import 'inherited_widgets.dart';

abstract class EventHandlerRegistrar<S> {
  const EventHandlerRegistrar();
  void register(Store<S> store);
  void deregister();
}

class ReducedProvider<S> extends StatefulWidget {
  const ReducedProvider({
    super.key,
    required this.initialState,
    this.onEventDispatched,
    this.initializer,
    this.eventHandlerRegistrars,
    required this.child,
  });

  final S initialState;
  final Widget child;
  final EventListener<S>? onEventDispatched;
  final Future<Event<S>>? initializer;
  final List<EventHandlerRegistrar<S>>? eventHandlerRegistrars;

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
      widget.eventHandlerRegistrars?.forEach((e) => e.register(this));
    });
  }

  @override
  void didUpdateWidget(covariant ReducedProvider<S> oldWidget) {
    oldWidget.eventHandlerRegistrars
        ?.where(
          (e) => widget.eventHandlerRegistrars?.contains(e) != true,
        )
        .forEach((e) => e.deregister());
    widget.eventHandlerRegistrars
        ?.where(
          (e) => oldWidget.eventHandlerRegistrars?.contains(e) != false,
        )
        .forEach((e) => e.register(this));
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    widget.eventHandlerRegistrars?.forEach((e) => e.deregister());
    super.dispose();
  }

  @override
  S get state => _state;

  @override
  process(event) => setState(() {
        _state = event(_state);
        widget.onEventDispatched?.call(
          data,
          event,
          UniqueKey(),
        );
      });

  @override
  build(context) => InheritedValueWidget(
        value: ReducedStoreAndState(this),
        child: widget.child,
      );

  @override
  StoreData<S> get data => StoreData(_state, this);
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
