import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_reader/core/database/database.dart';

final databaseProvider = Provider((ref) => AppDatabase());
