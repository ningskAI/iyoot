import 'package:encrypt/encrypt.dart';

class SecurityUtil {
  // 注意：在实际生产环境中，Key 应当通过更加安全的方式存储或派生。
  // 这里的 Key 需要 32 位字符
  static final _key = Key.fromUtf8('my-secret-key-for-iyoot-32chars!');
  static final _iv = IV.fromLength(16);
  static final _encrypter = Encrypter(AES(_key));

  /// 加密字符串
  static String encrypt(String plainText) {
    if (plainText.isEmpty) return "";
    final encrypted = _encrypter.encrypt(plainText, iv: _iv);
    return encrypted.base64;
  }

  /// 解密字符串
  static String decrypt(String encryptedText) {
    if (encryptedText.isEmpty) return "";
    try {
      return _encrypter.decrypt64(encryptedText, iv: _iv);
    } catch (e) {
      // 如果解密失败（例如 Key 变更），返回空字符串或抛出异常
      return "";
    }
  }
}
