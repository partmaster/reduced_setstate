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
    this.routeName,
  });

  final WidgetFromPropsBuilder<P> builder;
  final SnapshotToPropsMapper<S, P> mapper;
  final String? routeName;

  @override
  Widget build(BuildContext context) =>
      _build(InheritedValueWidget.of<ReducedStoreAndState<S>>(context).store);

  Widget _build(Store<S> store) => InheritedValueWidget(
        value: mapper(store.snapshot, routeName),
        child: ReducedStatefulBuilderWidget<P>(builder: builder),
      );
}

class ReducedPageBinder<S1, S2, P> extends StatelessWidget {
  const ReducedPageBinder({
    super.key,
    required this.builder,
    required this.mapper,
    required this.initialState,
    required this.routeName,
  });
  final WidgetFromPropsBuilder<P> builder;
  final SnapshotsToPropsMapper<S1, S2, P> mapper;
  final S2 initialState;
  final String? routeName;

  @override
  Widget build(BuildContext context) => ReducedPageProvider(
        initialState: initialState,
        child: Builder(
          builder: (context) => ReducedPageConsumer<S1, S2, P>(
            mapper: mapper,
            builder: builder,
            routeName: routeName,
          ),
        ),
      );
}

class ReducedPageConsumer<S1, S2, P> extends StatelessWidget {
  const ReducedPageConsumer({
    super.key,
    required this.builder,
    required this.mapper,
    this.routeName,
  });

  final WidgetFromPropsBuilder<P> builder;
  final SnapshotsToPropsMapper<S1, S2, P> mapper;
  final String? routeName;

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
        value: mapper(appStore.snapshot, pageStore.snapshot, routeName),
        child: ReducedStatefulBuilderWidget<P>(builder: builder),
      );
}
