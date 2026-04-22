import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_reader/data/models/reading_theme.dart';

final readingThemesProvider =
    StateNotifierProvider<ReadingThemesNotifier, List<ReadingTheme>>(
      (ref) => ReadingThemesNotifier(),
    );

final currentReadingThemeProvider =
    StateNotifierProvider<CurrentReadingThemeNotifier, ReadingTheme?>(
      (ref) => CurrentReadingThemeNotifier(),
    );

class ReadingThemesNotifier extends StateNotifier<List<ReadingTheme>> {
  ReadingThemesNotifier()
    : super([
        const ReadingTheme(
          id: 1,
          backgroundColor: 'ffffffff',
          textColor: 'ff000000',
          backgroundImagePath: '',
        ),
        const ReadingTheme(
          id: 2,
          backgroundColor: 'ff121212',
          textColor: 'ffcccccc',
          backgroundImagePath: '',
        ),
      ]);

  void addTheme(ReadingTheme theme) {
    state = [...state, theme];
  }

  void updateTheme(ReadingTheme theme) {
    state = [
      for (final t in state)
        if (t.id == theme.id) theme else t,
    ];
  }

  void removeTheme(int id) {
    state = state.where((t) => t.id != id).toList();
  }
}

class CurrentReadingThemeNotifier extends StateNotifier<ReadingTheme?> {
  CurrentReadingThemeNotifier()
    : super(
        const ReadingTheme(
          id: 1,
          backgroundColor: 'ffffffff',
          textColor: 'ff000000',
          backgroundImagePath: '',
        ),
      );

  void setTheme(ReadingTheme theme) {
    state = theme;
  }
}
