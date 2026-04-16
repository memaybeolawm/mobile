import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/default.dart';

class ConfigScreen extends StatefulWidget {
  const ConfigScreen({super.key});

  @override
  State<ConfigScreen> createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  bool _darkMode = false;
  bool _notifications = true;
  bool _soundEffects = true;
  String _language = 'Tiếng Việt';

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _darkMode = prefs.getBool('dark_mode') ?? false;
      _notifications = prefs.getBool('notifications') ?? true;
      _soundEffects = prefs.getBool('sound_effects') ?? true;
      _language = prefs.getString('language') ?? 'Tiếng Việt';
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('dark_mode', _darkMode);
    await prefs.setBool('notifications', _notifications);
    await prefs.setBool('sound_effects', _soundEffects);
    await prefs.setString('language', _language);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Display Settings
        const Text(
          'Hiển thị',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              SwitchListTile(
                title: const Text('Chế độ tối'),
                subtitle: const Text('Bật/tắt giao diện tối'),
                value: _darkMode,
                activeThumbColor: clPrimary,
                onChanged: (value) {
                  setState(() {
                    _darkMode = value;
                  });
                  _saveSettings();
                },
                secondary: Icon(
                  _darkMode ? Icons.dark_mode : Icons.light_mode,
                  color: clPrimary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Notification Settings
        const Text(
          'Thông báo',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              SwitchListTile(
                title: const Text('Thông báo đẩy'),
                subtitle: const Text('Nhận thông báo khuyến mãi'),
                value: _notifications,
                activeThumbColor: clPrimary,
                onChanged: (value) {
                  setState(() {
                    _notifications = value;
                  });
                  _saveSettings();
                },
                secondary: Icon(
                  Icons.notifications,
                  color: clPrimary,
                ),
              ),
              const Divider(height: 1),
              SwitchListTile(
                title: const Text('Âm thanh'),
                subtitle: const Text('Bật/tắt âm thanh hiệu ứng'),
                value: _soundEffects,
                activeThumbColor: clPrimary,
                onChanged: (value) {
                  setState(() {
                    _soundEffects = value;
                  });
                  _saveSettings();
                },
                secondary: Icon(
                  Icons.volume_up,
                  color: clPrimary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Language Settings
        const Text(
          'Ngôn ngữ',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: Icon(Icons.language, color: clPrimary),
            title: const Text('Ngôn ngữ hiển thị'),
            subtitle: Text(_language),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              _showLanguageDialog();
            },
          ),
        ),
        const SizedBox(height: 24),

        // About Section
        const Text(
          'Thông tin',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.info, color: clPrimary),
                title: const Text('Phiên bản'),
                subtitle: const Text('1.0.0'),
              ),
              const Divider(height: 1),
              ListTile(
                leading: Icon(Icons.policy, color: clPrimary),
                title: const Text('Điều khoản sử dụng'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
              const Divider(height: 1),
              ListTile(
                leading: Icon(Icons.privacy_tip, color: clPrimary),
                title: const Text('Chính sách bảo mật'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Chọn ngôn ngữ'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: const Text('Tiếng Việt'),
              value: 'Tiếng Việt',
              groupValue: _language,
              onChanged: (value) {
                setState(() {
                  _language = value!;
                });
                _saveSettings();
                Navigator.pop(context);
              },
            ),
            RadioListTile<String>(
              title: const Text('English'),
              value: 'English',
              groupValue: _language,
              onChanged: (value) {
                setState(() {
                  _language = value!;
                });
                _saveSettings();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
