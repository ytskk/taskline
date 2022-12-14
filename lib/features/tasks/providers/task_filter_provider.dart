import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskline/features/features.dart';

/// Controls filter option.
final taskFilterProvider = StateProvider<TaskFilter>((ref) {
  return TaskFilter.all;
});
