// mapper.dart

import 'package:reduced/reduced.dart';

import 'props.dart';
import 'event.dart';
import 'state.dart';

class HomePagePropsMapper extends MyHomePageProps {
  HomePagePropsMapper(
    StoreData<MyAppState> data, [
    String? routeName,
  ]) : super(
          onPressed: Action(
            data.processor,
            CounterIncremented.instance,
          ),
          title: data.state.title,
        );
}

class MyCounterWidgetPropsMapper extends MyCounterWidgetProps {
  MyCounterWidgetPropsMapper(
    StoreData<MyAppState> data, [
    String? routeName,
  ]) : super(
          counterText: '${data.state.counter}',
        );
}
