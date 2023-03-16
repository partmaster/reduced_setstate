// consumer.dart

import 'package:flutter/widgets.dart';
import 'package:reduced/reduced.dart';
import 'package:reduced_setstate/reduced_setstate.dart';

import 'props.dart';
import 'mappers.dart';

class MyHomePagePropsConsumer extends StatelessWidget {
  const MyHomePagePropsConsumer({
    super.key,
    required this.builder,
  });

  final WidgetFromPropsBuilder<MyHomePageProps> builder;

  @override
  Widget build(BuildContext context) => ReducedConsumer(
        mapper: HomePagePropsMapper.new,
        builder: builder,
      );
}

class MyCounterWidgetPropsConsumer extends StatelessWidget {
  const MyCounterWidgetPropsConsumer({
    super.key,
    required this.builder,
  });

  final WidgetFromPropsBuilder<MyCounterWidgetProps> builder;

  @override
  Widget build(context) => ReducedConsumer(
        mapper: MyCounterWidgetPropsMapper.new,
        builder: builder,
      );
}
