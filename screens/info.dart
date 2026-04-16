import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/default.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  String _name = '';
  String _email = '';
  String _phone = '';
  int _gender = 0;
  List<String> _hobbies = [];

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('user_name') ?? 'Chưa cập nhật';
      _email = prefs.getString('user_email') ?? 'Chưa cập nhật';
      _phone = prefs.getString('user_phone') ?? 'Chưa cập nhật';
      _gender = prefs.getInt('user_gender') ?? 0;
      _hobbies = prefs.getStringList('user_hobbies') ?? [];
    });
  }

  String _getGenderText(int gender) {
    switch (gender) {
      case 0:
        return 'Nam';
      case 1:
        return 'Nữ';
      default:
        return 'Khác';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: clPrimary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: clPrimary,
                  child: const Icon(
                    Icons.person,
                    size: 60,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Xin chào, $_name!',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Info Cards
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _buildInfoTile(
                  icon: Icons.email,
                  title: 'Email',
                  value: _email,
                ),
                const Divider(height: 1),
                _buildInfoTile(
                  icon: Icons.phone,
                  title: 'Số điện thoại',
                  value: _phone,
                ),
                const Divider(height: 1),
                _buildInfoTile(
                  icon: Icons.person,
                  title: 'Giới tính',
                  value: _getGenderText(_gender),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Hobbies Section
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.favorite, color: Colors.pink),
                      SizedBox(width: 8),
                      Text(
                        'Sở thích',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _hobbies.isEmpty
                      ? const Text('Chưa cập nhật')
                      : Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: _hobbies.map((hobby) {
                            return Chip(
                              label: Text(hobby),
                              backgroundColor: clPrimary.withOpacity(0.1),
                              avatar: const Icon(
                                Icons.check_circle,
                                color: Colors.pink,
                                size: 18,
                              ),
                            );
                          }).toList(),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return ListTile(
      leading: Icon(icon, color: clPrimary),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.grey,
        ),
      ),
      subtitle: Text(
        value,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
