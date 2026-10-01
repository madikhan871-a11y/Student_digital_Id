import 'package:flutter/material.dart';

void main() {
  runApp(const CampusIdApp());
}

class CampusIdApp extends StatelessWidget {
  const CampusIdApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Campus ID',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF5F7FC),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4F46E5),
        ),
      ),
      home: const DashboardScreen(),
    );
  }
}

// ============================================================
// STUDENT DATA
// ============================================================

const String studentName = 'Madiha Naz';
const String rollNumber = 'FA24_BSE_121(B)';
const String department = 'Software Engineering';
const String semester = '5th Semester';

final List<Course> courses = [
  Course(
    name: 'Operating Systems',
    code: 'CSC323',
    creditHours: '3 Credit Hours',
    instructor: 'Course Instructor',
    schedule: 'Monday & Wednesday • 10:00 AM',
    room: 'Lab / Room 204',
    icon: Icons.computer_rounded,
  ),
  Course(
    name: 'Web Technologies',
    code: 'CSC305',
    creditHours: '3 Credit Hours',
    instructor: 'Course Instructor',
    schedule: 'Tuesday & Thursday • 09:00 AM',
    room: 'Room 301',
    icon: Icons.language_rounded,
  ),
  Course(
    name: 'Mobile Application Development',
    code: 'CSC303',
    creditHours: '3 Credit Hours',
    instructor: 'Course Instructor',
    schedule: 'Monday & Wednesday • 12:00 PM',
    room: 'Mobile Lab',
    icon: Icons.phone_android_rounded,
  ),
  Course(
    name: 'Software Design & Architecture',
    code: 'CSC307',
    creditHours: '3 Credit Hours',
    instructor: 'Course Instructor',
    schedule: 'Tuesday & Thursday • 11:00 AM',
    room: 'Room 205',
    icon: Icons.architecture_rounded,
  ),
  Course(
    name: 'Assembly Language',
    code: 'CSC309',
    creditHours: '3 Credit Hours',
    instructor: 'Course Instructor',
    schedule: 'Friday • 10:00 AM',
    room: 'Computer Lab',
    icon: Icons.memory_rounded,
  ),
];

class Course {
  final String name;
  final String code;
  final String creditHours;
  final String instructor;
  final String schedule;
  final String room;
  final IconData icon;

  Course({
    required this.name,
    required this.code,
    required this.creditHours,
    required this.instructor,
    required this.schedule,
    required this.room,
    required this.icon,
  });
}

