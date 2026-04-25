import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

final appLocaleNotifier = ValueNotifier<Locale>(const Locale('en'));

// ─── Localisation strings ─────────────────────────────────────────────────────

class _S {
  final bool ar;
  const _S(this.ar);

  static _S of(BuildContext context) =>
      _S(Localizations.localeOf(context).languageCode == 'ar');

  String get goodEvening => ar ? 'مساء الخير،' : 'Good evening,';
  String get streakBadge => ar ? '🔥 تسلسل 17 يوماً' : '🔥 17 day streak';
  String get liveNow => ar ? 'مباشر الآن' : 'LIVE NOW';
  String get studentsStudying =>
      ar ? 'طالب يدرسون الآن' : 'students are studying right now';
  String get startStudying => ar ? 'ابدأ الدراسة' : 'START STUDYING';
  String get timerHint =>
      ar ? 'اختر مؤقتك وادخل في التدفق' : 'Choose your timer and get in the flow';
  String get joinLiveSessions =>
      ar ? 'انضم إلى الجلسات المباشرة' : 'Join Live Sessions';
  String get seeAll => ar ? 'عرض الكل' : 'See all';
  String get morningTitle => ar ? 'الجلسة الصباحية' : 'Morning Session';
  String get morningSubtitle => ar ? 'الطاقة والتركيز' : 'Energy & Focus';
  String get eveningTitle => ar ? 'الجلسة المسائية' : 'Evening Session';
  String get eveningSubtitle => ar ? 'تجاوز حدودك' : 'Push Your Limits';
  String get nightTitle => ar ? 'الجلسة الليلية' : 'Night Session';
  String get nightSubtitle => ar ? 'تركيز عميق' : 'Deep Focus';
  String get joinBtn => ar ? 'انضم' : 'JOIN';
  String get todaysFocus => ar ? 'وقت التركيز اليوم' : "Today's focus time";
  String get globalTotal => ar ? 'المجموع العالمي' : 'Global total';
  String get dailyGoal => ar ? 'هدفك اليومي' : 'Your daily goal';
  String get yourStreak => ar ? 'تسلسلك' : 'Your streak';
  String get keepItUp => ar ? 'واصل! 🔥' : 'Keep it up! 🔥';
  String get navHome => ar ? 'الرئيسية' : 'Home';
  String get navJoin => ar ? 'انضم' : 'Join';
  String get navRank => ar ? 'الترتيب' : 'Rank';
  String get navFriends => ar ? 'الأصدقاء' : 'Friends';
  String get navAccount => ar ? 'الحساب' : 'Account';
  String get accountTitle => ar ? 'الحساب' : 'Account';
  String get languageLabel => 'Language (اللغة)';
  String get languageValue => ar ? 'العربية' : 'English';
  String get leaderboard => ar ? 'لوحة المتصدرين' : 'Leaderboard';
  String get friends => ar ? 'الأصدقاء' : 'Friends';
  String get comingSoon => ar ? 'قريباً' : 'Coming soon';
  String get morningTime => '06:00 AM - 12:00 PM';
  String get eveningTime => '12:00 PM - 06:00 PM';
  String get nightTime => '06:00 PM - 06:00 AM';
}

void main() {
  runApp(const StudyRoomsApp());
}

