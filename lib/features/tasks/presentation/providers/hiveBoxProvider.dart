import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce/hive.dart';

final hiveBoxProvider = Provider<Box>((ref) {
  return Hive.box('TasksHiveBox');
});
