import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class UsageScreen extends StatelessWidget {
  const UsageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Usage',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Today's screen time breakdown",
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 20),
            _buildTotalScreenTimeCard(),
            const SizedBox(height: 20),
            Text(
              'HOURLY PATTERN',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.sectionLabel,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 12),
            _buildHourlyPatternCard(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalScreenTimeCard() {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'TOTAL SCREEN TIME',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.sectionLabel,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                '6h 43m',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'vs yesterday',
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Text(
                        '+1h 12m',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.redLight,
                        ),
                      ),
                      Text(
                        ' ↑',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.redLight,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildAppUsageRow(
            '📷',
            'Instagram',
            88,
            const LinearGradient(
              colors: [Color(0xFFE91E8C), Color(0xFFFF6EB4)],
            ),
            '1h 28m',
            0.65,
          ),
          const SizedBox(height: 14),
          _buildAppUsageRow(
            '▶️',
            'YouTube',
            70,
            const LinearGradient(
              colors: [Color(0xFFE74C3C), Color(0xFFFF6B6B)],
            ),
            '1h 10m',
            0.52,
          ),
          const SizedBox(height: 14),
          _buildAppUsageRow(
            '🎵',
            'TikTok',
            52,
            const LinearGradient(
              colors: [Color(0xFF3498DB), Color(0xFF5DADE2)],
            ),
            '52m',
            0.32,
          ),
          const SizedBox(height: 14),
          _buildAppUsageRow(
            '💬',
            'WhatsApp',
            40,
            const LinearGradient(
              colors: [Color(0xFF00C9A7), Color(0xFF2ECC71)],
            ),
            '40m',
            0.25,
          ),
          const SizedBox(height: 14),
          _buildAppUsageRow(
            '✖️',
            'Twitter',
            28,
            const LinearGradient(
              colors: [Color(0xFF3498DB), Color(0xFF5DADE2)],
            ),
            '28m',
            0.18,
          ),
          const SizedBox(height: 14),
          _buildAppUsageRow(
            '📱',
            'Others',
            45,
            const LinearGradient(
              colors: [Color(0xFF5A5E72), Color(0xFF8E92A4)],
            ),
            '45m',
            0.15,
          ),
        ],
      ),
    );
  }

  Widget _buildAppUsageRow(
    String emoji,
    String name,
    int minutes,
    LinearGradient gradient,
    String timeLabel,
    double barFraction,
  ) {
    return Row(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 18)),
        const SizedBox(width: 10),
        SizedBox(
          width: 72,
          child: Text(
            name,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: AppColors.surfaceLight.withValues(alpha: 0.3),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: barFraction,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  gradient: gradient,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        SizedBox(
          width: 48,
          child: Text(
            timeLabel,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHourlyPatternCard() {
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
          SizedBox(
            height: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildBar(0.25, '8am', const Color(0xFF5A5E72), false),
                _buildBar(0.35, '10am', const Color(0xFF5A5E72), false),
                _buildBar(0.70, '12pm', const Color(0xFFE91E8C), true),
                _buildBar(0.30, '2pm', const Color(0xFF5A5E72), false),
                _buildBar(0.55, '4pm', const Color(0xFFE91E8C), true),
                _buildBar(0.30, '6pm', const Color(0xFF5A5E72), false),
                _buildBar(0.85, '8pm', const Color(0xFFFF8C42), true),
                _buildBar(0.30, '10pm', const Color(0xFF5A5E72), false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBar(double height, String label, Color color, bool highlight) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 28,
          height: 100 * height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            gradient: highlight
                ? LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      color.withValues(alpha: 0.7),
                      color,
                    ],
                  )
                : null,
            color: highlight ? null : color.withValues(alpha: 0.4),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: highlight ? color : AppColors.textMuted,
            fontWeight: highlight ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