class StudyRoomsApp extends StatelessWidget {
  const StudyRoomsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: appLocaleNotifier,
      builder: (context, locale, child) {
        return MaterialApp(
          title: 'Study Rooms',
          locale: locale,
          supportedLocales: const [
            Locale('en'),
            Locale('ar'),
          ],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: const Color(0xFF0A0A0A),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFF5C27A),
          secondary: Color(0xFFFFF5E8),
          surface: Color(0xFF1B120D),
        ),
        textTheme: ThemeData.dark().textTheme.apply(
              fontFamily: 'System', // Adjust to your preferred font
              bodyColor: const Color(0xFFFFF5E8),
              displayColor: const Color(0xFFFFF5E8),
            ),
      ),
      home: const MainShell(),
    );
      },
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = [
    HomePage(),
    JoinPage(),
    RankPage(),
    FriendsPage(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          IndexedStack(
            index: _selectedIndex,
            children: _pages,
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _BottomNav(
              selectedIndex: _selectedIndex,
              onTap: (i) => setState(() => _selectedIndex = i),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Bottom Navigation Bar ────────────────────────────────────────────────────

class _BottomNav extends StatelessWidget {
  const _BottomNav({required this.selectedIndex, required this.onTap});

  final int selectedIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final s = _S.of(context);
    final items = [
      (icon: Icons.home_rounded, label: s.navHome),
      (icon: Icons.public_rounded, label: s.navJoin),
      (icon: Icons.emoji_events_rounded, label: s.navRank),
      (icon: Icons.people_rounded, label: s.navFriends),
      (icon: Icons.person_outline_rounded, label: s.navAccount),
    ];

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF120D0A).withOpacity(0.95), // very dark warm
        border: Border(
          top: BorderSide(color: Colors.white.withOpacity(0.05)),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (i) {
              final item = items[i];
              final selected = i == selectedIndex;
              final color = selected
                  ? const Color(0xFFF5C27A)
                  : Colors.white.withOpacity(0.4);
                  
              return GestureDetector(
                onTap: () => onTap(i),
                behavior: HitTestBehavior.opaque,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      item.icon,
                      color: color,
                      size: 24,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.label,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                        color: color,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

// ─── Home Page ────────────────────────────────────────────────────────────────

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late final ScrollController _scrollController;
  late final AnimationController _animationController;
  late final Animation<double> _anim1;
  late final Animation<double> _anim2;
  late final Animation<double> _anim3;
  late final Animation<double> _anim4;
  late final Animation<double> _anim5;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _animationController = AnimationController(
       vsync: this, 
       duration: const Duration(milliseconds: 2500),
    );
    _anim1 = CurvedAnimation(parent: _animationController, curve: const Interval(0.00, 0.20, curve: Curves.easeOutCubic));
    _anim2 = CurvedAnimation(parent: _animationController, curve: const Interval(0.20, 0.40, curve: Curves.easeOutCubic));
    _anim3 = CurvedAnimation(parent: _animationController, curve: const Interval(0.40, 0.60, curve: Curves.easeOutCubic));
    _anim4 = CurvedAnimation(parent: _animationController, curve: const Interval(0.60, 0.80, curve: Curves.easeOutCubic));
    _anim5 = CurvedAnimation(parent: _animationController, curve: const Interval(0.80, 1.00, curve: Curves.easeOutCubic));
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image with Parallax & Fade
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: _scrollController,
              builder: (context, child) {
                double scrollY = 0.0;
                if (_scrollController.hasClients) {
                  scrollY = _scrollController.offset.clamp(0.0, double.infinity);
                }
                
                final translateY = -(scrollY * 0.2); // Slow scroll effect
                final opacity = (1.0 - (scrollY / 500)).clamp(0.3, 1.0); // Light fade

                return Transform.translate(
                  offset: Offset(0, translateY),
                  child: Opacity(
                    opacity: opacity,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height + 300, // Extra height for parallax travel
                      child: child,
                    ),
                  ),
                );
              },
              child: Image.asset(
                'assets/images/home_night.jpg',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback if image is missing
                  return Container(color: const Color(0xFF1B120D));
                },
              ),
            ),
          ),
          
          // Gradient overlays
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.2),
                    Colors.black.withOpacity(0.8),
                    Colors.black,
                  ],
                  stops: const [0.0, 0.3, 0.7, 1.0],
                ),
              ),
            ),
          ),

          // Content
          SafeArea(
            bottom: false,
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: _AnimatedSection(animation: _anim1, child: const _Header()),
                ),
                
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const SizedBox(height: 60),
                      _AnimatedSection(animation: _anim2, child: const _CenterStats()),
                      const SizedBox(height: 32),
                      _AnimatedSection(animation: _anim3, child: const _StartStudyingButton()),
                      const SizedBox(height: 40),
                      _AnimatedSection(animation: _anim4, child: _LiveSessionsSection()),
                      const SizedBox(height: 24),
                      _AnimatedSection(animation: _anim5, child: const _BottomStatsPanel()),
                      const SizedBox(height: 120), // Padding for bottom nav
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedSection extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;

  const _AnimatedSection({required this.animation, required this.child});

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.4), 
          end: Offset.zero,
        ).animate(animation),
        child: child,
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final s = _S.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Avatar
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white24, width: 1),
              image: const DecorationImage(
                image: NetworkImage('https://i.pravatar.cc/150?img=11'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          // User Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  s.goodEvening,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.8),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Row(
                  children: [
                    const Text(
                      'Zakaria',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text('👋', style: TextStyle(fontSize: 18)),
                  ],
                ),
                const SizedBox(height: 4),
                // Streak Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white12),
                  ),
                  child: Text(
                    s.streakBadge,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.9),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Actions
          _HeaderIconButton(icon: Icons.notifications_none_rounded, showBadge: true),
          const SizedBox(width: 12),
          _HeaderIconButton(icon: Icons.card_giftcard_rounded, showBadge: false),
        ],
      ),
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  final IconData icon;
  final bool showBadge;

  const _HeaderIconButton({required this.icon, this.showBadge = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white12),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 22),
          if (showBadge)
            Positioned(
              right: 12,
              top: 12,
              child: Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: Colors.redAccent,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _CenterStats extends StatelessWidget {
  const _CenterStats();

  @override
  Widget build(BuildContext context) {
    final s = _S.of(context);
    return Column(
      children: [
        // Live Now Label
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Colors.greenAccent,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              s.liveNow,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        
        // Huge Number
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '4,281',
              style: TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                height: 1.1,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              margin: const EdgeInsets.only(top: 12),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white38),
              ),
              child: const Icon(Icons.add, color: Colors.white, size: 16),
            ),
          ],
        ),
        
        Text(
          s.studentsStudying,
          style: TextStyle(
            fontSize: 15,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
        const SizedBox(height: 20),
        
        // Avatars row
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildOverlappingAvatars(),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                '+4.2K',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOverlappingAvatars() {
    final avatarUrls = [
      'https://i.pravatar.cc/150?img=32',
      'https://i.pravatar.cc/150?img=12',
      'https://i.pravatar.cc/150?img=68',
      'https://i.pravatar.cc/150?img=59',
      'https://i.pravatar.cc/150?img=47',
    ];

    return SizedBox(
      width: (avatarUrls.length * 28.0) + 8,
      height: 36,
      child: Stack(
        children: List.generate(avatarUrls.length, (index) {
          return Positioned(
            left: index * 26.0,
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 2),
                image: DecorationImage(
                  image: NetworkImage(avatarUrls[index]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _StartStudyingButton extends StatelessWidget {
  const _StartStudyingButton();

  @override
  Widget build(BuildContext context) {
    final s = _S.of(context);
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 40),
          height: 64,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            gradient: const LinearGradient(
              colors: [Color(0xFFFFDAB9), Color(0xFFF5C27A)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFF5C27A).withOpacity(0.4),
                blurRadius: 24,
                spreadRadius: -4,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(32),
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    s.startStudying,
                    style: const TextStyle(
                      color: Color(0xFF4A2B0F),
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.arrow_forward_rounded,
                    color: Color(0xFF4A2B0F),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.keyboard_return_rounded, 
                 size: 14, 
                 color: Colors.white.withOpacity(0.5)),
            const SizedBox(width: 6),
            Text(
              s.timerHint,
              style: TextStyle(
                fontSize: 13,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _LiveSessionsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final s = _S.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                s.joinLiveSessions,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              Row(
                children: [
                  Text(
                    s.seeAll,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.chevron_right_rounded,
                    size: 16,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 180,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            children: [
              _SessionCard(
                title: s.morningTitle,
                subtitle: s.morningSubtitle,
                count: '1,842',
                time: s.morningTime,
                joinLabel: s.joinBtn,
                icon: Icons.wb_sunny_rounded,
                iconColor: const Color(0xFFFFDAB9),
                imagePath: 'assets/images/morning_card.jpg',
              ),
              _SessionCard(
                title: s.eveningTitle,
                subtitle: s.eveningSubtitle,
                count: '2,315',
                time: s.eveningTime,
                joinLabel: s.joinBtn,
                icon: Icons.wb_twilight_rounded,
                iconColor: const Color(0xFFFF9E80),
                imagePath: 'assets/images/evening_card.jpg',
              ),
              _SessionCard(
                title: s.nightTitle,
                subtitle: s.nightSubtitle,
                count: '2,124',
                time: s.nightTime,
                joinLabel: s.joinBtn,
                icon: Icons.nightlight_round,
                iconColor: const Color(0xFFB39DDB),
                imagePath: 'assets/images/night_card.jpg',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SessionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String count;
  final String time;
  final String joinLabel;
  final IconData icon;
  final Color iconColor;
  final String imagePath;

  const _SessionCard({
    required this.title,
    required this.subtitle,
    required this.count,
    required this.time,
    required this.joinLabel,
    required this.icon,
    required this.iconColor,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(color: const Color(0xFF1B120D));
                },
              ),
            ),
            // Dark Gradient Overlay for readability
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.5),
                      Colors.black.withOpacity(0.2),
                      Colors.black.withOpacity(0.6),
                      Colors.black.withOpacity(0.8),
                    ],
                  ),
                ),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Row(
                  children: [
                    Icon(icon, color: iconColor, size: 16),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.people_alt_outlined, 
                         color: Colors.white.withOpacity(0.7), size: 14),
                    const SizedBox(width: 4),
                    Text(
                      count,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withOpacity(0.9),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      joinLabel,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: Text(
                    time,
                    style: TextStyle(
                      fontSize: 9,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ],
        ),
      ),
    );
  }
}

  class _BottomStatsPanel extends StatelessWidget {
  const _BottomStatsPanel();

  @override
  Widget build(BuildContext context) {
    final s = _S.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white12),
        // Glassmorphism effect
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Stat 1
              _StatItem(
                icon: Icons.group_rounded,
                iconColor: const Color(0xFFF5C27A),
                label: s.todaysFocus,
                value: '12h 45m',
                sublabel: s.globalTotal,
                extraValue: '↑',
                extraColor: Colors.greenAccent,
              ),
              Container(width: 1, height: 40, color: Colors.white12),
              // Stat 2
              _StatItem(
                icon: Icons.track_changes_rounded,
                iconColor: const Color(0xFFF5C27A),
                label: s.dailyGoal,
                value: '4h / 6h',
                sublabel: '',
                showProgress: true,
              ),
              Container(width: 1, height: 40, color: Colors.white12),
              // Stat 3
              _StatItem(
                icon: Icons.local_fire_department_rounded,
                iconColor: Colors.deepOrangeAccent,
                label: s.yourStreak,
                value: '17 days',
                sublabel: s.keepItUp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;
  final String sublabel;
  final String? extraValue;
  final Color? extraColor;
  final bool showProgress;

  const _StatItem({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    required this.sublabel,
    this.extraValue,
    this.extraColor,
    this.showProgress = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 2),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: AlignmentDirectional.centerStart,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        value,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      if (extraValue != null) ...[
                        const SizedBox(width: 4),
                        Text(
                          extraValue!,
                          style: TextStyle(
                            fontSize: 12,
                            color: extraColor ?? Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
                if (showProgress) ...[
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(2),
                    child: LinearProgressIndicator(
                      value: 4 / 6,
                      minHeight: 4,
                      backgroundColor: Colors.white12,
                      valueColor: const AlwaysStoppedAnimation(Color(0xFFF5C27A)),
                    ),
                  ),
                ] else ...[
                  const SizedBox(height: 2),
                  Text(
                    sublabel,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Placeholder Pages ────────────────────────────────────────────────────────

class JoinPage extends StatelessWidget {
  const JoinPage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = _S.of(context);
    return _PlaceholderPage(icon: Icons.public_rounded, label: s.joinLiveSessions);
  }
}

class RankPage extends StatelessWidget {
  const RankPage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = _S.of(context);
    return _PlaceholderPage(icon: Icons.emoji_events_rounded, label: s.leaderboard);
  }
}

class FriendsPage extends StatelessWidget {
  const FriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = _S.of(context);
    return _PlaceholderPage(icon: Icons.people_rounded, label: s.friends);
  }
}

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = _S.of(context);
    return Container(
      color: const Color(0xFF0A0A0A),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                s.accountTitle,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 32),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white12),
                ),
                child: SwitchListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  title: Text(
                    s.languageLabel,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    s.languageValue,
                    style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 13),
                  ),
                  value: s.ar,
                  activeThumbColor: const Color(0xFFF5C27A),
                  activeTrackColor: const Color(0xFFF5C27A).withOpacity(0.3),
                  inactiveThumbColor: Colors.white60,
                  onChanged: (val) {
                    appLocaleNotifier.value = val ? const Locale('ar') : const Locale('en');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PlaceholderPage extends StatelessWidget {
  const _PlaceholderPage({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final s = _S.of(context);
    return Container(
      color: const Color(0xFF0A0A0A),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 56, color: const Color(0xFFF5C27A)),
              const SizedBox(height: 16),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                s.comingSoon,
                style: const TextStyle(fontSize: 14, color: Colors.white60),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
