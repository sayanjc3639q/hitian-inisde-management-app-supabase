import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ChatGroup> groups = [
      ChatGroup(id: 'common', name: 'Common Room', type: 'Special', lastMessage: 'Welcome to the Maroon Squad!', time: '9:41 AM', icon: LucideIcons.users),
      ChatGroup(id: 'domain_pr', name: 'PR Team', type: 'Domain', lastMessage: 'New event posters are ready.', time: 'Yesterday', icon: LucideIcons.megaphone),
      ChatGroup(id: 'domain_webapp', name: 'Web/App Developers', type: 'Domain', lastMessage: 'Flutter project initialized.', time: 'Monday', icon: LucideIcons.code),
      ChatGroup(id: 'year_3', name: '3rd Year Students', type: 'Year', lastMessage: 'Exam schedule updated.', time: '12/10/24', icon: LucideIcons.graduationCap),
      ChatGroup(id: 'combined_all', name: 'All Active Years', type: 'Combined', lastMessage: 'Meeting at 5 PM.', time: '11/10/24', icon: LucideIcons.layoutGrid),
      ChatGroup(id: 'alumni', name: 'Alumni Network', type: 'Special', lastMessage: 'Job opportunity shared.', time: '10/10/24', icon: LucideIcons.award),
      // Add more as needed...
    ];

    return Column(
      children: [
        // Search Bar
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search groups...',
              prefixIcon: const Icon(LucideIcons.search, size: 20),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
            ),
          ),
        ),
        
        // Chat List
        Expanded(
          child: ListView.separated(
            itemCount: groups.length,
            separatorBuilder: (context, index) => const Divider(height: 1, indent: 80),
            itemBuilder: (context, index) {
              final group = groups[index];
              return ListTile(
                leading: CircleAvatar(
                  radius: 28,
                  backgroundColor: _getGroupColor(group.type).withValues(alpha: 0.1),
                  child: Icon(group.icon, color: _getGroupColor(group.type), size: 24),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      group.name,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      group.time,
                      style: TextStyle(color: Colors.grey[500], fontSize: 12),
                    ),
                  ],
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          group.lastMessage,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.grey[600], fontSize: 14),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          group.type,
                          style: TextStyle(
                            fontSize: 10,
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  // Navigate to chat detail
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Color _getGroupColor(String type) {
    switch (type) {
      case 'Domain': return Colors.blue;
      case 'Year': return Colors.orange;
      case 'Combined': return Colors.purple;
      case 'Special': return const Color(0xFF800000);
      default: return Colors.grey;
    }
  }
}

class ChatGroup {
  final String id;
  final String name;
  final String type;
  final String lastMessage;
  final String time;
  final IconData icon;

  ChatGroup({
    required this.id,
    required this.name,
    required this.type,
    required this.lastMessage,
    required this.time,
    required this.icon,
  });
}
