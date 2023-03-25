import 'package:flutter_riverpod/flutter_riverpod.dart';

final dateProvider =
    StateProvider.autoDispose<DateTime>((ref) => DateTime.now());
final addWeightStatus = StateProvider<bool>((ref) => true);
