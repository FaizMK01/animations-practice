import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fx_2_folder/butterfly/butterfly.dart';
import 'package:fx_2_folder/main.dart';
import 'package:fx_2_folder/notification-list/notification_list.dart';

void main() {
  testWidgets('AnimationShowcaseApp renders HomeScreen with Butterfly Flight', (WidgetTester tester) async {
    await tester.pumpWidget(const AnimationShowcaseApp());
    expect(find.text('Animation Showcase'), findsOneWidget);
    expect(find.text('Butterfly Flight'), findsOneWidget);
  });

  testWidgets('FlutterButterfly renders and animates properly', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: FlutterButterfly(width: 50, height: 35),
      ),
    ));
    expect(find.byType(FlutterButterfly), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 250));
    expect(find.byType(FlutterButterfly), findsOneWidget);
  });

  testWidgets('NotificationDemo disposes safely without error', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: NotificationDemo(),
    ));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    // Pop/dispose widget
    await tester.pumpWidget(const MaterialApp(home: Scaffold(body: Text('Done'))));
    await tester.pump();
    expect(find.text('Done'), findsOneWidget);
  });
}
