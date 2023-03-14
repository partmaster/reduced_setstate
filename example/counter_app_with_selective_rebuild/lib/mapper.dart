// mapper.dart

import 'package:reduced/reduced.dart';

import 'props.dart';
import 'events.dart';
import 'state.dart';

class StateToMyHomePagePropsMapper {
  const StateToMyHomePagePropsMapper._();
  static const StateToMyHomePagePropsMapper instance =
      StateToMyHomePagePropsMapper._();

  MyHomePageProps call(Store<MyAppState> store) => MyHomePageProps(
        onPressed: EventCarrier(store, CounterIncremented.instance),
        title: store.state.title,
      );
}

class StateToMyCounterWidgetPropsMapper {
  const StateToMyCounterWidgetPropsMapper._();
  static const StateToMyCounterWidgetPropsMapper instance =
      StateToMyCounterWidgetPropsMapper._();

  MyCounterWidgetProps call(Store<MyAppState> store) => MyCounterWidgetProps(
        counterText: '${store.state.counter}',
      );
}
