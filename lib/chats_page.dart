import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'chat_detail_page.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ChatGroup> groups = [
      ChatGroup(id: 'common', name: 'Common Room', type: 'Special', lastMessage: 'Official announcements for all members.', time: 'Now', icon: LucideIcons.home),
      ChatGroup(id: 'domain_pr', name: 'PR Team', type: 'Domain', lastMessage: 'Press release drafted for the event.', time: '10:30 AM', icon: LucideIcons.megaphone),
      ChatGroup(id: 'domain_content', name: 'Content Writers', type: 'Domain', lastMessage: 'Reviewing the latest blog posts.', time: 'Yesterday', icon: LucideIcons.fileText),
      ChatGroup(id: 'domain_graphic', name: 'Graphic Designers', type: 'Domain', lastMessage: 'Poster designs finalized.', time: '9:45 AM', icon: LucideIcons.palette),
      ChatGroup(id: 'domain_photo', name: 'Photographers', type: 'Domain', lastMessage: 'Upload event photos here.', time: '2 days ago', icon: LucideIcons.camera),
      ChatGroup(id: 'domain_webapp', name: 'Web/App Developers', type: 'Domain', lastMessage: 'Beta testing active for v2.0.', time: 'Monday', icon: LucideIcons.code),
      ChatGroup(id: 'domain_video', name: 'Video Editors', type: 'Domain', lastMessage: 'Teaser video is rendering.', time: '3:00 PM', icon: LucideIcons.video),
      ChatGroup(id: 'year_1', name: '1st Year Students', type: 'Year', lastMessage: 'Orientation schedule shared.', time: '10/10/24', icon: LucideIcons.graduationCap),
      ChatGroup(id: 'year_2', name: '2nd Year Students', type: 'Year', lastMessage: 'Lab practicals update.', time: 'Yesterday', icon: LucideIcons.graduationCap),
      ChatGroup(id: 'year_3', name: '3rd Year Students', type: 'Year', lastMessage: 'Internship drive started.', time: '9:15 AM', icon: LucideIcons.graduationCap),
      ChatGroup(id: 'year_4', name: '4th Year Students', type: 'Year', lastMessage: 'Project submission deadline.', time: 'Monday', icon: LucideIcons.graduationCap),
      ChatGroup(id: 'combined_1_2', name: 'Combined 1st + 2nd Year', type: 'Combined', lastMessage: 'Combined workshop notice.', time: '12/10/24', icon: LucideIcons.users),
      ChatGroup(id: 'combined_1_2_3', name: 'Combined 1st+2nd+3rd Year', type: 'Combined', lastMessage: 'Squad meet scheduled.', time: 'Today', icon: LucideIcons.users),
      ChatGroup(id: 'combined_all', name: 'All Active Years', type: 'Combined', lastMessage: 'Annual meet details.', time: '11/10/24', icon: LucideIcons.layoutGrid),
      ChatGroup(id: 'alumni', name: 'Alumni Network', type: 'Special', lastMessage: 'Next reunion planning.', time: 'Last week', icon: LucideIcons.award),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatDetailPage(
                        groupName: group.name,
                        groupType: group.type,
                        icon: group.icon,
                      ),
                    ),
                  );
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
