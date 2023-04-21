// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reduced/reduced.dart';
import 'package:reduced_setstate/reduced_setstate.dart';

extension SingleWidgetByType on CommonFinders {
  T singleWidgetByType<T>(Type type) =>
      find.byType(type).evaluate().single.widget as T;
}

class CounterIncremented extends Event<int> {
  @override
  int call(int state) => state + 1;
}

void main() {
  testWidgets('ReducedProvider process test', (WidgetTester tester) async {
    await tester.pumpWidget(
      ReducedProvider(
        initialState: 0,
        child: ReducedConsumer<int, int>(
          builder: ({Key? key, required int props}) => const SizedBox(),
          mapper: (StoreSnapshot<int> snapshot, String? routeName) =>
              snapshot.state,
        ),
      ),
    );

    final InheritedValueWidget<ReducedStoreAndState<int>> widget = find
        .singleWidgetByType(InheritedValueWidget<ReducedStoreAndState<int>>);

    final objectUnderTest = widget.value.store;
    objectUnderTest.process(CounterIncremented());
    expect(objectUnderTest.state, 1);
  });
}
