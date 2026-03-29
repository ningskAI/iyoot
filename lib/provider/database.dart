import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iyoot/models/database/database.dart';

final databaseProvider = Provider((ref) => AppDatabase());