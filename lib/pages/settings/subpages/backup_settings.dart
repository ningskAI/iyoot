import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iyoot/l10n/generated/L10n.dart';
import 'package:iyoot/provider/backup_provider.dart';
import 'package:iyoot/utils/security_util.dart';

class BackupPage extends ConsumerWidget {
  const BackupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = L10n.of(context);
    final configAsync = ref.watch(webDavConfigNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settingBackup),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: configAsync.when(
        data: (config) => ListView(
          children: [
            _buildSectionHeader(context, l10n.settingBackup),
            ListTile(
              title: Text(l10n.backupPath),
              subtitle: const Text("/storage/emulated/0/iYooT/backup"),
              onTap: () {},
            ),
            ListTile(
              title: Text(l10n.backup),
              subtitle: Text(l10n.backupSummary),
              onTap: () {},
            ),
            ListTile(
              title: Text(l10n.restore),
              subtitle: Text(l10n.restoreSummary),
              onTap: () {},
              onLongPress: () {},
            ),
            ListTile(
              title: Text(l10n.restoreIgnoreList),
              subtitle: Text(l10n.restoreIgnoreListSummary),
              onTap: () {},
            ),
            ListTile(
              title: Text(l10n.importOldData),
              subtitle: Text(l10n.importOldDataSummary),
              onTap: () {},
            ),
            SwitchListTile(
              title: Text(l10n.keepLatestBackupOnly),
              subtitle: Text(l10n.keepLatestBackupOnlySummary),
              value: config?.keepLatestOnly ?? true,
              onChanged: (value) => ref.read(webDavConfigNotifierProvider.notifier).updateConfig(keepLatestOnly: value),
            ),
            SwitchListTile(
              title: Text(l10n.autoCheckNewBackup),
              subtitle: Text(l10n.autoCheckNewBackupSummary),
              value: config?.autoCheckNew ?? true,
              onChanged: (value) => ref.read(webDavConfigNotifierProvider.notifier).updateConfig(autoCheckNew: value),
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text(err.toString())),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildTextFieldTile(
      BuildContext context, {
        required String title,
        required ValueChanged<String> onChanged,
        bool isPassword = false,
      }) {
    return ListTile(
      title: Text(title),
      onTap: () async {
        final controller = TextEditingController();
        final result = await showDialog<String>(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            title: Text(title, style: const TextStyle(fontFamily: 'serif', fontSize: 18)),
            content: TextField(
              controller: controller,
              obscureText: isPassword,
              autofocus: true,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("取消", style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5))),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, controller.text),
                child: Text("确定", style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        );
        if (result != null && result.isNotEmpty) {
          onChanged(result);
        }
      },
    );
  }
}
