import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iyoot/l10n/generated/L10n.dart';
import 'package:iyoot/provider/backup_provider.dart';
import 'package:iyoot/utils/security_util.dart';
import 'package:iyoot/utils/webdav_util.dart';

class WebDavSettingsPage extends ConsumerStatefulWidget {
  const WebDavSettingsPage({super.key});

  @override
  ConsumerState<WebDavSettingsPage> createState() => _WebDavSettingsPageState();
}

class _WebDavSettingsPageState extends ConsumerState<WebDavSettingsPage> {
  final _urlController = TextEditingController();
  final _userController = TextEditingController();
  final _pwdController = TextEditingController();
  final _pathController = TextEditingController();
  bool _obscurePwd = true;
  bool _isTesting = false;

  @override
  void dispose() {
    _urlController.dispose();
    _userController.dispose();
    _pwdController.dispose();
    _pathController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    final configAsync = ref.watch(webDavConfigNotifierProvider);

    ref.listen(webDavConfigNotifierProvider, (previous, next) {
      next.whenData((config) {
        if (config != null && _urlController.text.isEmpty) {
          _urlController.text = config.url;
          _userController.text = config.username;
          _pwdController.text = SecurityUtil.decrypt(config.password);
          _pathController.text = config.rootPath;
        }
      });
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.webDavSettings),
      ),
      body: configAsync.when(
        data: (config) => SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Column(
                children: [
                  _buildTextField(
                    controller: _urlController,
                    label: l10n.webDavServerAddress,
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _userController,
                    label: l10n.webDavAccount,
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _pwdController,
                    label: l10n.webDavPassword,
                    isPassword: true,
                    obscure: _obscurePwd,
                    onToggleObscure: () => setState(() => _obscurePwd = !_obscurePwd),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _pathController,
                decoration: InputDecoration(
                  labelText: l10n.webDavSubFolder,
                  border: const OutlineInputBorder(),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: _buildActionButton(
                      label: _isTesting ? "测试中..." : l10n.testConnection,
                      onPressed: _isTesting ? () {} : _testConnection,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildSaveButton(
                      label: _isTesting ? "验证中..." : l10n.saveConfig,
                      onPressed: _isTesting ? () {} : _saveConfig,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text(err.toString())),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    bool isPassword = false,
    bool obscure = false,
    VoidCallback? onToggleObscure,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                onPressed: onToggleObscure,
              )
            : null,
      ),
    );
  }

  Widget _buildActionButton({required String label, required VoidCallback onPressed}) {
    return FilledButton.tonal(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(label),
    );
  }

  Widget _buildSaveButton({required String label, required VoidCallback onPressed}) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      child: Text(label),
    );
  }

  Future<void> _testConnection() async {
    setState(() => _isTesting = true);
    
    final error = await WebDavUtil().initAndVerify(
      url: _urlController.text,
      user: _userController.text,
      password: _pwdController.text,
      rootPath: _pathController.text,
    );

    if (!mounted) return;
    setState(() => _isTesting = false);

    if (error == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("WebDAV 连接测试成功！"), backgroundColor: Colors.green),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("连接失败: $error"), backgroundColor: Colors.red),
      );
    }
  }

  Future<void> _saveConfig() async {
    setState(() => _isTesting = true);

    // 保存前先强制进行连接测试
    final error = await WebDavUtil().initAndVerify(
      url: _urlController.text,
      user: _userController.text,
      password: _pwdController.text,
      rootPath: _pathController.text,
    );

    if (!mounted) return;
    setState(() => _isTesting = false);

    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("连接验证失败，无法保存: $error"), backgroundColor: Colors.red),
      );
      return;
    }

    // 验证通过，执行保存
    final encrypted = SecurityUtil.encrypt(_pwdController.text);
    await ref.read(webDavConfigNotifierProvider.notifier).updateConfig(
          url: _urlController.text,
          username: _userController.text,
          password: encrypted,
          rootPath: _pathController.text,
        );
    
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${L10n.of(context).appName}: 连接成功，设置已保存")),
    );
  }
}
