// setstate_widgets.dart

import 'package:flutter/widgets.dart';
import 'package:reduced/reduced.dart';

import 'inherited_widgets.dart';
import 'setstate_store.dart';

class ReducedConsumer<S, P> extends StatelessWidget {
  const ReducedConsumer({
    super.key,
    required this.builder,
    required this.mapper,
    this.routing = RoutingContext.nil,
  });

  final WidgetFromPropsBuilder<P> builder;
  final SnapshotToPropsMapper<S, P> mapper;
  final RoutingContext routing;

  @override
  Widget build(BuildContext context) =>
      _build(InheritedValueWidget.of<ReducedStoreAndState<S>>(context)
          .store);

  Widget _build(Store<S> store) => InheritedValueWidget(
        value: mapper(store.snapshot, routing),
        child: ReducedStatefulBuilderWidget<P>(builder: builder),
      );
}

class ReducedPageBinder<S1, S2, P> extends StatelessWidget {
  const ReducedPageBinder({
    super.key,
    required this.builder,
    required this.mapper,
    required this.initialState,
    required this.routing,
  });
  final WidgetFromPropsBuilder<P> builder;
  final SnapshotsToPropsMapper<S1, S2, P> mapper;
  final S2 initialState;
  final RoutingContext routing;

  @override
  Widget build(BuildContext context) => ReducedPageProvider(
        initialState: initialState,
        child: Builder(
          builder: (context) => ReducedPageConsumer<S1, S2, P>(
            mapper: mapper,
            builder: builder,
            routing: routing,
          ),
        ),
      );
}

class ReducedPageConsumer<S1, S2, P> extends StatelessWidget {
  const ReducedPageConsumer({
    super.key,
    required this.builder,
    required this.mapper,
    required this.routing,
  });

  final WidgetFromPropsBuilder<P> builder;
  final SnapshotsToPropsMapper<S1, S2, P> mapper;
  final RoutingContext routing;

  @override
  Widget build(BuildContext context) => _build(
        InheritedValueWidget.of<ReducedStoreAndState<S1>>(
          context,
        ).store,
        InheritedValueWidget.of<ReducedStoreAndState<S2>>(
          context,
        ).store,
      );

  Widget _build(Store<S1> appStore, Store<S2> pageStore) =>
      InheritedValueWidget(
        value: mapper(appStore.snapshot, pageStore.snapshot, routing),
        child: ReducedStatefulBuilderWidget<P>(builder: builder),
      );
}

class ReducedConsumer2<S1, S2, RC, P> extends StatelessWidget {
  const ReducedConsumer2({
    super.key,
    required this.builder,
    required this.mapper,
    required this.initialState,
    required this.routing,
  });
  final WidgetFromPropsBuilder<P> builder;
  final MappingContextToPropsMapper<S1, S2, RC, P> mapper;
  final S2 initialState;
  final RC routing;

  @override
  Widget build(BuildContext context) => ReducedPageProvider(
        initialState: initialState,
        child: Builder(
          builder: (context) => ReducedPageConsumer2<S1, S2, RC, P>(
            mapper: mapper,
            builder: builder,
            routing: routing,
          ),
        ),
      );
}

class ReducedPageConsumer2<S1, S2, RC, P> extends StatelessWidget {
  const ReducedPageConsumer2({
    super.key,
    required this.builder,
    required this.mapper,
    required this.routing,
  });

  final WidgetFromPropsBuilder<P> builder;
  final MappingContextToPropsMapper<S1, S2, RC, P> mapper;
  final RC routing;

  @override
  Widget build(BuildContext context) => _build(
        InheritedValueWidget.of<ReducedStoreAndState<S1>>(
          context,
        ).store,
        InheritedValueWidget.of<ReducedStoreAndState<S2>>(
          context,
        ).store,
      );

  Widget _build(Store<S1> appStore, Store<S2> pageStore) =>
      InheritedValueWidget(
        value: mapper(MappingContext(
          appSnapshot: appStore.snapshot,
          pageSnapshot: pageStore.snapshot,
          routingContext: routing,
        )),
        child: ReducedStatefulBuilderWidget<P>(builder: builder),
      );
}
