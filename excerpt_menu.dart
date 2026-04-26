
  // Helper method to apply annotation changes (type/color) and save once
  Future<void> _applyAnnotationChanges({String? type, String? color}) async {
    final newType = type ?? annoType;
    final newColor = color ?? annoColor;

    // Update local state
    if (mounted) {
      setState(() {
        annoType = newType;
        annoColor = newColor;
        if (type != null) _selectedAnnotationType = type;
      });
    } else {
      annoType = newType;
      annoColor = newColor;
      if (type != null) _selectedAnnotationType = type;
    }

    // Save configuration
    if (type != null) {
      await AppConfig.setLastAnnotationType(newType);
    }
    if (color != null) {
      await AppConfig.setLastAnnotationColor(newColor);
    }

    // Persist note once
    final bookNote = await _persistNote(type: type, color: color);

    // Update WebView annotation
    if (mounted) {
      epubPlayerKey.currentState?.addAnnotation(bookNote);
    }
  }

  Future<void> onColorSelected(String color, {bool close = false}) async {
    await _applyAnnotationChanges(color: color);
    // Do not close menu here if called from picker, let caller decide
  }

  Future<void> onTypeSelected(String type) async {
    await _applyAnnotationChanges(type: type);
  }


  // 显示颜色选择对话框
  void _showColorPickerDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xFF2C2C2E),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '选择标注样式',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              // 颜色列表
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: notesColors.map((color) {
                  final isSelected = annoColor == color;
                  return GestureDetector(
                    onTap: () async {
                      Navigator.pop(ctx);
                      // Apply both type and color in one go
                      await _applyAnnotationChanges(
                        type: _selectedAnnotationType ?? 'highlight',
                        color: color,
                      );
                      // 关闭所有菜单
                      widget.onClose();
                    },
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Color(int.parse('0xff$color')),
                        shape: BoxShape.circle,
                        border: isSelected
                            ? Border.all(color: Colors.white, width: 3)
                            : null,
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.5),
                                  blurRadius: 8,
                                  spreadRadius: 2,
                                ),
                              ]
                            : null,
                      ),
                      child: isSelected
                          ? const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 24,
                            )
                          : null,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              // 下划线按钮
              GestureDetector(
                onTap: () async {
                  Navigator.pop(ctx);
                  // Apply underline type and current color
                  await _applyAnnotationChanges(
                    type: 'underline',
                    color: annoColor,
                  );
                  // 关闭所有菜单
                  widget.onClose();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: _selectedAnnotationType == 'underline'
                        ? Color(int.parse('0xff$annoColor')).withOpacity(0.3)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: _selectedAnnotationType == 'underline'
                          ? Color(int.parse('0xff$annoColor'))
                          : Colors.white54,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.format_underline,
                        color: _selectedAnnotationType == 'underline'
                            ? Color(int.parse('0xff$annoColor'))
                            : Colors.white,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        '下划线',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }


          // Add/Edit Note - 添加笔记按钮
          if (!widget.footnote)
            _buildOperatorItem(
              icon: Icon(
                hasNote ? Icons.sticky_note_2 : Icons.edit_note,
                color: hasNote ? const Color(0xFFFFD700) : Colors.white,
                size: 20,
              ),
              text: hasNote ? '编辑笔记' : '添加笔记',
              onTap: () async {
                // 点击添加笔记时，如果还没有标注，使用上次配置创建标注
                if (noteId == null && widget.id == null) {
                  // Use the combined method to save once
                  await _applyAnnotationChanges(
                    type: annoType,
                    color: annoColor,
                  );
                }

                // 然后打开笔记编辑界面
                final targetId = noteId ?? widget.id;
                if (targetId != null) {
                  await widget.openReaderNoteMenu(targetId);
                } else {
                  widget.toggleReaderNoteMenu(show: true);
                }
              },
            ),
