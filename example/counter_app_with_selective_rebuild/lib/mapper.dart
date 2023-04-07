// mapper.dart

import 'package:reduced/reduced.dart';

import 'props.dart';
import 'event.dart';
import 'state.dart';

class HomePagePropsMapper extends MyHomePageProps {
  HomePagePropsMapper(MyAppState state, EventProcessor<MyAppState> processor,
      [String? routeName])
      : super(
          onPressed: Action(processor, CounterIncremented.instance),
          title: state.title,
        );
}

class MyCounterWidgetPropsMapper extends MyCounterWidgetProps {
  MyCounterWidgetPropsMapper(
      MyAppState state, EventProcessor<MyAppState> processor,
      [String? routeName])
      : super(
          counterText: '${state.counter}',
        );
}
