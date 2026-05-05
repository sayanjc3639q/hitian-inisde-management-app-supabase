import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'theme.dart';

class IdeaPage extends StatefulWidget {
  const IdeaPage({super.key});

  @override
  State<IdeaPage> createState() => _IdeaPageState();
}

class _IdeaPageState extends State<IdeaPage> {
  String _selectedCategory = 'All';
  final List<String> _categories = ['All', 'Content', 'Tech', 'Events'];

  final List<IdeaModel> _ideas = [
    IdeaModel(
      title: 'Centralized Event Repository',
      description: 'A place to store all past event photos and documents for easy access by alumni and students.',
      category: 'TECH',
      votes: 42,
      commentCount: 12,
      status: 'APPROVED',
      isImplemented: false,
      statusType: 'success',
    ),
    IdeaModel(
      title: 'Weekly Maroon Podcast',
      description: 'Interviewing successful alumni to inspire current students and highlight our legacy.',
      category: 'CONTENT',
      votes: 89,
      commentCount: 24,
      status: 'IMPLEMENTED',
      isImplemented: true,
      statusType: 'danger',
    ),
    IdeaModel(
      title: 'Augmented Reality Heritage Tour',
      description: 'Using AR to show the history of campus buildings when students scan them with their phones.',
      category: 'EVENTS',
      votes: 154,
      commentCount: 48,
      status: 'TRENDING',
      isImplemented: false,
      statusType: 'warning',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          _buildFilters(),
          Expanded(child: _buildIdeaList()),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: FloatingActionButton.extended(
          onPressed: () => _showSubmitIdeaDialog(context),
          backgroundColor: AppTheme.maroon,
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          icon: const Icon(LucideIcons.plus, color: Colors.white, size: 24),
          label: Text(
            'Submit Idea',
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Idea Box',
            style: GoogleFonts.outfit(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1A1C1E),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Share your vision for the Maroon Squad',
            style: GoogleFonts.outfit(
              color: const Color(0xFF6C757D),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final cat = _categories[index];
          final isSelected = _selectedCategory == cat;
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: InkWell(
              onTap: () => setState(() => _selectedCategory = cat),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? AppTheme.maroon : const Color(0xFFF1F3F5),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: isSelected ? [
                    BoxShadow(
                      color: AppTheme.maroon.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    )
                  ] : null,
                ),
                child: Center(
                  child: Text(
                    cat,
                    style: GoogleFonts.outfit(
                      color: isSelected ? Colors.white : const Color(0xFF495057),
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildIdeaList() {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 80),
      itemCount: _ideas.length,
      itemBuilder: (context, index) {
        return _buildIdeaCard(_ideas[index]);
      },
    );
  }

  Widget _buildIdeaCard(IdeaModel idea) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF1F3F5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTag(idea.category, _getCategoryColor(idea.category)),
              _buildTag(idea.status, _getStatusColor(idea.statusType), isStatus: true),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            idea.title,
            style: GoogleFonts.outfit(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.maroon,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            idea.description,
            style: GoogleFonts.outfit(
              color: const Color(0xFF495057),
              fontSize: 15,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _buildVoteControl(idea.votes),
              const Spacer(),
              const Icon(LucideIcons.messageCircle, size: 20, color: Color(0xFFADB5BD)),
              const SizedBox(width: 6),
              Text(
                '${idea.commentCount}',
                style: GoogleFonts.outfit(
                  color: const Color(0xFF6C757D),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 16),
              const Icon(Icons.more_horiz, color: Color(0xFFADB5BD)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String label, Color color, {bool isStatus = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: GoogleFonts.outfit(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 11,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildVoteControl(int votes) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(LucideIcons.chevronUp, size: 20, color: Color(0xFFADB5BD)),
            onPressed: () {},
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          ),
          Text(
            '$votes',
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: const Color(0xFF343A40),
            ),
          ),
          IconButton(
            icon: const Icon(LucideIcons.chevronDown, size: 20, color: Color(0xFFADB5BD)),
            onPressed: () {},
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category.toUpperCase()) {
      case 'TECH': return const Color(0xFF0D6EFD);
      case 'CONTENT': return const Color(0xFF6F42C1);
      case 'EVENTS': return const Color(0xFFFD7E14);
      default: return Colors.grey;
    }
  }

  Color _getStatusColor(String type) {
    switch (type) {
      case 'success': return const Color(0xFF198754);
      case 'danger': return const Color(0xFFDC3545);
      case 'warning': return const Color(0xFFFFC107);
      default: return Colors.grey;
    }
  }

  void _showSubmitIdeaDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Submit New Idea',
                  style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 32),
            TextField(
              decoration: InputDecoration(
                labelText: 'Idea Title',
                hintText: 'e.g., Centralized Event Repository',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                filled: true,
                fillColor: const Color(0xFFF8F9FA),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Detailed Description',
                hintText: 'Describe how this helps the Maroon Squad...',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                filled: true,
                fillColor: const Color(0xFFF8F9FA),
              ),
            ),
            const SizedBox(height: 20),
            // Category Selector Placeholder
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                border: Border.all(color: const Color(0xFFDEE2E6)),
                borderRadius: BorderRadius.circular(16),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: const Text('Select Category'),
                  isExpanded: true,
                  items: _categories.where((c) => c != 'All').map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                  onChanged: (_) {},
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.maroon,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: Text(
                  'Post to Idea Box',
                  style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                ),
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
  final String statusType; // success, danger, warning, info

  IdeaModel({
    required this.title,
    required this.description,
    required this.category,
    required this.votes,
    required this.commentCount,
    required this.status,
    required this.isImplemented,
    required this.statusType,
  });
}

