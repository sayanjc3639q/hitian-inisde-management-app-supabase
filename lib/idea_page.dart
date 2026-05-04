import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class IdeaPage extends StatefulWidget {
  const IdeaPage({super.key});

  @override
  State<IdeaPage> createState() => _IdeaPageState();
}

class _IdeaPageState extends State<IdeaPage> {
  String _selectedCategory = 'All';
  String _sortBy = 'Latest';

  final List<String> _categories = ['All', 'Content', 'Tech', 'Events', 'Design', 'Other'];
  final List<String> _sortOptions = ['Latest', 'Trending', 'Top Voted'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      body: Column(
        children: [
          _buildHeader(),
          _buildFilters(),
          Expanded(child: _buildIdeaList()),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showSubmitIdeaDialog(context),
        backgroundColor: const Color(0xFF800000),
        icon: const Icon(LucideIcons.plus, color: Colors.white),
        label: const Text('Submit Idea', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Idea Box',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            'Share your vision for the Maroon Squad',
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Category Filter
          ..._categories.map((cat) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(cat),
                  selected: _selectedCategory == cat,
                  onSelected: (selected) {
                    setState(() => _selectedCategory = cat);
                  },
                  selectedColor: const Color(0xFF800000).withValues(alpha: 0.1),
                  labelStyle: TextStyle(
                    color: _selectedCategory == cat ? const Color(0xFF800000) : Colors.black54,
                    fontWeight: _selectedCategory == cat ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              )),
          const VerticalDivider(),
          // Sort Dropdown
          DropdownButton<String>(
            value: _sortBy,
            underline: const SizedBox(),
            icon: const Icon(LucideIcons.chevronDown, size: 16),
            items: _sortOptions.map((opt) => DropdownMenuItem(value: opt, child: Text(opt))).toList(),
            onChanged: (val) {
              if (val != null) setState(() => _sortBy = val);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildIdeaList() {
    // Placeholder Data
    final ideas = [
      IdeaModel(
        title: 'Centralized Event Repository',
        description: 'A place to store all past event photos and documents for easy access by alumni and students.',
        category: 'Tech',
        votes: 42,
        commentCount: 12,
        status: 'Approved',
        isImplemented: false,
      ),
      IdeaModel(
        title: 'Weekly Maroon Podcast',
        description: 'Interviewing successful alumni to inspire current students.',
        category: 'Content',
        votes: 89,
        commentCount: 24,
        status: 'Implemented',
        isImplemented: true,
      ),
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: ideas.length,
      itemBuilder: (context, index) {
        final idea = ideas[index];
        return _buildIdeaCard(idea);
      },
    );
  }

  Widget _buildIdeaCard(IdeaModel idea) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _getCategoryColor(idea.category).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  idea.category,
                  style: TextStyle(color: _getCategoryColor(idea.category), fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
              _buildStatusBadge(idea),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            idea.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            idea.description,
            style: TextStyle(color: Colors.grey[600], fontSize: 14, height: 1.4),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildVoteControl(idea.votes),
              const SizedBox(width: 20),
              Icon(LucideIcons.messageCircle, size: 18, color: Colors.grey[400]),
              const SizedBox(width: 6),
              Text('${idea.commentCount}', style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.w500)),
              const Spacer(),
              const Icon(LucideIcons.moreVertical, size: 18, color: Colors.black26),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(IdeaModel idea) {
    Color color = Colors.orange;
    if (idea.isImplemented) {
      color = Colors.green;
    } else if (idea.status == 'Approved') {
      color = Colors.blue;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        border: Border.all(color: color.withValues(alpha: 0.5)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        idea.isImplemented ? 'Implemented' : idea.status,
        style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildVoteControl(int votes) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(LucideIcons.chevronUp, size: 18),
            onPressed: () {},
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          ),
          Text(
            '$votes',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          IconButton(
            icon: const Icon(LucideIcons.chevronDown, size: 18),
            onPressed: () {},
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Tech': return Colors.blue;
      case 'Content': return Colors.purple;
      case 'Events': return Colors.orange;
      case 'Design': return Colors.pink;
      default: return Colors.grey;
    }
  }

  void _showSubmitIdeaDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Submit New Idea', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            TextField(decoration: InputDecoration(labelText: 'Idea Title', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
            const SizedBox(height: 16),
            TextField(maxLines: 4, decoration: InputDecoration(labelText: 'Description', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
            const SizedBox(height: 16),
            // Category Dropdown Placeholder
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(12)),
              child: DropdownButtonHideUnderline(child: DropdownButton<String>(hint: const Text('Select Category'), isExpanded: true, items: const [], onChanged: null)),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF800000), padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                child: const Text('Post Idea', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IdeaModel {
  final String title;
  final String description;
  final String category;
  final int votes;
  final int commentCount;
  final String status;
  final bool isImplemented;

  IdeaModel({
    required this.title,
    required this.description,
    required this.category,
    required this.votes,
    required this.commentCount,
    required this.status,
    required this.isImplemented,
  });
}
