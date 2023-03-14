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
  });

  final WidgetFromPropsBuilder<P> builder;
  final StateToPropsMapper<S, P> mapper;

  @override
  Widget build(BuildContext context) =>
      _build(InheritedValueWidget.of<ReducedStoreAndState<S>>(context).store);

  Widget _build(Store<S> store) => InheritedValueWidget(
        value: mapper(store.state, store),
        child: ReducedStatefulBuilderWidget<P>(builder: builder),
      );
}
