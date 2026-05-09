import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AchieveScreen extends StatefulWidget {
  const AchieveScreen({super.key});
  @override
  State<AchieveScreen> createState() => _AchieveScreenState();
}

class _AchieveScreenState extends State<AchieveScreen> with TickerProviderStateMixin {
  late AnimationController _pulseCtrl;
  late Animation<double> _pulseAnim;
  late AnimationController _rankBarCtrl;
  late Animation<double> _rankBarAnim;
  late AnimationController _badgeEntranceCtrl;
  late Animation<double> _badgeScaleAnim;
  late Animation<double> _badgeBloomAnim;
  int _selectedBadge = 0;

  @override
  void initState() {
    super.initState();
    // Continuous neon glow pulse for badges
    _pulseCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 2200))..repeat(reverse: true);
    _pulseAnim = Tween(begin: 0.2, end: 0.7).animate(CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut));

    // Animated rank progress bar fill
    _rankBarCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
    _rankBarAnim = Tween(begin: 0.0, end: 0.56).animate(CurvedAnimation(parent: _rankBarCtrl, curve: Curves.easeOutCubic));

    // Badge entrance animation (scale-in + bloom)
    _badgeEntranceCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    _badgeScaleAnim = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _badgeEntranceCtrl, curve: const Interval(0.0, 0.6, curve: Curves.elasticOut)));
    _badgeBloomAnim = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _badgeEntranceCtrl, curve: const Interval(0.3, 1.0, curve: Curves.easeOut)));

    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) { _rankBarCtrl.forward(); _badgeEntranceCtrl.forward(); }
    });
  }

  @override
  void dispose() { _pulseCtrl.dispose(); _rankBarCtrl.dispose(); _badgeEntranceCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Achievements', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
        const SizedBox(height: 4),
        const Text('Level up your real life 🎮', style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
        const SizedBox(height: 20),
        _buildCurrentRankCard(),
        const SizedBox(height: 20),
        Text('ALL RANKS', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.sectionLabel, letterSpacing: 1.2)),
        const SizedBox(height: 12), _buildAllRanks(),
        const SizedBox(height: 20),
        Text('HOW TO EARN XP', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.sectionLabel, letterSpacing: 1.2)),
        const SizedBox(height: 12), _buildEarnXPCard(),
        const SizedBox(height: 20),
        Text('RECENT BADGES', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.sectionLabel, letterSpacing: 1.2)),
        const SizedBox(height: 12), _buildRecentBadges(),
        const SizedBox(height: 30),
      ]),
    ));
  }

  Widget _buildCurrentRankCard() {
    return AnimatedBuilder(animation: Listenable.merge([_rankBarAnim, _pulseAnim]), builder: (context, _) {
      final animXP = (840 * (_rankBarAnim.value / 0.56)).round();
      final animPercent = (_rankBarAnim.value * 100).round();
      return Container(width: double.infinity, padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(color: AppColors.cardBackground, borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.surfaceLight.withValues(alpha: 0.5), width: 0.5)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Container(width: 56, height: 56,
              decoration: BoxDecoration(shape: BoxShape.circle,
                gradient: LinearGradient(colors: [Colors.grey.shade300, Colors.grey.shade500]),
                boxShadow: [
                  BoxShadow(color: AppColors.purple.withValues(alpha: _pulseAnim.value * 0.4), blurRadius: 20, spreadRadius: 3),
                  BoxShadow(color: const Color(0xFF7C3AED).withValues(alpha: _pulseAnim.value * 0.25), blurRadius: 35, spreadRadius: 8),
                  BoxShadow(color: AppColors.purple.withValues(alpha: _pulseAnim.value * 0.12), blurRadius: 50, spreadRadius: 14),
                ]),
              child: const Center(child: Text('🥈', style: TextStyle(fontSize: 28)))),
            const SizedBox(width: 14),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('CURRENT RANK', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.sectionLabel, letterSpacing: 1)),
              const SizedBox(height: 4),
              const Text('Silver', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
              const SizedBox(height: 2),
              RichText(text: TextSpan(style: TextStyle(fontSize: 12, color: AppColors.textSecondary), children: [
                TextSpan(text: '$animXP XP · '),
                TextSpan(text: '${1500 - animXP} XP to Gold', style: TextStyle(color: AppColors.orange)),
                const TextSpan(text: ' 🏅'),
              ])),
            ])),
            Column(children: [
              Text('$animXP', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: AppColors.orange)),
              Text('Total XP', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
            ]),
          ]),
          const SizedBox(height: 14),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Silver (500)', style: TextStyle(fontSize: 10, color: AppColors.textMuted)),
            Text('Gold (1500)', style: TextStyle(fontSize: 10, color: AppColors.textMuted)),
          ]),
          const SizedBox(height: 6),
          // Animated progress bar with glow
          Container(height: 10, width: double.infinity,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: AppColors.surfaceLight),
            child: FractionallySizedBox(alignment: Alignment.centerLeft,
              widthFactor: _rankBarAnim.value.clamp(0.0, 1.0),
              child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: AppColors.blue,
                boxShadow: [
                  BoxShadow(color: AppColors.blue.withValues(alpha: _pulseAnim.value * 0.5), blurRadius: 10, spreadRadius: 1),
                ])))),
          const SizedBox(height: 6),
          Center(child: Text('$animPercent% progress to Gold', style: TextStyle(fontSize: 11, color: AppColors.textSecondary))),
        ]));
    });
  }

  Widget _buildAllRanks() {
    return AnimatedBuilder(animation: Listenable.merge([_badgeEntranceCtrl, _pulseAnim]), builder: (context, _) {
      return Container(width: double.infinity, padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(color: AppColors.cardBackground, borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.surfaceLight.withValues(alpha: 0.5), width: 0.5)),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          _buildRankItem('🥉', 'BRONZE', '0-500', 'DONE ✓', true, false, 0),
          _buildRankItem('🥈', 'SILVER', '500-1.5k', 'CURRENT', true, true, 1),
          _buildRankItem('🥇', 'GOLD', '1.5k-3k', 'LOCKED 🔒', false, false, 2),
          _buildRankItem('💎', 'DIAMOND', '3k-5k', 'LOCKED 🔒', false, false, 3),
          _buildRankItem('👑', 'MASTER', '5k+', 'LOCKED 🔒', false, false, 4),
        ]));
    });
  }

  Widget _buildRankItem(String emoji, String name, String range, String status, bool unlocked, bool isCurrent, int index) {
    // Staggered entrance per badge
    final delay = index * 0.1;
    final scaleVal = Curves.elasticOut.transform(((_badgeScaleAnim.value - delay) / (1.0 - delay)).clamp(0.0, 1.0));
    final bloomVal = ((_badgeBloomAnim.value - delay) / (1.0 - delay)).clamp(0.0, 1.0);

    return Transform.scale(scale: 0.5 + (scaleVal * 0.5),
      child: Opacity(opacity: scaleVal.clamp(0.0, 1.0),
        child: Column(children: [
          Container(width: 52, height: 52,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: (unlocked || isCurrent) ? AppColors.purple.withValues(alpha: isCurrent ? 0.15 : 0.08) : Colors.transparent,
              border: (unlocked || isCurrent) ? Border.all(color: AppColors.purple.withValues(alpha: isCurrent ? 0.7 : 0.35), width: isCurrent ? 2 : 1.5) : null,
              boxShadow: unlocked ? [
                // Neon glow aura
                BoxShadow(color: AppColors.purple.withValues(alpha: _pulseAnim.value * (isCurrent ? 0.35 : 0.2) * bloomVal), blurRadius: 18, spreadRadius: isCurrent ? 3 : 1),
                // Bloom expansion
                BoxShadow(color: const Color(0xFF7C3AED).withValues(alpha: _pulseAnim.value * (isCurrent ? 0.2 : 0.12) * bloomVal), blurRadius: 30, spreadRadius: isCurrent ? 6 : 3),
                // Outer soft aura
                BoxShadow(color: AppColors.purple.withValues(alpha: _pulseAnim.value * (isCurrent ? 0.1 : 0.06) * bloomVal), blurRadius: 45, spreadRadius: isCurrent ? 10 : 5),
              ] : []),
            child: Center(child: Text(emoji, style: TextStyle(fontSize: 24,
              color: unlocked ? null : Colors.white.withValues(alpha: 0.3))))),
          const SizedBox(height: 6),
          Text(name, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, letterSpacing: 0.5,
            color: isCurrent ? AppColors.orange : unlocked ? AppColors.textSecondary : AppColors.textMuted)),
          Text(range, style: TextStyle(fontSize: 8, color: AppColors.textMuted)),
          const SizedBox(height: 2),
          Text(status, style: TextStyle(fontSize: 7, fontWeight: FontWeight.w600,
            color: status == 'CURRENT' ? AppColors.purple : status.contains('DONE') ? AppColors.green : AppColors.textMuted)),
        ])));
  }

  Widget _buildEarnXPCard() {
    return Container(width: double.infinity, padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.cardBackground, borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.surfaceLight.withValues(alpha: 0.5), width: 0.5)),
      child: Column(children: [
        _buildXPRow('📉', 'Reduce Social Usage', 'Save 30 min below your daily average', '+50 XP', AppColors.green),
        const Divider(color: AppColors.surfaceLight, height: 24),
        _buildXPRow('🎯', 'Complete a Goal', 'Finish any daily goal fully', '+100 XP', AppColors.green),
        const Divider(color: AppColors.surfaceLight, height: 24),
        _buildXPRow('🔥', 'Maintain a Streak', 'Keep any goal active 7+ days', '+200 XP', AppColors.green),
        const Divider(color: AppColors.surfaceLight, height: 24),
        _buildXPRow('📚', 'Learning Minutes', 'Read, code or study — per minute', '+1 XP/min', AppColors.green),
      ]));
  }

  Widget _buildXPRow(String emoji, String title, String subtitle, String xpText, Color xpColor) {
    return Row(children: [
      Container(width: 40, height: 40,
        decoration: BoxDecoration(color: AppColors.surfaceLight, borderRadius: BorderRadius.circular(10)),
        child: Center(child: Text(emoji, style: const TextStyle(fontSize: 20)))),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
        Text(subtitle, style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
      ])),
      Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(border: Border.all(color: xpColor, width: 1), borderRadius: BorderRadius.circular(8)),
        child: Text(xpText, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: xpColor))),
    ]);
  }

  Widget _buildRecentBadges() {
    final badges = [
      _Badge('🔥', 'On Fire', '12-day reading streak', '+200', 'XP earned', AppColors.orange, true),
      _Badge('📖', 'Bookworm', 'Read 20 pages — goal complete', '+100', 'XP earned', AppColors.green, true),
      _Badge('🧘', 'Detox Mode', 'Saved 45m social time yesterday', '+50', 'XP earned', AppColors.purple, true),
      _Badge('💻', 'Code Warrior', 'Complete 7 code lessons in a row', '+350', 'XP locked', AppColors.textMuted, false),
      _Badge('🏆', 'Grandmaster', 'Reach Master rank — 6000 XP', '+1k', 'XP locked', AppColors.textMuted, false),
    ];

    return Column(children: badges.asMap().entries.map((entry) {
      final i = entry.key;
      final b = entry.value;
      return Padding(padding: EdgeInsets.only(bottom: i < badges.length - 1 ? 10 : 0),
        child: GestureDetector(
          onTap: () => setState(() => _selectedBadge = i),
          child: _buildBadgeTile(b, i == _selectedBadge)));
    }).toList());
  }

  Widget _buildBadgeTile(_Badge b, bool isSelected) {
    return AnimatedBuilder(animation: _pulseAnim, builder: (context, _) {
      return AnimatedContainer(duration: const Duration(milliseconds: 300), curve: Curves.easeOut,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.cardBackgroundLight : AppColors.cardBackground,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? AppColors.purple.withValues(alpha: 0.6) : AppColors.surfaceLight.withValues(alpha: 0.5),
            width: isSelected ? 1.5 : 0.5),
          boxShadow: isSelected ? [
            BoxShadow(color: AppColors.purple.withValues(alpha: _pulseAnim.value * 0.25), blurRadius: 24, spreadRadius: 2),
            BoxShadow(color: AppColors.purple.withValues(alpha: _pulseAnim.value * 0.15), blurRadius: 40, spreadRadius: 6),
            BoxShadow(color: const Color(0xFF7C3AED).withValues(alpha: _pulseAnim.value * 0.1), blurRadius: 60, spreadRadius: 10),
          ] : []),
        child: Row(children: [
          AnimatedScale(scale: isSelected ? 1.1 : 1.0, duration: const Duration(milliseconds: 300),
            child: Container(width: 42, height: 42,
              decoration: BoxDecoration(
                color: b.accentColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
                boxShadow: isSelected ? [
                  BoxShadow(color: AppColors.purple.withValues(alpha: _pulseAnim.value * 0.4), blurRadius: 12, spreadRadius: 1),
                ] : []),
              child: Center(child: Text(b.emoji, style: TextStyle(fontSize: 22,
                color: b.earned ? null : Colors.white.withValues(alpha: 0.3)))))),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(b.title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600,
              color: b.earned ? AppColors.textPrimary : AppColors.textSecondary)),
            Text(b.subtitle, style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
          ])),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(b.xpValue, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: b.accentColor)),
            Text(b.xpLabel, style: TextStyle(fontSize: 10, color: AppColors.textMuted)),
          ]),
        ]));
    });
  }
}

class _Badge {
  final String emoji, title, subtitle, xpValue, xpLabel;
  final Color accentColor;
  final bool earned;
  _Badge(this.emoji, this.title, this.subtitle, this.xpValue, this.xpLabel, this.accentColor, this.earned);
}
