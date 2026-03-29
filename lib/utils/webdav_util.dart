import 'dart:io';
import 'package:webdav_client/webdav_client.dart' as webdav;

class WebDavUtil {
  WebDavUtil._internal();
  static final WebDavUtil _instance = WebDavUtil._internal();
  factory WebDavUtil() => _instance;

  webdav.Client? _client;

  /// 初始化并验证 WebDAV 连接
  /// 
  /// 如果连接成功并能确保远程目录存在，则返回 null，否则返回错误信息
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
      // 如果账号密码错误或服务器不通，这里会抛出异常
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

  /// 备份文件到 WebDAV
  Future<void> uploadFile(File localFile, String remotePath) async {
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
    } catch (_) {
      // 文件不存在或其他删除错误通常不影响备份流程
    }
  }
}