// ============================================================
// MAIN DASHBOARD
// ============================================================

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final TextEditingController noteController = TextEditingController();

  final List<String> notes = [];

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

  // ----------------------------------------------------------
  // ADD NOTE
  // ----------------------------------------------------------

  void addNote() {
    final note = noteController.text.trim();

    if (note.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please write a note first.'),
        ),
      );
      return;
    }

    setState(() {
      notes.insert(0, note);
      noteController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Note saved successfully!'),
      ),
    );
  }

  // ----------------------------------------------------------
  // DELETE NOTE
  // ----------------------------------------------------------

  void deleteNote(int index) {
    setState(() {
      notes.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Note deleted.'),
      ),
    );
  }

  // ----------------------------------------------------------
  // OPEN COURSE
  // ----------------------------------------------------------

  void openCourse(Course course) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return CourseDetailsSheet(course: course);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),

      drawer: buildDrawer(),

      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(
            const Duration(milliseconds: 600),
          );

          setState(() {});
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          padding: const EdgeInsets.fromLTRB(
            18,
            10,
            18,
            30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ==================================================
              // WELCOME
              // ==================================================

              Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome back,',
                          style: TextStyle(
                            color: Color(0xFF8A91A3),
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          'Madiha 👋',
                          style: TextStyle(
                            color: Color(0xFF171B2E),
                            fontSize: 27,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFECFDF3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.circle,
                          size: 8,
                          color: Color(0xFF22C55E),
                        ),
                        SizedBox(width: 6),
                        Text(
                          'Online',
                          style: TextStyle(
                            color: Color(0xFF15803D),
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 22),

              // ==================================================
              // DIGITAL ID CARD
              // ==================================================

              buildIdCard(),

              const SizedBox(height: 18),

              // ==================================================
              // QUICK STATS
              // ==================================================

              Row(
                children: [
                  Expanded(
                    child: statCard(
                      Icons.menu_book_rounded,
                      '05',
                      'Courses',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: statCard(
                      Icons.calendar_month_rounded,
                      '05',
                      'Semester',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: statCard(
                      Icons.verified_rounded,
                      'Active',
                      'Student',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // ==================================================
              // CAMPUS OVERVIEW
              // ==================================================

              sectionTitle(
                'Campus Overview',
                'Useful information',
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: overviewCard(
                      Icons.schedule_rounded,
                      'Today',
                      '5 Classes',
                      const Color(0xFFEEF2FF),
                      const Color(0xFF4F46E5),
                    ),
                  ),
                  const SizedBox(width: 11),
                  Expanded(
                    child: overviewCard(
                      Icons.location_on_rounded,
                      'Campus',
                      'Open',
                      const Color(0xFFECFDF3),
                      const Color(0xFF16A34A),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // ==================================================
              // COURSES
              // ==================================================

              sectionTitle(
                'Current Courses',
                'Tap a course for details',
              ),

              const SizedBox(height: 12),

              SizedBox(
                height: 315,

                // REQUIRED: ListView.builder
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: courses.length,
                  itemBuilder: (context, index) {
                    final course = courses[index];

                    return GestureDetector(
                      onTap: () => openCourse(course),
                      child: Container(
                        margin: const EdgeInsets.only(
                          bottom: 10,
                        ),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.circular(17),
                          boxShadow: [
                            BoxShadow(
                              color:
                              Colors.black.withOpacity(0.035),
                              blurRadius: 12,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [

                            // Course icon
                            Container(
                              height: 46,
                              width: 46,
                              decoration: BoxDecoration(
                                color: const Color(0xFFEEF2FF),
                                borderRadius:
                                BorderRadius.circular(13),
                              ),
                              child: Icon(
                                course.icon,
                                color:
                                const Color(0xFF4F46E5),
                                size: 23,
                              ),
                            ),

                            const SizedBox(width: 12),

                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    course.name,
                                    maxLines: 1,
                                    overflow:
                                    TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color:
                                      Color(0xFF252A3D),
                                      fontSize: 13,
                                      fontWeight:
                                      FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    '${course.code}  •  ${course.creditHours}',
                                    style: const TextStyle(
                                      color:
                                      Color(0xFF9CA3AF),
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              height: 32,
                              width: 32,
                              decoration: BoxDecoration(
                                color:
                                const Color(0xFFF5F7FF),
                                borderRadius:
                                BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 13,
                                color: Color(0xFF6366F1),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              // ==================================================
              // QUICK NOTES
              // ==================================================

              sectionTitle(
                'Quick Notes',
                'Keep important reminders',
              ),

              const SizedBox(height: 12),

              Container(
                padding: const EdgeInsets.all(17),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(21),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 18,
                      offset: const Offset(0, 7),
                    ),
                  ],
                ),
                child: Column(
                  children: [

                    // REQUIRED: TextField
                    TextField(
                      controller: noteController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText:
                        'Write a reminder or quick note...',
                        hintStyle: const TextStyle(
                          color: Color(0xFFB2B7C3),
                          fontSize: 12,
                        ),
                        filled: true,
                        fillColor:
                        const Color(0xFFF8F9FD),
                        contentPadding:
                        const EdgeInsets.all(14),
                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Color(0xFF6366F1),
                            width: 1.2,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // REQUIRED: ElevatedButton
                    SizedBox(
                      width: double.infinity,
                      height: 46,
                      child: ElevatedButton(
                        onPressed: addNote,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                          const Color(0xFF4F46E5),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(14),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_rounded,
                              size: 19,
                            ),
                            SizedBox(width: 7),
                            Text(
                              'Save Note',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ==================================================
              // SAVED NOTES
              // ==================================================

              if (notes.isNotEmpty) ...[
                const SizedBox(height: 18),

                sectionTitle(
                  'Saved Notes',
                  '${notes.length} note${notes.length == 1 ? '' : 's'}',
                ),

                const SizedBox(height: 10),

                ...notes.asMap().entries.map(
                      (entry) {
                    final index = entry.key;
                    final note = entry.value;

                    return Container(
                      margin:
                      const EdgeInsets.only(bottom: 9),
                      padding: const EdgeInsets.all(13),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F9FF),
                        borderRadius:
                        BorderRadius.circular(14),
                        border: Border.all(
                          color: const Color(0xFFE4E7F2),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.sticky_note_2_rounded,
                            color: Color(0xFF6366F1),
                            size: 19,
                          ),
                          const SizedBox(width: 9),
                          Expanded(
                            child: Text(
                              note,
                              style: const TextStyle(
                                color: Color(0xFF4B5563),
                                fontSize: 12,
                                height: 1.4,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () =>
                                deleteNote(index),
                            icon: const Icon(
                              Icons.delete_outline_rounded,
                              size: 19,
                            ),
                            color: Colors.grey,
                            padding: EdgeInsets.zero,
                            constraints:
                            const BoxConstraints(),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],

              const SizedBox(height: 25),

              Center(
                child: Text(
                  'Campus ID • Software Engineering • 2026',
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // APP BAR
  // ============================================================

  PreferredSizeWidget buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFFF5F7FC),
      elevation: 0,
      scrolledUnderElevation: 0,
      titleSpacing: 18,

      title: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF6366F1),
                  Color(0xFF4338CA),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.badge_rounded,
              color: Colors.white,
              size: 22,
            ),
          ),

          const SizedBox(width: 10),

          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Campus ID',
                style: TextStyle(
                  color: Color(0xFF171B2E),
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                'Student Dashboard',
                style: TextStyle(
                  color: Color(0xFF9CA3AF),
                  fontSize: 9,
                ),
              ),
            ],
          ),
        ],
      ),

      actions: [
        Container(
          margin: const EdgeInsets.only(right: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: CourseSearchDelegate(),
              );
            },
            icon: const Icon(
              Icons.search_rounded,
              color: Color(0xFF30364D),
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // DRAWER
  // ============================================================

  Widget buildDrawer() {
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Column(
          children: [

            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(
                24,
                25,
                24,
                25,
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF6366F1),
                    Color(0xFF4338CA),
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const CircleAvatar(
                          radius: 37,
                          backgroundColor:
                          Color(0xFFEEF2FF),
                          child: Icon(
                            Icons.person_rounded,
                            size: 45,
                            color: Color(0xFF4F46E5),
                          ),
                        ),
                      ),

                      Positioned(
                        right: 1,
                        bottom: 2,
                        child: Container(
                          height: 18,
                          width: 18,
                          decoration: BoxDecoration(
                            color: const Color(0xFF22C55E),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 3,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  const Text(
                    studentName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 3),

                  const Text(
                    rollNumber,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),

                  const SizedBox(height: 11),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.13),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.verified_rounded,
                          color: Colors.white,
                          size: 14,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Active Student',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            drawerItem(
              Icons.dashboard_rounded,
              'Dashboard',
              true,
                  () => Navigator.pop(context),
            ),

            drawerItem(
              Icons.badge_rounded,
              'Digital ID Card',
              false,
                  () {
                Navigator.pop(context);
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  builder: (_) => Padding(
                    padding: const EdgeInsets.all(10),
                    child: SingleChildScrollView(
                      child: buildIdCard(),
                    ),
                  ),
                );
              },
            ),

            drawerItem(
              Icons.menu_book_rounded,
              'My Courses',
              false,
                  () {
                Navigator.pop(context);
                Scrollable.ensureVisible(
                  context,
                  duration: const Duration(milliseconds: 300),
                );
              },
            ),

            drawerItem(
              Icons.edit_note_rounded,
              'Quick Notes',
              false,
                  () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Quick Notes section is available below.',
                    ),
                  ),
                );
              },
            ),

            drawerItem(
              Icons.person_rounded,
              'My Profile',
              false,
                  () {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (_) => const ProfileDialog(),
                );
              },
            ),

            const Spacer(),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Campus ID • 2026',
                style: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // DRAWER ITEM
  // ============================================================

  Widget drawerItem(
      IconData icon,
      String title,
      bool selected,
      VoidCallback onTap,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 2,
      ),
      child: ListTile(
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        tileColor: selected
            ? const Color(0xFFEEF2FF)
            : Colors.transparent,
        leading: Icon(
          icon,
          size: 21,
          color: selected
              ? const Color(0xFF4F46E5)
              : const Color(0xFF8A91A3),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: selected
                ? const Color(0xFF4F46E5)
                : const Color(0xFF4B5563),
            fontSize: 13,
            fontWeight: selected
                ? FontWeight.w700
                : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // ID CARD
  // ============================================================

  Widget buildIdCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF312E81),
            Color(0xFF4F46E5),
            Color(0xFF6366F1),
          ],
        ),
        borderRadius: BorderRadius.circular(27),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4F46E5)
                .withOpacity(0.25),
            blurRadius: 25,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Stack(
        children: [

          Positioned(
            right: -40,
            top: -50,
            child: Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.06),
                shape: BoxShape.circle,
              ),
            ),
          ),

          Positioned(
            left: -50,
            bottom: -60,
            child: Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [

                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.school_rounded,
                          color: Colors.white,
                          size: 21,
                        ),
                        SizedBox(width: 7),
                        Text(
                          'CAMPUS ID',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.4,
                          ),
                        ),
                      ],
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color:
                        Colors.white.withOpacity(0.12),
                        borderRadius:
                        BorderRadius.circular(9),
                      ),
                      child: const Text(
                        '2026',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 23),

                Row(
                  children: [

                    // REQUIRED: Stack + CircleAvatar
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          padding:
                          const EdgeInsets.all(3),
                          decoration:
                          const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const CircleAvatar(
                            radius: 40,
                            backgroundColor:
                            Color(0xFFEEF2FF),
                            child: Icon(
                              Icons.person_rounded,
                              size: 49,
                              color:
                              Color(0xFF4F46E5),
                            ),
                          ),
                        ),

                        // REQUIRED GREEN ACTIVE DOT
                        Positioned(
                          right: 0,
                          bottom: 2,
                          child: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              color:
                              const Color(0xFF22C55E),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 3,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(width: 15),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            studentName,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 21,
                              fontWeight:
                              FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            department,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 11,
                            ),
                          ),
                          SizedBox(height: 7),
                          Row(
                            children: [
                              Icon(
                                Icons.verified_rounded,
                                color: Color(0xFFA5F3FC),
                                size: 14,
                              ),
                              SizedBox(width: 5),
                              Text(
                                'Verified Student',
                                style: TextStyle(
                                  color:
                                  Color(0xFFA5F3FC),
                                  fontSize: 9,
                                  fontWeight:
                                  FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color:
                    Colors.white.withOpacity(0.10),
                    borderRadius:
                    BorderRadius.circular(16),
                    border: Border.all(
                      color:
                      Colors.white.withOpacity(0.10),
                    ),
                  ),
                  child: Column(
                    children: [
                      idInfoRow(
                        'Roll Number',
                        rollNumber,
                      ),
                      const SizedBox(height: 11),
                      idInfoRow(
                        'Department',
                        department,
                      ),
                      const SizedBox(height: 11),
                      idInfoRow(
                        'Semester',
                        semester,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'DIGITAL STUDENT ID',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 8,
                        letterSpacing: 1.3,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Row(
                      children: List.generate(
                        9,
                            (index) => Container(
                          margin:
                          const EdgeInsets.only(
                            left: 2,
                          ),
                          height: 14,
                          width:
                          index.isEven ? 3 : 1.5,
                          color: Colors.white38,
                        ),
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

  Widget idInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment:
      MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white60,
            fontSize: 9,
          ),
        ),
        const SizedBox(width: 10),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 9,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // STAT CARD
  // ============================================================

  Widget statCard(
      IconData icon,
      String number,
      String label,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 13,
        horizontal: 7,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.035),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 34,
            width: 34,
            decoration: BoxDecoration(
              color: const Color(0xFFEEF2FF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF4F46E5),
              size: 18,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            number,
            style: const TextStyle(
              color: Color(0xFF202437),
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF9CA3AF),
              fontSize: 9,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SECTION TITLE
  // ============================================================

  Widget sectionTitle(
      String title,
      String subtitle,
      ) {
    return Row(
      mainAxisAlignment:
      MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF171B2E),
                fontSize: 19,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              subtitle,
              style: const TextStyle(
                color: Color(0xFF9298A8),
                fontSize: 10,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ============================================================
  // OVERVIEW CARD
  // ============================================================

  Widget overviewCard(
      IconData icon,
      String title,
      String value,
      Color background,
      Color iconColor,
      ) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 39,
            width: 39,
            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 9),
          Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF9CA3AF),
                  fontSize: 9,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                value,
                style: const TextStyle(
                  color: Color(0xFF252A3D),
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ============================================================
// COURSE DETAILS BOTTOM SHEET
// ============================================================

class CourseDetailsSheet extends StatelessWidget {
  final Course course;

  const CourseDetailsSheet({
    super.key,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        20,
        12,
        20,
        25,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [

          Center(
            child: Container(
              height: 4,
              width: 42,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          const SizedBox(height: 22),

          Row(
            children: [
              Container(
                height: 52,
                width: 52,
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF2FF),
                  borderRadius:
                  BorderRadius.circular(15),
                ),
                child: Icon(
                  course.icon,
                  color: const Color(0xFF4F46E5),
                  size: 27,
                ),
              ),

              const SizedBox(width: 13),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.name,
                      style: const TextStyle(
                        color: Color(0xFF171B2E),
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      course.code,
                      style: const TextStyle(
                        color: Color(0xFF6366F1),
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          detailRow(
            Icons.school_rounded,
            'Credit Hours',
            course.creditHours,
          ),

          detailRow(
            Icons.person_rounded,
            'Instructor',
            course.instructor,
          ),

          detailRow(
            Icons.schedule_rounded,
            'Schedule',
            course.schedule,
          ),

          detailRow(
            Icons.location_on_rounded,
            'Room',
            course.room,
          ),

          const SizedBox(height: 10),

          SizedBox(
            width: double.infinity,
            height: 46,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                const Color(0xFF4F46E5),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(13),
                ),
              ),
              child: const Text(
                'Done',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget detailRow(
      IconData icon,
      String title,
      String value,
      ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF6366F1),
            size: 19,
          ),
          const SizedBox(width: 11),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF9CA3AF),
              fontSize: 11,
            ),
          ),
          const Spacer(),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Color(0xFF30364D),
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// PROFILE DIALOG
// ============================================================

class ProfileDialog extends StatelessWidget {
  const ProfileDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      title: const Text(
        'My Profile',
        style: TextStyle(
          fontWeight: FontWeight.w800,
        ),
      ),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 38,
            backgroundColor: Color(0xFFEEF2FF),
            child: Icon(
              Icons.person_rounded,
              color: Color(0xFF4F46E5),
              size: 45,
            ),
          ),
          SizedBox(height: 15),
          Text(
            studentName,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 5),
          Text(
            rollNumber,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          SizedBox(height: 18),
          ProfileInfo(
            title: 'Department',
            value: department,
          ),
          ProfileInfo(
            title: 'Semester',
            value: semester,
          ),
          ProfileInfo(
            title: 'Status',
            value: 'Active Student',
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: null,
          child: Text(
            'Close',
            style: TextStyle(
              color: Color(0xFF4F46E5),
            ),
          ),
        ),
      ],
    );
  }
}

class ProfileInfo extends StatelessWidget {
  final String title;
  final String value;

  const ProfileInfo({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            '$title:',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 11,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF30364D),
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// SEARCH
// ============================================================

class CourseSearchDelegate
    extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(
      BuildContext context,
      ) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear_rounded),
      ),
    ];
  }

  @override
  Widget? buildLeading(
      BuildContext context,
      ) {
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: const Icon(
        Icons.arrow_back_rounded,
      ),
    );
  }

  List<Course> get results {
    return courses.where((course) {
      final text =
      '${course.name} ${course.code}'
          .toLowerCase();

      return text.contains(
        query.toLowerCase(),
      );
    }).toList();
  }

  @override
  Widget buildResults(
      BuildContext context,
      ) {
    return buildSearchList();
  }

  @override
  Widget buildSuggestions(
      BuildContext context,
      ) {
    return buildSearchList();
  }

  Widget buildSearchList() {
    if (results.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 45,
              color: Colors.grey,
            ),
            SizedBox(height: 10),
            Text(
              'No course found',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final course = results[index];

        return ListTile(
          leading: Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFEEF2FF),
              borderRadius:
              BorderRadius.circular(11),
            ),
            child: Icon(
              course.icon,
              color: const Color(0xFF4F46E5),
            ),
          ),
          title: Text(
            course.name,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(course.code),
        );
      },
    );
  }
}