import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class UsageScreen extends StatefulWidget {
  const UsageScreen({super.key});
  @override
  State<UsageScreen> createState() => _UsageScreenState();
}

class _UsageScreenState extends State<UsageScreen> with TickerProviderStateMixin {
  late AnimationController _barController;
  late AnimationController _glowCtrl;
  late Animation<double> _glowAnim;

  // App usage data: name, emoji, minutes, gradient, timeLabel, barFraction
  final List<_AppData> _apps = [
    _AppData('📷', 'Instagram', 88, [const Color(0xFFE91E8C), const Color(0xFFFF6EB4)], '1h 28m', 0.65),
    _AppData('▶️', 'YouTube', 70, [const Color(0xFFE74C3C), const Color(0xFFFF6B6B)], '1h 10m', 0.52),
    _AppData('🎵', 'TikTok', 52, [const Color(0xFF3498DB), const Color(0xFF5DADE2)], '52m', 0.32),
    _AppData('💬', 'WhatsApp', 40, [const Color(0xFF00C9A7), const Color(0xFF2ECC71)], '40m', 0.25),
    _AppData('✖️', 'Twitter', 28, [const Color(0xFF3498DB), const Color(0xFF5DADE2)], '28m', 0.18),
    _AppData('📱', 'Others', 45, [const Color(0xFF5A5E72), const Color(0xFF8E92A4)], '45m', 0.15),
  ];

  @override
  void initState() {
    super.initState();
    _barController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
    _glowCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000))..repeat(reverse: true);
    _glowAnim = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _glowCtrl, curve: Curves.easeInOut));
    Future.delayed(const Duration(milliseconds: 300), () { if (mounted) _barController.forward(); });
  }

  @override
  void dispose() { _barController.dispose(); _glowCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Usage', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
        const SizedBox(height: 4),
        Text("Today's screen time breakdown", style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
        const SizedBox(height: 20),
        _buildTotalScreenTimeCard(),
        const SizedBox(height: 20),
        Text('HOURLY PATTERN', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.sectionLabel, letterSpacing: 1.2)),
        const SizedBox(height: 12),
        _buildHourlyPatternCard(),
        const SizedBox(height: 30),
      ]),
    ));
  }

  Widget _buildTotalScreenTimeCard() {
    return AnimatedBuilder(animation: Listenable.merge([_barController, _glowAnim]), builder: (context, _) {
      final p = _barController.value;
      // Animate total time: 6h 43m = 403 min
      final totalMin = (403 * p).round();
      final h = totalMin ~/ 60;
      final m = totalMin % 60;
      final timeStr = '${h}h ${m.toString().padLeft(2, '0')}m';

      return Container(width: double.infinity, padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: AppColors.cardBackground, borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.surfaceLight.withValues(alpha: 0.5), width: 0.5)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('TOTAL SCREEN TIME', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.sectionLabel, letterSpacing: 1.2)),
          const SizedBox(height: 12),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(timeStr, style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
            Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Text('vs yesterday', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
              const SizedBox(height: 2),
              Row(children: [
                Text('+1h 12m', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.redLight)),
                Text(' ↑', style: TextStyle(fontSize: 14, color: AppColors.redLight)),
              ]),
            ]),
          ]),
          const SizedBox(height: 20),
          ..._apps.asMap().entries.map((e) {
            final i = e.key;
            final app = e.value;
            // Stagger each bar
            final delay = i * 0.1;
            final barP = Curves.easeOutCubic.transform(((p - delay) / (1.0 - delay)).clamp(0.0, 1.0));
            // Animate time counter
            final animMin = (app.minutes * barP).round();
            String animTime;
            if (animMin >= 60) {
              animTime = '${animMin ~/ 60}h ${(animMin % 60).toString().padLeft(2, '0')}m';
            } else {
              animTime = '${animMin}m';
            }
            return Padding(padding: EdgeInsets.only(bottom: i < _apps.length - 1 ? 14 : 0),
              child: _buildAnimatedRow(app.emoji, app.name, app.colors, animTime, app.barFraction * barP, app.colors[0]));
          }),
        ]),
      );
    });
  }

  Widget _buildAnimatedRow(String emoji, String name, List<Color> colors, String time, double barW, Color glowColor) {
    return Row(children: [
      Text(emoji, style: const TextStyle(fontSize: 18)),
      const SizedBox(width: 10),
      SizedBox(width: 72, child: Text(name, style: const TextStyle(fontSize: 14, color: AppColors.textPrimary, fontWeight: FontWeight.w500))),
      Expanded(child: Container(height: 10,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.surfaceLight.withValues(alpha: 0.3)),
        child: FractionallySizedBox(alignment: Alignment.centerLeft, widthFactor: barW.clamp(0.0, 1.0),
          child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
            gradient: LinearGradient(colors: colors),
            boxShadow: [BoxShadow(color: glowColor.withValues(alpha: _glowAnim.value * 0.3), blurRadius: 8, spreadRadius: 1)]))))),
      const SizedBox(width: 12),
      SizedBox(width: 54, child: Text(time, textAlign: TextAlign.right,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary))),
    ]);
  }

  Widget _buildHourlyPatternCard() {
    return Container(width: double.infinity, padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: AppColors.cardBackground, borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.surfaceLight.withValues(alpha: 0.5), width: 0.5)),
      child: Column(children: [
        SizedBox(height: 120, child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.end, children: [
          _buildBar(0.25, '8am', const Color(0xFF5A5E72), false),
          _buildBar(0.35, '10am', const Color(0xFF5A5E72), false),
          _buildBar(0.70, '12pm', const Color(0xFFE91E8C), true),
          _buildBar(0.30, '2pm', const Color(0xFF5A5E72), false),
          _buildBar(0.55, '4pm', const Color(0xFFE91E8C), true),
          _buildBar(0.30, '6pm', const Color(0xFF5A5E72), false),
          _buildBar(0.85, '8pm', const Color(0xFFFF8C42), true),
          _buildBar(0.30, '10pm', const Color(0xFF5A5E72), false),
        ])),
      ]));
  }

  Widget _buildBar(double height, String label, Color color, bool hl) {
    return Column(mainAxisAlignment: MainAxisAlignment.end, children: [
      Container(width: 28, height: 100 * height,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(6),
          gradient: hl ? LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter,
            colors: [color.withValues(alpha: 0.7), color]) : null,
          color: hl ? null : color.withValues(alpha: 0.4))),
      const SizedBox(height: 8),
      Text(label, style: TextStyle(fontSize: 10, color: hl ? color : AppColors.textMuted, fontWeight: hl ? FontWeight.w600 : FontWeight.w400)),
    ]);
  }
}

class _AppData {
  final String emoji, name, timeLabel;
  final int minutes;
  final List<Color> colors;
  final double barFraction;
  _AppData(this.emoji, this.name, this.minutes, this.colors, this.timeLabel, this.barFraction);
}
