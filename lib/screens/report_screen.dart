import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../theme/app_theme.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Report',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Weekly & monthly summary',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'THIS WEEK VS LAST WEEK',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.sectionLabel,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 12),
            _buildWeeklyCard(),
            const SizedBox(height: 20),
            Text(
              'THIS MONTH VS LAST MONTH',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.sectionLabel,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 12),
            _buildMonthlyCard(),
            const SizedBox(height: 20),
            Text(
              'AI INSIGHTS',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.sectionLabel,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 12),
            _buildAIInsightsCard(),
            const SizedBox(height: 20),
            Text(
              '7-DAY TREND',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.sectionLabel,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 12),
            _buildTrendCard(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildWeeklyCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.surfaceLight.withValues(alpha: 0.5),
          width: 0.5,
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 110,
            height: 110,
            child: CustomPaint(
              painter: DonutChartPainter(
                segments: [
                  DonutSegment(0.75, const Color(0xFFE91E8C)),
                  DonutSegment(0.13, const Color(0xFF2ECC71)),
                  DonutSegment(0.12, const Color(0xFF3498DB)),
                ],
                centerText: '75%',
              ),
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLegendItem(const Color(0xFFE91E8C), 'Social', '29h 43m'),
                const SizedBox(height: 10),
                _buildLegendItem(
                    const Color(0xFF2ECC71), 'Productive', '5h 21m'),
                const SizedBox(height: 10),
                _buildLegendItem(const Color(0xFF3498DB), 'Other', '3h 40m'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthlyCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.surfaceLight.withValues(alpha: 0.5),
          width: 0.5,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 110,
                height: 110,
                child: CustomPaint(
                  painter: DonutChartPainter(
                    segments: [
                      DonutSegment(0.70, const Color(0xFFFF8C42)),
                      DonutSegment(0.15, const Color(0xFF2ECC71)),
                      DonutSegment(0.15, const Color(0xFF3498DB)),
                    ],
                    centerText: '70%',
                  ),
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLegendItem(
                        const Color(0xFFFF8C42), 'Social', '118h 32m'),
                    const SizedBox(height: 10),
                    _buildLegendItem(
                        const Color(0xFF2ECC71), 'Productive', '24h 15m'),
                    const SizedBox(height: 10),
                    _buildLegendItem(
                        const Color(0xFF3498DB), 'Other', '16h 10m'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStatChip(
                    '−8h 20m', 'vs last month', AppColors.green),
              ),
              Expanded(
                child: _buildStatChip(
                    '+4h 30m', 'more productive', AppColors.green),
              ),
              Expanded(
                child: _buildStatChip('↑ 12%', 'score improved', AppColors.green),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label, String value) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatChip(String value, String label, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: AppColors.textMuted,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildAIInsightsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.surfaceLight.withValues(alpha: 0.5),
          width: 0.5,
        ),
      ),
      child: Column(
        children: [
          _buildInsightRow(
            '🔴',
            'Peak usage: 8–10pm',
            'You scroll most before sleep. This disrupts your sleep cycle significantly.',
          ),
          const Divider(color: AppColors.surfaceLight, height: 24),
          _buildInsightRow(
            '⚡',
            'Monday is worst day',
            '7h 20m avg — 2x higher than Friday. Weekend mindset carries over.',
          ),
          const Divider(color: AppColors.surfaceLight, height: 24),
          _buildInsightRow(
            '✅',
            'Tuesday improving',
            "Down 45m vs last Tuesday. Keep it up — you're building the habit!",
          ),
        ],
      ),
    );
  }

  Widget _buildInsightRow(String emoji, String title, String subtitle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: AppColors.surfaceLight,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(emoji, style: const TextStyle(fontSize: 18)),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTrendCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.surfaceLight.withValues(alpha: 0.5),
          width: 0.5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildTrendBlock('Mon', const Color(0xFFE91E8C), 0.7),
          _buildTrendBlock('Tue', const Color(0xFFB07FEB), 0.5),
          _buildTrendBlock('Wed', const Color(0xFFE91E8C), 0.6),
          _buildTrendBlock('Thu', const Color(0xFFFF6EB4), 0.8),
          _buildTrendBlock('Fri', const Color(0xFF5A5E72), 0.3),
          _buildTrendBlock('Sat', const Color(0xFF5A5E72), 0.35),
          _buildTrendBlock('Sun', const Color(0xFF3498DB), 0.65),
        ],
      ),
    );
  }

  Widget _buildTrendBlock(String day, Color color, double intensity) {
    return Column(
      children: [
        Container(
          width: 34,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: color.withValues(alpha: 0.3 + intensity * 0.7),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          day,
          style: TextStyle(
            fontSize: 11,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// Custom donut chart painter
class DonutSegment {
  final double value;
  final Color color;
  DonutSegment(this.value, this.color);
}

class DonutChartPainter extends CustomPainter {
  final List<DonutSegment> segments;
  final String centerText;

  DonutChartPainter({required this.segments, required this.centerText});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 8;
    const strokeWidth = 14.0;
    const gapAngle = 0.04; // Small gap between segments

    double startAngle = -math.pi / 2;

    for (final segment in segments) {
      final sweepAngle = segment.value * 2 * math.pi - gapAngle;
      final paint = Paint()
        ..color = segment.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );

      startAngle += segment.value * 2 * math.pi;
    }

    // Draw center text
    final textPainter = TextPainter(
      text: TextSpan(
        text: centerText,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        center.dx - textPainter.width / 2,
        center.dy - textPainter.height / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
