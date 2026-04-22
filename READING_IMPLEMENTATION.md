# EPUB Reading Implementation Guide

## 项目结构

```
lib/
├── data/
│   ├── models/
│   │   ├── reading_position.dart      # 阅读位置模型
│   │   ├── reading_theme.dart         # 阅读主题模型
│   │   ├── book_bookmark.dart         # 书签模型
│   │   └── book_note.dart             # 笔记模型
│   └── enums/
│       └── reading_enums.dart         # 阅读相关枚举
├── providers/
│   ├── reading_position_provider.dart # 阅读位置Provider
│   ├── reading_theme_provider.dart    # 阅读主题Provider
│   └── chapter_content_provider.dart  # 章节内容Provider
├── services/
│   └── reading_service.dart           # 阅读业务逻辑服务
├── ui/
│   └── pages/
│       └── reading/
│           ├── reading_page.dart      # 主阅读页面
│           ├── epub_player.dart       # EPUB播放器核心
│           └── widgets/
│               ├── reading_style_panel.dart     # 样式设置面板
│               ├── reading_toc_panel.dart       # 目录面板
│               ├── reading_bookmark_panel.dart  # 书签面板
│               ├── reading_progress_bar.dart    # 进度条组件
│               └── index.dart                   # widgets导出文件
```

## 核心概念

### 1. EpubPlayer
主要的阅读器组件，负责：
- 渲染EPUB内容（通过WebView）
- 处理用户交互（翻页、章节导航等）
- 管理阅读状态

### 2. Provider架构
- `readingPositionProvider`: 跟踪当前阅读位置
- `readingThemesProvider`: 管理可用的阅读主题
- `currentReadingThemeProvider`: 当前选中的主题
- `chapterContentBridgeProvider`: 章节内容获取接口

### 3. Widgets
- `ReadingStylePanel`: 字体大小、行高、主题切换
- `ReadingTocPanel`: 目录导航
- `ReadingBookmarkPanel`: 书签管理
- `ReadingProgressBar`: 阅读进度显示

## 使用示例

```dart
// 导航到阅读页面
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => ReadingPage(
      book: selectedBook,
      initialCfi: null, // 从上次位置继续或null从开头开始
    ),
  ),
);
```

## 待完成项

1. **WebView集成**
   - 实现EPUB.js/Foliate的WebView加载
   - 处理JavaScript与Dart的交互

2. **数据库集成**
   - 保存/加载阅读进度
   - 管理书签和笔记

3. **功能实现**
   - 搜索功能
   - 文本到语音（TTS）
   - 进阶主题定制
   - 笔记和注释

4. **性能优化**
   - 章节内容缓存
   - WebView内存管理
   - 滚动优化

## 规范化要求

✅ **分层结构**
- Models: 数据模型定义
- Services: 业务逻辑
- Providers: 状态管理
- Widgets: UI组件

✅ **命名规范**
- 文件名: snake_case
- 类名: PascalCase
- 常量: camelCase

✅ **代码组织**
- 相关文件分组在同一目录
- 使用index.dart导出公共API
- 保持单一职责原则
