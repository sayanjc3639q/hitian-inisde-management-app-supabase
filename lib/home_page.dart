import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Greeting and Domain
          _buildGreetingSection(context),
          const SizedBox(height: 24),

          // 2. Announcements
          _buildSectionHeader(context, 'Announcements', onSeeAll: () {}),
          const SizedBox(height: 12),
          _buildAnnouncementCard(context),
          const SizedBox(height: 24),

          // 3. Stats (Task Count, Events Participated)
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  context,
                  'Task Count',
                  '--', // Placeholder for data
                  LucideIcons.checkSquare,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatCard(
                  context,
                  'Events Participated',
                  '--', // Placeholder for data
                  LucideIcons.users,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // 4. My Tasks
          _buildSectionHeader(context, 'My Tasks', onSeeAll: () {}),
          const SizedBox(height: 12),
          _buildTaskList(context),
          const SizedBox(height: 24),

          // 5. Navigation Links
          _buildNavLink(context, 'See all members', LucideIcons.userPlus),
          _buildNavLink(
            context,
            'Guidelines of HITian Inside',
            LucideIcons.bookOpen,
          ),
          _buildNavLink(
            context,
            'See Founders and Alumni',
            LucideIcons.graduationCap,
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildGreetingSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hello, [First Name]', // Placeholder
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '[Domain Name]', // Placeholder (e.g. Web/App Developer)
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    String title, {
    VoidCallback? onSeeAll,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        if (onSeeAll != null)
          TextButton(onPressed: onSeeAll, child: const Text('See all')),
      ],
    );
  }

  Widget _buildAnnouncementCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'No recent announcements', // Placeholder
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            'Stay tuned for updates from the Maroon Squad.',
            style: TextStyle(fontSize: 12, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary, size: 24),
          const SizedBox(height: 12),
          Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildTaskList(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildTaskItem(context, 'No tasks assigned', false), // Placeholder
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {},
              child: const Text('See details'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskItem(BuildContext context, String title, bool isCompleted) {
    return ListTile(
      leading: Icon(
        isCompleted ? LucideIcons.checkCircle : LucideIcons.circle,
        color: isCompleted ? Colors.green : Colors.grey,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isCompleted ? Colors.grey : Colors.black,
          decoration: isCompleted ? TextDecoration.lineThrough : null,
        ),
      ),
    );
  }

  Widget _buildNavLink(BuildContext context, String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: Theme.of(context).colorScheme.primary,
                size: 20,
              ),
              const SizedBox(width: 16),
              Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
              const Spacer(),
              const Icon(
                LucideIcons.chevronRight,
                size: 16,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
