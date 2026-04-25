class BookNote {
  int? id;
  int bookId;
  String content;
  String cfi;
  String chapter;
  String type;
  String color;
  String? readerNote;
  DateTime? createTime;
  DateTime updateTime;

  void setId(int id) {
    this.id = id;
  }

  BookNote({
    this.id,
    required this.bookId,
    required this.content,
    required this.cfi,
    required this.chapter,
    required this.type,
    required this.color,
    this.readerNote,
    this.createTime,
    required this.updateTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'bookId': bookId,
      'content': content,
      'cfi': cfi,
      'chapter': chapter,
      'type': type,
      'color': color,
      'readerNote': readerNote,
      'createTime': createTime?.toIso8601String(),
      'updateTime': updateTime.toIso8601String(),
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'note': content,
      'value': cfi,
      'type': type,
      'color': '#$color',
    };
  }

  factory BookNote.fromJson(Map<String, dynamic> map) {
    final createTimeString = map['createTime'] as String?;
    final updateTimeString = map['updateTime'] as String?;

    return BookNote(
      id: map['id'] as int?,
      bookId: map['bookId'] as int,
      content: map['content'] as String? ?? '',
      cfi: map['cfi'] as String? ?? '',
      chapter: map['chapter'] as String? ?? '',
      type: map['type'] as String? ?? '',
      color: map['color'] as String? ?? '',
      readerNote: map['readerNote'] as String?,
      createTime: createTimeString != null
          ? DateTime.tryParse(createTimeString)
          : null,
      updateTime: updateTimeString != null
          ? DateTime.parse(updateTimeString)
          : DateTime.now(),
    );
  }
}
