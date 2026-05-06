import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'theme.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Upcoming', 'Ongoing', 'Completed'];
  
  // Mock Admin Access - Logic will be linked to Supabase Auth roles later
  bool _isAdmin = true; 


  final List<EventModel> _events = [
    EventModel(
      title: 'Annual Sports Meet 2024',
      date: 'Dec 15, 2024',
      time: '08:00 AM',
      location: 'HIT Grounds',
      organizer: 'Sports Committee',
      assignedTeam: ['Sayan J.', 'Ankan D.', 'Rohit S.'],
      shift: 'Morning',
      status: 'Upcoming',
      image: 'https://images.unsplash.com/photo-1502945015378-0e284ca1c5be',
    ),
    EventModel(
      title: 'Maroon Hackathon',
      date: 'Nov 20, 2024',
      time: '10:00 AM',
      location: 'Seminar Hall',
      organizer: 'Tech Club',
      assignedTeam: ['Sayan J.', 'Priya M.'],
      shift: 'Full Day',
      status: 'Ongoing',
      image: 'https://images.unsplash.com/photo-1504384308090-c894fdcc538d',
    ),
    EventModel(
      title: 'Cultural Night',
      date: 'Oct 25, 2024',
      time: '06:00 PM',
      location: 'Open Theatre',
      organizer: 'Cultural Wing',
      assignedTeam: ['Rahul K.', 'Sayan J.', 'Sneha P.', 'Arjun T.'],
      shift: 'Evening',
      status: 'Completed',
      image: 'https://images.unsplash.com/photo-1475721027785-f74eccf877e2',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightCream,
      body: Column(
        children: [
          _buildHeader(),
          _buildFilterBar(),
          Expanded(child: _buildEventList()),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 60, left: 24, right: 24, bottom: 20),
      decoration: const BoxDecoration(
        color: AppTheme.maroon,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(32), bottomRight: Radius.circular(32)),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Media Coverage',
                    style: GoogleFonts.outfit(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Tracking assignments & events',
                    style: GoogleFonts.outfit(color: Colors.white.withValues(alpha: 0.8), fontSize: 14),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  if (_isAdmin) {
                    _showAddEventDialog();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Admin access required to add events")),
                    );
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(_isAdmin ? LucideIcons.calendarPlus : LucideIcons.camera, color: Colors.white, size: 24),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Row(
        children: _filters.map((filter) => Padding(
          padding: const EdgeInsets.only(right: 12),
          child: GestureDetector(
            onTap: () => setState(() => _selectedFilter = filter),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: _selectedFilter == filter ? AppTheme.maroon : Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: _selectedFilter == filter
                    ? [BoxShadow(color: AppTheme.maroon.withValues(alpha: 0.3), blurRadius: 8, offset: const Offset(0, 4))]
                    : [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 4, offset: const Offset(0, 2))],
              ),
              child: Text(
                filter,
                style: GoogleFonts.outfit(
                  color: _selectedFilter == filter ? Colors.white : Colors.black54,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildEventList() {
    final filteredEvents = _selectedFilter == 'All'
        ? _events
        : _events.where((e) => e.status == _selectedFilter).toList();

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: filteredEvents.length,
      itemBuilder: (context, index) {
        return _buildEventCard(filteredEvents[index]);
      },
    );
  }

  Widget _buildEventCard(EventModel event) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 15, offset: const Offset(0, 8)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getStatusColor(event.status).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        event.status,
                        style: GoogleFonts.outfit(color: _getStatusColor(event.status), fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(LucideIcons.sun, color: Colors.amber, size: 12),
                          const SizedBox(width: 4),
                          Text(
                            event.shift,
                            style: GoogleFonts.outfit(color: Colors.black87, fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        event.title,
                        style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.darkMaroon),
                      ),
                    ),
                    const Icon(LucideIcons.moreVertical, size: 20, color: Colors.grey),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Organized by: ${event.organizer}',
                  style: GoogleFonts.outfit(color: Colors.grey[600], fontSize: 13),
                ),
                const SizedBox(height: 16),
                // Details Row
                Row(
                  children: [
                    _buildIconInfo(LucideIcons.calendar, event.date),
                    const SizedBox(width: 20),
                    _buildIconInfo(LucideIcons.clock, event.time),
                  ],
                ),
                const SizedBox(height: 12),
                _buildIconInfo(LucideIcons.mapPin, event.location),
                const SizedBox(height: 20),
                const Divider(height: 1),
                const SizedBox(height: 20),
                // Coverage Team Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Coverage Team',
                          style: GoogleFonts.outfit(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey[800]),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            ...event.assignedTeam.take(3).map((name) => Padding(
                                  padding: const EdgeInsets.only(right: 4),
                                  child: CircleAvatar(
                                    radius: 14,
                                    backgroundColor: AppTheme.maroon.withValues(alpha: 0.1),
                                    child: Text(
                                      name.substring(0, 1),
                                      style: GoogleFonts.outfit(fontSize: 10, color: AppTheme.maroon, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )),
                            if (event.assignedTeam.length > 3)
                              CircleAvatar(
                                radius: 14,
                                backgroundColor: Colors.grey[200],
                                child: Text(
                                  '+${event.assignedTeam.length - 3}',
                                  style: GoogleFonts.outfit(fontSize: 10, color: Colors.grey[600]),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.maroon,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 0,
                      ),
                      child: Text(
                        event.status == 'Completed' ? 'View Logs' : 'View Duty',
                        style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showAddEventDialog() {
    String? selectedShift = "Morning";
    DateTime selectedDate = DateTime.now();

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            title: Row(
              children: [
                const Icon(LucideIcons.plusCircle, color: AppTheme.maroon),
                const SizedBox(width: 12),
                Text("Create New Event", style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
              ],
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Event Title",
                      hintText: "Enter event name",
                      labelStyle: GoogleFonts.outfit(color: AppTheme.maroon),
                      focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppTheme.maroon)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Organizing Body",
                      hintText: "e.g., Tech Club",
                      labelStyle: GoogleFonts.outfit(color: AppTheme.maroon),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Shift Selection
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text("Shift:", style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
                      ...["Morning", "Evening", "Full Day"].map((s) => ChoiceChip(
                        label: Text(s, style: GoogleFonts.outfit(fontSize: 10, color: selectedShift == s ? Colors.white : Colors.black)),
                        selected: selectedShift == s,
                        selectedColor: AppTheme.maroon,
                        onSelected: (selected) => setDialogState(() => selectedShift = s),
                      )).toList(),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Date Picker
                  InkWell(
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (date != null) setDialogState(() => selectedDate = date);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(LucideIcons.calendar, size: 18, color: AppTheme.maroon),
                          const SizedBox(width: 12),
                          Text(
                            "Date: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                            style: GoogleFonts.outfit(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Note: Data will persist via Supabase in production.",
                    style: TextStyle(fontSize: 10, color: Colors.grey, fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Event logically added (Mock - Waiting for Supabase integration)")),
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: AppTheme.maroon, foregroundColor: Colors.white),
                child: const Text("Create"),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildIconInfo(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: AppTheme.maroon.withValues(alpha: 0.5)),
        const SizedBox(width: 8),
        Text(
          text,
          style: GoogleFonts.outfit(color: Colors.grey[700], fontSize: 13, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Upcoming': return Colors.blue;
      case 'Ongoing': return Colors.orange;
      case 'Completed': return Colors.green;
      default: return Colors.grey;
    }
  }
}

class EventModel {
  final String title;
  final String date;
  final String time;
  final String location;
  final String organizer;
  final List<String> assignedTeam;
  final String shift;
  final String status;
  final String image;

  EventModel({
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.organizer,
    required this.assignedTeam,
    required this.shift,
    required this.status,
    required this.image,
  });
}
