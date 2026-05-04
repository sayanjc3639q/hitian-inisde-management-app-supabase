import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'home_page.dart';
import 'chats_page.dart';
import 'idea_page.dart';
import 'events_page.dart';
import 'profile_page.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const ChatsPage(),
    const IdeaPage(),
    const EventsPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: const HeaderBar(),
      body: _pages[_selectedIndex],
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HeaderBar extends StatelessWidget implements PreferredSizeWidget {
  const HeaderBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(LucideIcons.menu, color: Colors.black54),
        onPressed: () {},
      ),
      title: const Text(
        'HITian Inside',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Color(0xFF800000),
          fontSize: 20,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(LucideIcons.bell, color: Colors.black54),
          onPressed: () {},
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: CircleAvatar(
            radius: 18,
            backgroundColor: Colors.grey[200],
            child: const Icon(LucideIcons.user, size: 20, color: Colors.black54),
          ),
        ),
      ],
      centerTitle: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF800000),
        unselectedItemColor: Colors.black38,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        items: const [
          BottomNavigationBarItem(icon: Icon(LucideIcons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(LucideIcons.messageSquare), label: 'Chats'),
          BottomNavigationBarItem(icon: Icon(LucideIcons.compass), label: 'Idea'),
          BottomNavigationBarItem(icon: Icon(LucideIcons.calendar), label: 'Event'),
          BottomNavigationBarItem(icon: Icon(LucideIcons.user), label: 'Profile'),
        ],
      ),
    );
  }
}
