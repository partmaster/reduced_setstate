// mapper.dart

import 'package:reduced/reduced.dart';

import 'props.dart';
import 'event.dart';
import 'state.dart';

class HomePagePropsMapper extends MyHomePageProps {
  HomePagePropsMapper(
    StoreSnapshot<MyAppState> snapshot,
    String? routeName,
  ) : super(
          onPressed: Command(
            snapshot.processor,
            CounterIncremented.instance,
          ),
          title: snapshot.state.title,
        );
}

class MyCounterWidgetPropsMapper extends MyCounterWidgetProps {
  MyCounterWidgetPropsMapper(
    StoreSnapshot<MyAppState> snapshot, [
    String? routeName,
  ]) : super(
          counterText: '${snapshot.state.counter}',
        );
}
