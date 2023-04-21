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
  final StoreDataToPropsMapper<S, P> mapper;
  final String? routeName;

  @override
  Widget build(BuildContext context) =>
      _build(InheritedValueWidget.of<ReducedStoreAndState<S>>(context).store);

  Widget _build(Store<S> store) => InheritedValueWidget(
        value: mapper(store.data, routeName),
        child: ReducedStatefulBuilderWidget<P>(builder: builder),
      );
}
