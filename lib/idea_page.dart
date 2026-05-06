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
  String _sortBy = 'Latest';
  late ScrollController _scrollController;
  bool _showBackToTop = false;

  final List<String> _categories = ['All', 'Content', 'Tech', 'Events', 'Design', 'Other'];
  final List<String> _sortOptions = ['Latest', 'Trending', 'Top Voted'];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.offset > 400 && !_showBackToTop) {
        setState(() => _showBackToTop = true);
      } else if (_scrollController.offset <= 400 && _showBackToTop) {
        setState(() => _showBackToTop = false);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB),
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              _buildSliverAppBar(),
              SliverPersistentHeader(
                pinned: true,
                delegate: _StickyFilterDelegate(
                  child: _buildFilters(),
                ),
              ),
              _buildSliverIdeaList(),
            ],
          ),
          if (_showBackToTop)
            Positioned(
              bottom: 100,
              right: 20,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: _showBackToTop ? 1.0 : 0.0,
                child: FloatingActionButton.small(
                  onPressed: _scrollToTop,
                  backgroundColor: AppTheme.maroon.withValues(alpha: 0.9),
                  child: const Icon(LucideIcons.chevronUp, color: Colors.white),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showSubmitIdeaDialog(context),
        backgroundColor: AppTheme.maroon,
        elevation: 4,
        highlightElevation: 8,
        icon: const Icon(LucideIcons.plus, color: Colors.white, size: 20),
        label: Text(
          'SUBMIT IDEA',
          style: GoogleFonts.outfit(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 180,
      floating: false,
      pinned: true,
      backgroundColor: AppTheme.maroon,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        centerTitle: false,
        title: Text(
          'Idea Box',
          style: GoogleFonts.outfit(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppTheme.darkMaroon, AppTheme.maroon],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            Opacity(
              opacity: 0.1,
              child: const Icon(LucideIcons.lightbulb, size: 200, color: Colors.white),
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: 60,
              child: Text(
                'Pitch your vision for\nthe Maroon Squad.',
                style: GoogleFonts.outfit(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontSize: 16,
                  height: 1.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Row(
              children: [
                ..._categories.map((cat) => Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedCategory = cat),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: _selectedCategory == cat ? AppTheme.maroon : Colors.grey[100],
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: _selectedCategory == cat
                                ? [BoxShadow(color: AppTheme.maroon.withValues(alpha: 0.3), blurRadius: 8, offset: const Offset(0, 4))]
                                : null,
                          ),
                          child: Text(
                            cat,
                            style: GoogleFonts.outfit(
                              color: _selectedCategory == cat ? Colors.white : Colors.grey[600],
                              fontWeight: _selectedCategory == cat ? FontWeight.bold : FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(LucideIcons.slidersHorizontal, size: 14, color: Colors.grey[400]),
                const SizedBox(width: 8),
                DropdownButton<String>(
                  value: _sortBy,
                  underline: const SizedBox(),
                  icon: Icon(LucideIcons.chevronDown, size: 14, color: Colors.grey[400]),
                  style: GoogleFonts.outfit(color: Colors.grey[600], fontSize: 13, fontWeight: FontWeight.w600),
                  items: _sortOptions.map((opt) => DropdownMenuItem(value: opt, child: Text(opt))).toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => _sortBy = val);
                  },
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF1F1F1)),
        ],
      ),
    );
  }

  Widget _buildSliverIdeaList() {
    final ideas = [
      IdeaModel(
        title: 'Centralized Event Repository',
        description: 'A place to store all past event photos and documents for easy access by alumni and students.',
        category: 'Tech',
        votes: 42,
        commentCount: 12,
        status: 'Approved',
        isImplemented: false,
        author: 'Sayan J.',
        time: '2 hours ago',
      ),
      IdeaModel(
        title: 'Weekly Maroon Podcast',
        description: 'Interviewing successful alumni to inspire current students and build a stronger network.',
        category: 'Content',
        votes: 89,
        commentCount: 24,
        status: 'Implemented',
        isImplemented: true,
        author: 'Rahul K.',
        time: 'Yesterday',
      ),
      IdeaModel(
        title: 'Squad Hackathon 2024',
        description: 'A 24-hour event to solve problems specific to the college campus using tech and design.',
        category: 'Events',
        votes: 156,
        commentCount: 45,
        status: 'Trending',
        isImplemented: false,
        author: 'Arpan M.',
        time: '3 days ago',
      ),
    ];

    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => _buildIdeaCard(ideas[index]),
          childCount: ideas.length,
        ),
      ),
    );
  }

  Widget _buildIdeaCard(IdeaModel idea) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(color: AppTheme.maroon.withValues(alpha: 0.1), shape: BoxShape.circle),
                              child: Text(
                                idea.author.substring(0, 1).toUpperCase(),
                                style: GoogleFonts.outfit(color: AppTheme.maroon, fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                idea.author,
                                style: GoogleFonts.outfit(color: Colors.grey[800], fontSize: 13, fontWeight: FontWeight.w600),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              ' • ${idea.time}',
                              style: GoogleFonts.outfit(color: Colors.grey[400], fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      _buildStatusBadge(idea),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    idea.title,
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    idea.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.outfit(
                      color: Colors.grey[600],
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      _buildVoteControl(idea.votes),
                      const SizedBox(width: 24),
                      Row(
                        children: [
                          Icon(LucideIcons.messageSquare, size: 18, color: Colors.grey[400]),
                          const SizedBox(width: 6),
                          Text(
                            '${idea.commentCount}',
                            style: GoogleFonts.outfit(color: Colors.grey[600], fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: _getCategoryColor(idea.category).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          idea.category.toUpperCase(),
                          style: GoogleFonts.outfit(
                            color: _getCategoryColor(idea.category),
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(IdeaModel idea) {
    Color color = Colors.orange;
    String label = idea.status;
    
    if (idea.isImplemented) {
      color = Colors.green;
      label = 'IMPLEMENTED';
    } else if (idea.status == 'Approved') {
      color = Colors.blue;
      label = 'APPROVED';
    } else if (idea.status == 'Trending') {
      color = AppTheme.maroon;
      label = 'TRENDING';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: GoogleFonts.outfit(color: color, fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 0.5),
      ),
    );
  }

  Widget _buildVoteControl(int votes) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(LucideIcons.arrowUp, size: 16),
            onPressed: () {},
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
            color: Colors.grey[600],
          ),
          Text(
            '$votes',
            style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black),
          ),
          IconButton(
            icon: const Icon(LucideIcons.arrowDown, size: 16),
            onPressed: () {},
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
            color: Colors.grey[400],
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
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Submit New Idea',
              style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 8),
            Text(
              'Detail your vision for the squad.',
              style: GoogleFonts.outfit(color: Colors.grey[500], fontSize: 14),
            ),
            const SizedBox(height: 32),
            _buildInputField('Idea Title', LucideIcons.heading),
            const SizedBox(height: 20),
            _buildInputField('Description', LucideIcons.alignLeft, maxLines: 5),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: Text('Select Category', style: GoogleFonts.outfit(color: Colors.grey[500])),
                  isExpanded: true,
                  icon: const Icon(LucideIcons.chevronDown, size: 18),
                  items: _categories.skip(1).map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                  onChanged: (v) {},
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.maroon,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  elevation: 0,
                ),
                child: Text(
                  'PUBLISH IDEA',
                  style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label, IconData icon, {int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.outfit(color: Colors.grey[500], fontSize: 14),
        prefixIcon: Icon(icon, size: 18, color: Colors.grey[400]),
        filled: true,
        fillColor: Colors.grey[50],
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide(color: Colors.grey[200]!)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: AppTheme.maroon)),
      ),
      style: GoogleFonts.outfit(fontSize: 15),
    );
  }
}

class _StickyFilterDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _StickyFilterDelegate({required this.child});

  @override
  double get minExtent => 125.0;
  @override
  double get maxExtent => 125.0;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: child,
      ),
    );
  }

  @override
  bool shouldRebuild(_StickyFilterDelegate oldDelegate) {
    return false;
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
  final String author;
  final String time;

  IdeaModel({
    required this.title,
    required this.description,
    required this.category,
    required this.votes,
    required this.commentCount,
    required this.status,
    required this.isImplemented,
    required this.author,
    required this.time,
  });
}
