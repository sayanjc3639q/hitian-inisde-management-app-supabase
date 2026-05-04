import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(),
            _buildStatsSection(),
            _buildSection(
              title: 'Organization Details',
              items: [
                _ProfileItem(icon: LucideIcons.users, title: 'See All Members', subtitle: 'View Maroon Squad team'),
                _ProfileItem(icon: LucideIcons.bookOpen, title: 'Guidelines', subtitle: 'Rules and regulations'),
                _ProfileItem(icon: LucideIcons.award, title: 'Founders & Alumni', subtitle: 'The legacy of HITian Inside'),
              ],
            ),
            _buildSection(
              title: 'Account Settings',
              items: [
                _ProfileItem(icon: LucideIcons.user, title: 'Edit Profile', subtitle: 'Update your information'),
                _ProfileItem(icon: LucideIcons.lock, title: 'Change Password', subtitle: 'Secure your account'),
                _ProfileItem(icon: LucideIcons.bell, title: 'Notifications', subtitle: 'Manage your alerts'),
              ],
            ),
            _buildLogoutButton(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 40, bottom: 24, left: 20, right: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF800000), width: 2),
                ),
                child: const CircleAvatar(
                  radius: 50,
                  backgroundColor: Color(0xFFF0F0F0),
                  child: Icon(LucideIcons.user, size: 50, color: Colors.grey),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Color(0xFF800000),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(LucideIcons.camera, size: 16, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Alex Sebastian',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF800000).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Web/App Developer',
              style: TextStyle(
                color: Color(0xFF800000),
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'CSE-AI | Semester 5 | Sec B',
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          _buildStatCard('Tasks', '12', LucideIcons.checkCircle2, Colors.blue),
          const SizedBox(width: 16),
          _buildStatCard('Credits', '450', LucideIcons.star, Colors.amber),
          const SizedBox(width: 16),
          _buildStatCard('Rank', '#4', LucideIcons.trendingUp, Colors.green),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 10, offset: const Offset(0, 4)),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(label, style: TextStyle(color: Colors.grey[500], fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required List<_ProfileItem> items}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24, top: 12, bottom: 8),
          child: Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 10, offset: const Offset(0, 4)),
            ],
          ),
          child: Column(
            children: items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return Column(
                children: [
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(item.icon, size: 20, color: Colors.black87),
                    ),
                    title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                    subtitle: Text(item.subtitle, style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                    trailing: const Icon(LucideIcons.chevronRight, size: 16, color: Colors.black26),
                    onTap: () {},
                  ),
                  if (index != items.length - 1)
                    Divider(height: 1, indent: 70, color: Colors.grey[100]),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildLogoutButton() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          foregroundColor: Colors.red,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(LucideIcons.logOut, size: 20),
            SizedBox(width: 8),
            Text('Log Out', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

class _ProfileItem {
  final IconData icon;
  final String title;
  final String subtitle;

  _ProfileItem({required this.icon, required this.title, required this.subtitle});
}
