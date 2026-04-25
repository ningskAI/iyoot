# Context Menu for EPUB Reader

This directory contains the context menu widgets for text selection and annotation in the EPUB reader.

## Files

- `excerpt_menu.dart` - Main context menu that appears when text is selected or an annotation is clicked
- `reader_note_menu.dart` - Note editor panel for adding thoughts/notes to annotations

## Features

### Text Selection
When users select text in the EPUB reader, a context menu appears with options to:
- **Copy** - Copy selected text to clipboard
- **Search** - Search the selected text on Bing
- **Add Note** - Add personal thoughts/notes to the selection

### Annotations
Users can annotate text with different styles:
- **Underline** - Underline the text
- **Highlight** - Highlight the text background
- **Squiggly** - Squiggly underline
- **Strikeout** - Strike through the text

Each annotation type supports multiple colors (yellow, green, blue, red, purple, orange).

### Notes
- Click on an existing annotation to edit it
- Add personal notes/thoughts to any annotation
- Delete annotations with confirmation

## Usage

The context menu is automatically triggered by the `onSelectionEnd` and `onAnnotationClick` JavaScript handlers in `epub_player.dart`.

```dart
showContextMenu(
  context,
  left, top, right, bottom,  // Selection coordinates (0.0-1.0)
  text,                       // Selected text content
  cfi,                        // EPUB CFI location
  annotationId,               // null for new selection, id for existing annotation
  isFootnote,                 // Whether this is a footnote
  axis,                       // Axis.horizontal or Axis.vertical
  contextText: contextText,   // Optional surrounding context
);
```

## Integration

The context menu integrates with:
- `bookNoteNotifierProvider` - For saving/loading annotations
- `BookNote` model - Stores annotation data (type, color, content, cfi, readerNote)
- Foliate.js - Handles text selection and rendering annotations

## TODO

- [ ] Add localization strings to L10n
- [ ] Implement writing mode detection (vertical/horizontal text)
- [ ] Add TTS (Text-to-Speech) functionality
- [ ] Add auto-annotation preference setting
- [ ] Support more annotation types
