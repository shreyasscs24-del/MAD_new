import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class GoalsScreen extends StatelessWidget {
  const GoalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Goals',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Set limits · Build skills',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'ACTIVE GOALS',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.sectionLabel,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 12),
            _buildGoalCard(
              emoji: '🚫',
              title: 'Limit Instagram',
              subtitle: 'Target: 45 min/day · Today: 1h 28m used',
              progress: 0.62,
              progressColor: AppColors.red,
              percentage: '62%',
              percentageColor: AppColors.red,
              statusText: 'Over limit today',
              statusColor: AppColors.red,
              statusBgColor: AppColors.red.withValues(alpha: 0.15),
              streak: '3 day streak',
            ),
            const SizedBox(height: 12),
            _buildGoalCard(
              emoji: '📖',
              title: 'Read 20 pages/day',
              subtitle: '16 pages done · 4 remaining',
              progress: 0.80,
              progressColor: AppColors.purple,
              percentage: '80%',
              percentageColor: AppColors.purple,
              statusText: 'On track',
              statusColor: AppColors.green,
              statusBgColor: AppColors.green.withValues(alpha: 0.15),
              streak: '12 day streak 🔥',
            ),
            const SizedBox(height: 12),
            _buildGoalCard(
              emoji: '💻',
              title: '1 Code Lesson/day',
              subtitle: 'Not started yet · 8h left today',
              progress: 0.0,
              progressColor: AppColors.textMuted,
              percentage: '0%',
              percentageColor: AppColors.textMuted,
              statusText: 'Not started',
              statusColor: AppColors.red,
              statusBgColor: AppColors.red.withValues(alpha: 0.15),
              streak: '0 streak',
            ),
            const SizedBox(height: 12),
            _buildGoalCard(
              emoji: '🧠',
              title: '10 Vocab Words/day',
              subtitle: '4 words done · 6 remaining',
              progress: 0.40,
              progressColor: AppColors.orange,
              percentage: '40%',
              percentageColor: AppColors.orange,
              statusText: 'In progress',
              statusColor: AppColors.orange,
              statusBgColor: AppColors.orange.withValues(alpha: 0.15),
              streak: '7 day streak',
            ),
            const SizedBox(height: 20),
            _buildAddGoalButton(),
            const SizedBox(height: 20),
            Text(
              'WEEKLY GOAL SUMMARY',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.sectionLabel,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 12),
            _buildWeeklySummary(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalCard({
    required String emoji,
    required String title,
    required String subtitle,
    required double progress,
    required Color progressColor,
    required String percentage,
    required Color percentageColor,
    required String statusText,
    required Color statusColor,
    required Color statusBgColor,
    required String streak,
  }) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 20)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              Text(
                percentage,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: percentageColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: AppColors.surfaceLight,
              valueColor: AlwaysStoppedAnimation<Color>(progressColor),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusBgColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  statusText,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
              Text(
                streak,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddGoalButton() {
    return Container(
      width: double.infinity,
      height: 52,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFE91E8C), Color(0xFFFF6EB4)],
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Center(
        child: Text(
          '+ Add New Goal',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildWeeklySummary() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
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
          Expanded(
            child: _buildSummaryItem('2/4', 'Goals Met', AppColors.green),
          ),
          Container(
            width: 1,
            height: 40,
            color: AppColors.surfaceLight,
          ),
          Expanded(
            child: _buildSummaryItem('12', 'Best Streak', AppColors.orange),
          ),
          Container(
            width: 1,
            height: 40,
            color: AppColors.surfaceLight,
          ),
          Expanded(
            child: _buildSummaryItem('55', 'Score', AppColors.purple),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String value, String label, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
