import 'package:flutter/material.dart';

/// Widget that displays animated statistics indicators with icons
/// Shows key metrics like happy travelers, destinations, and years of experience
class StatsIndicator extends StatefulWidget {
  const StatsIndicator({super.key});

  @override
  State<StatsIndicator> createState() => _StatsIndicatorState();
}

class _StatsIndicatorState extends State<StatsIndicator> {
  // Animation values
  int _displayedTravelers = 0;
  int _displayedDestinations = 0;
  int _displayedYears = 0;

  // Target values
  final int _targetTravelers = 500;
  final int _targetDestinations = 10;
  final int _targetYears = 3;

  @override
  void initState() {
    super.initState();
    _animateCounters();
  }

  /// Animate all counters from 0 to their target values
  void _animateCounters() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted) return;

      const totalDuration = Duration(milliseconds: 2000);
      const steps = 50;
      final stepDuration = totalDuration.inMilliseconds ~/ steps;

      for (int i = 0; i < steps; i++) {
        Future.delayed(Duration(milliseconds: stepDuration * i), () {
          if (!mounted) return;
          setState(() {
            // Animate travelers count
            _displayedTravelers = ((i + 1) / steps * _targetTravelers).round();
            if (_displayedTravelers > _targetTravelers) {
              _displayedTravelers = _targetTravelers;
            }

            // Animate destinations count
            _displayedDestinations =
                ((i + 1) / steps * _targetDestinations).round();
            if (_displayedDestinations > _targetDestinations) {
              _displayedDestinations = _targetDestinations;
            }

            // Animate years count
            _displayedYears = ((i + 1) / steps * _targetYears).round();
            if (_displayedYears > _targetYears) {
              _displayedYears = _targetYears;
            }
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 1500),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 20 : 40,
          vertical: isMobile ? 20 : 30,
        ),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFFFFDC00).withOpacity(0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child:
            isMobile
                ? Column(
                  children: [
                    _buildStatItem(
                      icon: Icons.person_outline,
                      value: _displayedTravelers,
                      label: 'Viajeros Felices',
                      isMobile: true,
                    ),
                    const SizedBox(height: 20),
                    _buildStatItem(
                      icon: Icons.location_on_outlined,
                      value: _displayedDestinations,
                      label: 'Destinos',
                      isMobile: true,
                    ),
                    const SizedBox(height: 20),
                    _buildStatItem(
                      icon: Icons.workspace_premium_outlined,
                      value: _displayedYears,
                      label: 'Años de Experiencia',
                      isMobile: true,
                    ),
                  ],
                )
                : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildStatItem(
                      icon: Icons.person_outline,
                      value: _displayedTravelers,
                      label: 'Viajeros Felices',
                    ),
                    _buildDivider(),
                    _buildStatItem(
                      icon: Icons.location_on_outlined,
                      value: _displayedDestinations,
                      label: 'Destinos',
                    ),
                    _buildDivider(),
                    _buildStatItem(
                      icon: Icons.workspace_premium_outlined,
                      value: _displayedYears,
                      label: 'Años de Experiencia',
                    ),
                  ],
                ),
      ),
    );
  }

  /// Build a single statistic item with icon, value, and label
  Widget _buildStatItem({
    required IconData icon,
    required int value,
    required String label,
    bool isMobile = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 0 : 25),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon with background
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFFDC00).withOpacity(0.2),
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFFFDC00), width: 2),
            ),
            child: Icon(
              icon,
              color: const Color(0xFFFFDC00),
              size: isMobile ? 28 : 32,
            ),
          ),
          const SizedBox(height: 12),
          // Animated value
          Text(
            '$value+',
            style: TextStyle(
              fontSize: isMobile ? 32 : 40,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  offset: const Offset(2, 2),
                  blurRadius: 4,
                  color: Colors.black.withOpacity(0.5),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          // Label
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isMobile ? 14 : 16,
              color: Colors.white.withOpacity(0.9),
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
              shadows: [
                Shadow(
                  offset: const Offset(1, 1),
                  blurRadius: 2,
                  color: Colors.black.withOpacity(0.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Build a vertical divider between stats
  Widget _buildDivider() {
    return Container(
      height: 80,
      width: 1,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            const Color(0xFFFFDC00).withOpacity(0.3),
            Colors.transparent,
          ],
        ),
      ),
    );
  }
}
