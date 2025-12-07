// ==================== lib/screens/leaderboard/leaderboard_screen.dart ====================
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Gradient App Bar
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFFFA751),
                      Color(0xFFFFE259),
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 60),
                    Icon(Icons.emoji_events, size: 80, color: Colors.white),
                    SizedBox(height: 16),
                    Text(
                      'Leaderboard',
                      style: GoogleFonts.poppins(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Top Contributors of the Month',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Tab Bar
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              child: TabBar(
                controller: _tabController,
                labelColor: Color(0xFFFFA751),
                unselectedLabelColor: Colors.grey,
                indicatorColor: Color(0xFFFFA751),
                labelStyle: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
                tabs: const [
                  Tab(text: 'All Time'),
                  Tab(text: 'This Month'),
                  Tab(text: 'This Week'),
                ],
              ),
            ),
          ),

          // Tab Content
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildLeaderboardList(),
                _buildLeaderboardList(),
                _buildLeaderboardList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeaderboardList() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: 20,
      itemBuilder: (context, index) {
        return _buildLeaderboardCard(index);
      },
    );
  }

  Widget _buildLeaderboardCard(int index) {
    final rank = index + 1;
    final medals = ['🥇', '🥈', '🥉'];
    final colors = [Colors.amber, Colors.grey[400]!, Colors.brown[400]!];
    
    final isTopThree = rank <= 3;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isTopThree ? colors[index].withOpacity(0.5) : Colors.grey.shade200,
          width: isTopThree ? 2 : 1,
        ),
        boxShadow: isTopThree
            ? [
                BoxShadow(
                  color: colors[index].withOpacity(0.2),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ]
            : [],
      ),
      child: Row(
        children: [
          // Rank
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              gradient: isTopThree
                  ? LinearGradient(
                      colors: [colors[index], colors[index].withOpacity(0.7)],
                    )
                  : null,
              color: isTopThree ? null : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                isTopThree ? medals[index] : '#$rank',
                style: GoogleFonts.poppins(
                  fontSize: isTopThree ? 28 : 16,
                  fontWeight: FontWeight.bold,
                  color: isTopThree ? Colors.white : Colors.grey.shade700,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          
          // Avatar
          CircleAvatar(
            radius: 28,
            backgroundColor: isTopThree ? colors[index].withOpacity(0.2) : Colors.grey.shade200,
            child: Text(
              'U${rank}',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isTopThree ? colors[index] : Colors.grey.shade700,
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
                  'Student $rank',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${45 - index} uploads',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          
          // Points
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isTopThree ? colors[index].withOpacity(0.1) : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.stars,
                  color: isTopThree ? colors[index] : Colors.grey.shade700,
                  size: 16,
                ),
                const SizedBox(width: 6),
                Text(
                  '${1000 - (index * 30)}',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isTopThree ? colors[index] : Colors.grey.shade700,
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