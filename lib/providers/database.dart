import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_reader/data/database/database.dart';

final databaseProvider = Provider((ref) => AppDatabase());
