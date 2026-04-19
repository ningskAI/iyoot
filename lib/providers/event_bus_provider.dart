import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_reader/core/event/app_events.dart';
import 'package:i_reader/core/event/event_bus.dart';

final eventBusProvider = Provider<EventBus>((ref) {
  return EventBus.instance;
});

final bookCollectionEventProvider = StreamProvider<BookCollectionChangedEvent>((
  ref,
) {
  return ref.watch(eventBusProvider).on<BookCollectionChangedEvent>();
});
