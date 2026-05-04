import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Upcoming', 'Registered', 'Past'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
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
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Events',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                'Discover what\'s happening next',
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF800000).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(LucideIcons.calendarPlus, color: Color(0xFF800000), size: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: _filters.map((filter) => Padding(
          padding: const EdgeInsets.only(right: 8),
          child: ChoiceChip(
            label: Text(filter),
            selected: _selectedFilter == filter,
            onSelected: (selected) {
              setState(() => _selectedFilter = filter);
            },
            selectedColor: const Color(0xFF800000).withValues(alpha: 0.1),
            labelStyle: TextStyle(
              color: _selectedFilter == filter ? const Color(0xFF800000) : Colors.black54,
              fontWeight: _selectedFilter == filter ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildEventList() {
    final events = [
      EventModel(
        title: 'Maroon Hackathon 2024',
        date: 'Oct 25, 2024',
        time: '10:00 AM',
        location: 'Main Auditorium',
        type: 'Competition',
        image: 'https://images.unsplash.com/photo-1504384308090-c894fdcc538d',
        status: 'Upcoming',
        credits: 10,
      ),
      EventModel(
        title: 'Alumni Tech Talk',
        date: 'Oct 28, 2024',
        time: '2:00 PM',
        location: 'Seminar Hall 1',
        type: 'Workshop',
        image: 'https://images.unsplash.com/photo-1475721027785-f74eccf877e2',
        status: 'Registered',
        credits: 5,
      ),
      EventModel(
        title: 'Graphic Design Workshop',
        date: 'Oct 15, 2024',
        time: '11:00 AM',
        location: 'Design Lab',
        type: 'Workshop',
        image: 'https://images.unsplash.com/photo-1558655146-d09347e92766',
        status: 'Past',
        credits: 5,
      ),
    ];

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: events.length,
      itemBuilder: (context, index) {
        return _buildEventCard(events[index]);
      },
    );
  }

  Widget _buildEventCard(EventModel event) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Event Image / Placeholder
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Container(
              height: 140,
              width: double.infinity,
              color: const Color(0xFF800000).withValues(alpha: 0.05),
              child: Center(
                child: Icon(LucideIcons.image, size: 40, color: const Color(0xFF800000).withValues(alpha: 0.2)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getTypeColor(event.type).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        event.type,
                        style: TextStyle(color: _getTypeColor(event.type), fontWeight: FontWeight.bold, fontSize: 10),
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(LucideIcons.star, size: 14, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text('${event.credits} Credits', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  event.title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(LucideIcons.calendar, size: 14, color: Colors.grey[400]),
                    const SizedBox(width: 6),
                    Text(event.date, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                    const SizedBox(width: 16),
                    Icon(LucideIcons.clock, size: 14, color: Colors.grey[400]),
                    const SizedBox(width: 6),
                    Text(event.time, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(LucideIcons.mapPin, size: 14, color: Colors.grey[400]),
                    const SizedBox(width: 6),
                    Text(event.location, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: event.status == 'Past' ? Colors.grey[200] : const Color(0xFF800000),
                      foregroundColor: event.status == 'Past' ? Colors.black38 : Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 0,
                    ),
                    child: Text(
                      event.status == 'Registered' ? 'View Details' : (event.status == 'Past' ? 'Event Ended' : 'Register Now'),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'Competition': return Colors.red;
      case 'Workshop': return Colors.blue;
      case 'Seminar': return Colors.green;
      default: return Colors.orange;
    }
  }
}

class EventModel {
  final String title;
  final String date;
  final String time;
  final String location;
  final String type;
  final String image;
  final String status;
  final int credits;

  EventModel({
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.type,
    required this.image,
    required this.status,
    required this.credits,
  });
}
