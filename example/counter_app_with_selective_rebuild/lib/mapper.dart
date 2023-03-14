// mapper.dart

import 'package:reduced/reduced.dart';

import 'props.dart';
import 'events.dart';
import 'state.dart';

MyHomePageProps stateToMyHomePagePropsMapper(
  MyAppState state,
  EventProcessor<MyAppState> processor,
) =>
    MyHomePageProps(
      onPressed: EventCarrier(processor, CounterIncremented.instance),
      title: state.title,
    );

MyCounterWidgetProps stateToMyCounterWidgetPropsMapper(
  MyAppState state,
  EventProcessor<MyAppState> processor,
) =>
    MyCounterWidgetProps(
      counterText: '${state.counter}',
    );
