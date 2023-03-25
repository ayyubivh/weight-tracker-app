import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../helper/helper_functions.dart';
import '../service/database_service.dart';

final dateProvider =
    StateProvider.autoDispose<DateTime>((ref) => DateTime.now());
final userNameProvider = StateProvider<String>((ref) => '');
final userWeights = StateProvider<Stream?>((ref) {});
final getUsers = StateProvider<Function>((ref) => (ref) {});
