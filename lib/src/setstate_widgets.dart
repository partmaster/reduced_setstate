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
  Widget build(BuildContext context) => InheritedValueWidget(
        value: mapper(
            InheritedValueWidget.of<ReducedStoreAndState<S>>(context).store),
        child: ReducedStatefulBuilderWidget<P>(builder: builder),
      );
}
