import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'theme.dart';

class ChatDetailPage extends StatefulWidget {
  final String groupName;
  final String groupType;
  final IconData icon;

  const ChatDetailPage({
    super.key,
    required this.groupName,
    required this.groupType,
    required this.icon,
  });

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final TextEditingController _messageController = TextEditingController();
  final List<Message> _messages = [
    Message(text: "Hello team! Welcome to the squad.", isMe: false, time: "9:00 AM", sender: "Admin"),
    Message(text: "Excited to be here!", isMe: true, time: "9:05 AM"),
    Message(text: "When is the next meeting?", isMe: false, time: "9:10 AM", sender: "John Doe"),
    Message(text: "It is scheduled for this Friday at 5 PM.", isMe: true, time: "9:12 AM"),
    Message(text: "Great, thanks for the update.", isMe: false, time: "9:15 AM", sender: "Sarah Smith"),
  ];

  final List<String> _groupMembers = ["Sayan J.", "John Doe", "Sarah Smith", "Admin"];

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        _messages.add(Message(
          text: _messageController.text.trim(),
          isMe: true,
          time: TimeOfDay.now().format(context),
        ));
        _messageController.clear();
      });
    }
  }

  void _showAttachmentMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 3,
          mainAxisSpacing: 20,
          crossAxisSpacing: 10,
          children: [
            _buildAttachmentItem(LucideIcons.video, "Meeting", Colors.purple, () {
              Navigator.pop(context);
              _showCreateMeetingDialog();
            }),
            _buildAttachmentItem(LucideIcons.barChart2, "Poll", Colors.orange, () {
              Navigator.pop(context);
              _showCreatePollDialog();
            }),
            _buildAttachmentItem(LucideIcons.checkSquare, "Task", Colors.blue, () {
              Navigator.pop(context);
              _showAssignTaskDialog();
            }),
            _buildAttachmentItem(LucideIcons.fileText, "Document", Colors.indigo, () => Navigator.pop(context)),
            _buildAttachmentItem(LucideIcons.image, "Gallery", Colors.pink, () => Navigator.pop(context)),
            _buildAttachmentItem(LucideIcons.mapPin, "Location", Colors.green, () => Navigator.pop(context)),
          ],
        ),
      ),
    );
  }

  void _showCreateMeetingDialog() {
    bool isOnline = true;
    DateTime selectedDate = DateTime.now();
    TimeOfDay selectedTime = TimeOfDay.now();

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.purple.withValues(alpha: 0.1), shape: BoxShape.circle),
                  child: const Icon(LucideIcons.video, color: Colors.purple, size: 20),
                ),
                const SizedBox(width: 12),
                Text("Schedule Meeting", style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
              ],
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: "Meeting Title",
                        hintText: "e.g., Weekly Sync-up",
                        labelStyle: GoogleFonts.outfit(color: AppTheme.maroon),
                        focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppTheme.maroon)),
                      ),
                      style: GoogleFonts.outfit(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 24),
                    // Online/Offline Toggle
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setDialogState(() => isOnline = true),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: isOnline ? AppTheme.maroon : Colors.transparent,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: isOnline ? [BoxShadow(color: AppTheme.maroon.withValues(alpha: 0.2), blurRadius: 8, offset: const Offset(0, 4))] : [],
                                ),
                                child: Center(
                                  child: Text(
                                    "Online",
                                    style: GoogleFonts.outfit(
                                      color: isOnline ? Colors.white : Colors.grey[600],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setDialogState(() => isOnline = false),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: !isOnline ? AppTheme.maroon : Colors.transparent,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: !isOnline ? [BoxShadow(color: AppTheme.maroon.withValues(alpha: 0.2), blurRadius: 8, offset: const Offset(0, 4))] : [],
                                ),
                                child: Center(
                                  child: Text(
                                    "Offline",
                                    style: GoogleFonts.outfit(
                                      color: !isOnline ? Colors.white : Colors.grey[600],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Conditional Field
                    TextField(
                      decoration: InputDecoration(
                        labelText: isOnline ? "Meeting Link" : "Location",
                        hintText: isOnline ? "https://meet.google.com/..." : "e.g., Seminar Hall 1",
                        prefixIcon: Icon(isOnline ? LucideIcons.link : LucideIcons.mapPin, size: 18, color: AppTheme.maroon),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey[300]!)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppTheme.maroon)),
                      ),
                      style: GoogleFonts.outfit(fontSize: 14),
                    ),
                    const SizedBox(height: 16),
                    // Date and Time Row
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
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
                                  const Icon(LucideIcons.calendar, size: 16, color: AppTheme.maroon),
                                  const SizedBox(width: 8),
                                  Text(
                                    "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                                    style: GoogleFonts.outfit(fontSize: 12, fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              final time = await showTimePicker(
                                context: context,
                                initialTime: selectedTime,
                              );
                              if (time != null) setDialogState(() => selectedTime = time);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]!),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  const Icon(LucideIcons.clock, size: 16, color: AppTheme.maroon),
                                  const SizedBox(width: 8),
                                  Text(
                                    selectedTime.format(context),
                                    style: GoogleFonts.outfit(fontSize: 12, fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancel", style: GoogleFonts.outfit(color: Colors.grey)),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Meeting scheduled successfully!", style: GoogleFonts.outfit()),
                      backgroundColor: Colors.purple,
                      behavior: SnackBarBehavior.floating,
                      margin: const EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.maroon,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                child: Text("Schedule", style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showCreatePollDialog() {
    List<String> options = ["", ""];
    bool allowMultipleAnswers = false;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.orange.withValues(alpha: 0.1), shape: BoxShape.circle),
                  child: const Icon(LucideIcons.barChart2, color: Colors.orange, size: 20),
                ),
                const SizedBox(width: 12),
                Text("Create Poll", style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
              ],
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: "Question",
                        hintText: "What would you like to ask?",
                        labelStyle: GoogleFonts.outfit(color: AppTheme.maroon),
                        focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppTheme.maroon)),
                      ),
                      style: GoogleFonts.outfit(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 24),
                    ...List.generate(options.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Option ${index + 1}",
                                  prefixIcon: const Icon(LucideIcons.circle, size: 12, color: Colors.grey),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey[300]!)),
                                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppTheme.maroon)),
                                ),
                                style: GoogleFonts.outfit(fontSize: 14),
                                onChanged: (val) => options[index] = val,
                              ),
                            ),
                            if (options.length > 2)
                              IconButton(
                                icon: const Icon(LucideIcons.trash2, color: Colors.red, size: 18),
                                onPressed: () => setDialogState(() => options.removeAt(index)),
                              ),
                          ],
                        ),
                      );
                    }),
                    if (options.length < 10)
                      TextButton.icon(
                        onPressed: () => setDialogState(() => options.add("")),
                        icon: const Icon(LucideIcons.plus, size: 18),
                        label: Text("Add Option", style: GoogleFonts.outfit(fontWeight: FontWeight.w600)),
                        style: TextButton.styleFrom(foregroundColor: AppTheme.maroon),
                      ),
                    const Divider(height: 32),
                    SwitchListTile(
                      title: Text("Allow multiple answers", style: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.w500)),
                      subtitle: Text("Users can select more than one option", style: GoogleFonts.outfit(fontSize: 11, color: Colors.grey)),
                      value: allowMultipleAnswers,
                      activeTrackColor: AppTheme.maroon.withValues(alpha: 0.5),
                      activeThumbColor: AppTheme.maroon,
                      onChanged: (val) => setDialogState(() => allowMultipleAnswers = val),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancel", style: GoogleFonts.outfit(color: Colors.grey)),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Poll created successfully!", style: GoogleFonts.outfit()),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                      margin: const EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.maroon,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                child: Text("Post Poll", style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showAssignTaskDialog() {
    String? selectedMember;
    String priority = "Medium";
    DateTime selectedDate = DateTime.now();

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.blue.withValues(alpha: 0.1), shape: BoxShape.circle),
                  child: const Icon(LucideIcons.checkSquare, color: Colors.blue, size: 20),
                ),
                const SizedBox(width: 12),
                Text("Assign Task", style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
              ],
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: "Task Title",
                        hintText: "What needs to be done?",
                        labelStyle: GoogleFonts.outfit(color: AppTheme.maroon),
                        focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppTheme.maroon)),
                      ),
                      style: GoogleFonts.outfit(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 24),
                    // Member Dropdown
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: "Assign To",
                        prefixIcon: const Icon(LucideIcons.user, size: 18, color: AppTheme.maroon),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey[300]!)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppTheme.maroon)),
                      ),
                      initialValue: selectedMember,
                      hint: Text(_groupMembers.isEmpty ? "no member" : "Select member", style: GoogleFonts.outfit(fontSize: 14)),
                      icon: const Icon(LucideIcons.chevronDown, size: 18),
                      items: _groupMembers.map((member) {
                        return DropdownMenuItem(
                          value: member,
                          child: Text(member, style: GoogleFonts.outfit(fontSize: 14)),
                        );
                      }).toList(),
                      onChanged: _groupMembers.isEmpty ? null : (val) => setDialogState(() => selectedMember = val),
                    ),
                    const SizedBox(height: 24),
                    // Priority Selector
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Priority", style: GoogleFonts.outfit(fontSize: 12, color: AppTheme.maroon, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: ["Low", "Medium", "High"].map((p) {
                            final isSelected = priority == p;
                            Color pColor = Colors.green;
                            if (p == "High") pColor = Colors.red;
                            if (p == "Medium") pColor = Colors.orange;

                            return Expanded(
                              child: GestureDetector(
                                onTap: () => setDialogState(() => priority = p),
                                child: Container(
                                  margin: EdgeInsets.only(right: p == "High" ? 0 : 8),
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                    color: isSelected ? pColor : Colors.grey[100],
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: isSelected ? pColor : Colors.grey[300]!),
                                  ),
                                  child: Center(
                                    child: Text(
                                      p,
                                      style: GoogleFonts.outfit(
                                        color: isSelected ? Colors.white : Colors.grey[600],
                                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Due Date
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
                              "Due Date: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                              style: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel", style: GoogleFonts.outfit(color: Colors.grey))),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Task assigned successfully!", style: GoogleFonts.outfit()),
                      backgroundColor: Colors.blue,
                      behavior: SnackBarBehavior.floating,
                      margin: const EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.maroon,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                child: Text("Assign Task", style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAttachmentItem(IconData icon, String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
              border: Border.all(color: color.withValues(alpha: 0.2)),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.outfit(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }

  void _showMessageActions(Message message) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2))),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: ["❤️", "😂", "😮", "😢", "🙏", "🔥"].map((emoji) {
                  return GestureDetector(
                    onTap: () {
                      setState(() => message.reactions.add(emoji));
                      Navigator.pop(context);
                    },
                    child: Text(emoji, style: const TextStyle(fontSize: 24)),
                  );
                }).toList(),
              ),
            ),
            const Divider(height: 32),
            _buildActionItem(LucideIcons.reply, "Reply", () => Navigator.pop(context)),
            _buildActionItem(LucideIcons.copy, "Copy", () => Navigator.pop(context)),
            if (message.isMe) _buildActionItem(LucideIcons.edit3, "Edit", () => Navigator.pop(context)),
            _buildActionItem(LucideIcons.trash2, "Delete", () {
              setState(() => _messages.remove(message));
              Navigator.pop(context);
            }, isDestructive: true),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildActionItem(IconData icon, String label, VoidCallback onTap, {bool isDestructive = false}) {
    return ListTile(
      leading: Icon(icon, color: isDestructive ? Colors.red : Colors.grey[700], size: 20),
      title: Text(
        label,
        style: GoogleFonts.outfit(
          color: isDestructive ? Colors.red : Colors.grey[800],
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }

  void _showComingSoon() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Feature coming soon!", style: GoogleFonts.outfit()),
        backgroundColor: AppTheme.maroon,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB),
      appBar: AppBar(
        titleSpacing: 0,
        leadingWidth: 70,
        leading: Row(
          children: [
            const SizedBox(width: 4),
            InkWell(
              onTap: () => Navigator.pop(context),
              borderRadius: BorderRadius.circular(20),
              child: Row(
                children: [
                  const Icon(Icons.arrow_back, size: 24),
                  const SizedBox(width: 2),
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.white24,
                    child: Icon(widget.icon, color: Colors.white, size: 18),
                  ),
                ],
              ),
            ),
          ],
        ),
        title: InkWell(
          onTap: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.groupName,
                style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                widget.groupType,
                style: GoogleFonts.outfit(fontSize: 12, color: Colors.white70),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(icon: const Icon(LucideIcons.video), onPressed: _showComingSoon),
          IconButton(icon: const Icon(LucideIcons.phone), onPressed: _showComingSoon),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages.reversed.toList()[index];
                return GestureDetector(
                  onLongPress: () => _showMessageActions(message),
                  child: _buildMessageBubble(message),
                );
              },
            ),
          ),
          _buildInputBar(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Message message) {
    return Align(
      alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        child: Column(
          crossAxisAlignment: message.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: message.isMe ? AppTheme.maroon : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: message.isMe ? const Radius.circular(16) : Radius.zero,
                  bottomRight: message.isMe ? Radius.zero : const Radius.circular(16),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!message.isMe && message.sender != null)
                    Text(
                      message.sender!,
                      style: GoogleFonts.outfit(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.maroon),
                    ),
                  Text(
                    message.text,
                    style: GoogleFonts.outfit(fontSize: 15, color: message.isMe ? Colors.white : Colors.black87),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (message.isEdited)
                        Text(
                          "edited • ",
                          style: GoogleFonts.outfit(fontSize: 9, color: message.isMe ? Colors.white60 : Colors.black38),
                        ),
                      Text(
                        message.time,
                        style: GoogleFonts.outfit(fontSize: 10, color: message.isMe ? Colors.white70 : Colors.black45),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (message.reactions.isNotEmpty)
              Transform.translate(
                offset: const Offset(0, -10),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
                  ),
                  child: Text(message.reactions.join(" "), style: const TextStyle(fontSize: 12)),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 24),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, -4))],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.emoji_emotions_outlined, color: Colors.grey),
                    onPressed: () {},
                  ),
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: "Type a message",
                        hintStyle: GoogleFonts.outfit(color: Colors.grey[500]),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.attach_file, color: Colors.grey),
                    onPressed: _showAttachmentMenu,
                  ),
                  IconButton(
                    icon: const Icon(Icons.camera_alt, color: Colors.grey),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: _sendMessage,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(color: AppTheme.maroon, shape: BoxShape.circle),
              child: const Icon(LucideIcons.send, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  String text;
  final bool isMe;
  final String time;
  final String? sender;
  bool isEdited;
  List<String> reactions;

  Message({
    required this.text,
    required this.isMe,
    required this.time,
    this.sender,
    this.isEdited = false,
    List<String>? reactions,
  }) : reactions = reactions ?? [];
}
