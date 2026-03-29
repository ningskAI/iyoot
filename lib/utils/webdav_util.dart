import 'dart:io' as io;
import 'package:webdav_client/webdav_client.dart' as webdav;

class WebDavUtil {
  WebDavUtil._internal();
  static final WebDavUtil _instance = WebDavUtil._internal();
  factory WebDavUtil() => _instance;

  webdav.Client? _client;

  /// 初始化并验证 WebDAV 连接
  Future<String?> initAndVerify({
    required String url,
    required String user,
    required String password,
    required String rootPath,
  }) async {
    try {
      final client = webdav.newClient(
        url,
        user: user,
        password: password,
      )
        ..setHeaders({'accept-charset': 'utf-8'})
        ..setConnectTimeout(10000)
        ..setReceiveTimeout(10000)
        ..setSendTimeout(10000);

      // 验证连接：尝试创建或进入根目录
      await client.mkdirAll(rootPath);
      
      _client = client;
      return null;
    } catch (e) {
      _client = null;
      return e.toString();
    }
  }

  /// 检查当前客户端是否可用
  bool get isReady => _client != null;

  /// 1. 获取指定目录下的子目录列表（用于选择导入目录）
  Future<List<webdav.File>> listDirectories(String path) async {
    if (_client == null) throw Exception("WebDAV Client not initialized");
    
    final items = await _client!.readDir(path);
    final String normalizedPath = path.endsWith('/') ? path : '$path/';
    
    return items.where((item) {
      final bool isSelf = item.path == path || item.path == normalizedPath;
      return item.isDir == true && !isSelf && item.name != '..';
    }).toList();
  }

  /// 2. 获取指定目录下所有的文件
  Future<List<webdav.File>> listFiles(String path) async {
    if (_client == null) throw Exception("WebDAV Client not initialized");
    final items = await _client!.readDir(path);
    return items.where((item) => item.isDir == false).toList();
  }

  /// 3. 异步批量获取书籍元数据（针对不同格式动态调整 Range 读取）
  Future<List<Map<String, dynamic>>> fetchBooksMetadataBatch(List<String> remotePaths) async {
    if (_client == null) throw Exception("WebDAV Client not initialized");
    
    final List<Map<String, dynamic>> results = [];
    
    for (final path in remotePaths) {
      // 防封禁：请求间隔随机延迟 1s-2s
      await Future.delayed(Duration(milliseconds: 1000 + (DateTime.now().millisecond % 1000)));
      
      try {
        final isEpub = path.toLowerCase().endsWith('.epub');
        
        // 核心逻辑调整：
        // EPUB 是 ZIP 格式，索引（Central Directory）在文件末尾，所以读末尾。
        // M4B (MP4) 元数据通常在头部（如果是 Fast Start 优化），所以读头部。
        final rangeHeader = isEpub ? 'bytes=-524288' : 'bytes=0-524288';

        _client!.setHeaders({
          'Range': rangeHeader,
          'accept-charset': 'utf-8',
        });
        
        final data = await _client!.read(path);
        
        results.add({
          'path': path,
          'data': data,
          'success': true,
          'isTailRead': isEpub, // 标记是读取的尾部还是头部
        });
      } catch (e) {
        results.add({
          'path': path,
          'error': e.toString(),
          'success': false,
        });
      } finally {
        _client!.setHeaders({'accept-charset': 'utf-8'});
      }
    }
    return results;
  }

  /// 备份文件到 WebDAV
  Future<void> uploadFile(io.File localFile, String remotePath) async {
    if (_client == null) throw Exception("WebDAV Client not initialized");
    final bytes = await localFile.readAsBytes();
    await _client!.write(remotePath, bytes);
  }

  /// 从 WebDAV 下载文件
  Future<List<int>> downloadFile(String remotePath) async {
    if (_client == null) throw Exception("WebDAV Client not initialized");
    return await _client!.read(remotePath);
  }

  /// 删除远程文件
  Future<void> deleteFile(String remotePath) async {
    if (_client == null) return;
    try {
      await _client!.remove(remotePath);
    } catch (_) {}
  }
}
