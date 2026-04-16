import 'package:flutter/material.dart';
import '../config/default.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          Container(
            color: Colors.white,
            child: TabBar(
              labelColor: clPrimary,
              unselectedLabelColor: Colors.grey,
              indicatorColor: clPrimary,
              tabs: const [
                Tab(icon: Icon(Icons.facebook), text: 'Facebook'),
                Tab(icon: Icon(Icons.message), text: 'Messenger'),
                Tab(icon: Icon(Icons.more_horiz), text: 'Khác'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildContactCard(
                  icon: Icons.facebook,
                  title: 'Facebook',
                  subtitle: 'Fashion Shop Official',
                  color: Colors.blue,
                ),
                _buildContactCard(
                  icon: Icons.message,
                  title: 'Messenger',
                  subtitle: 'Chat với chúng tôi',
                  color: Colors.purple,
                ),
                _buildOtherContacts(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(32),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 80, color: color),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: const Text('Kết nối'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOtherContacts() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.red[100],
            child: const Icon(Icons.email, color: Colors.red),
          ),
          title: const Text('Email'),
          subtitle: const Text('support@fashionshop.com'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {},
        ),
        const Divider(),
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.green[100],
            child: const Icon(Icons.phone, color: Colors.green),
          ),
          title: const Text('Hotline'),
          subtitle: const Text('1900 1234'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {},
        ),
        const Divider(),
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.orange[100],
            child: const Icon(Icons.location_on, color: Colors.orange),
          ),
          title: const Text('Địa chỉ'),
          subtitle: const Text('123 Nguyễn Văn A, Q.1, TP.HCM'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {},
        ),
      ],
    );
  }
}
