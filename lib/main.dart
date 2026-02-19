import 'package:flutter/material.dart';

void main() {
  runApp(const RiskClarityApp());
}

class RiskClarityApp extends StatelessWidget {
  const RiskClarityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Risk Clarity',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1A237E),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            letterSpacing: -1.0,
          ),
          bodyLarge: TextStyle(fontSize: 18),
        ),
      ),
      home: const RiskComparisonScreen(),
    );
  }
}

class RiskItem {
  final String name;
  final double score; // 0 to 100
  final String description;
  final IconData icon;

  const RiskItem({
    required this.name,
    required this.score,
    required this.description,
    required this.icon,
  });
}

class RiskComparisonScreen extends StatefulWidget {
  const RiskComparisonScreen({super.key});

  @override
  State<RiskComparisonScreen> createState() => _RiskComparisonScreenState();
}

class _RiskComparisonScreenState extends State<RiskComparisonScreen> {
  final List<RiskItem> _availableRisks = const [
    RiskItem(
      name: 'Air Pollution',
      score: 65,
      description: 'Long-term exposure to PM2.5 particles.',
      icon: Icons.air,
    ),
    RiskItem(
      name: 'Microplastics',
      score: 40,
      description: 'Ingestion through water and food sources.',
      icon: Icons.biotech,
    ),
    RiskItem(
      name: 'Sedentary Lifestyle',
      score: 80,
      description: 'Sitting more than 8 hours daily without exercise.',
      icon: Icons.chair,
    ),
    RiskItem(
      name: 'High Sodium Intake',
      score: 55,
      description: 'Consuming over 2300mg of sodium per day.',
      icon: Icons.set_meal,
    ),
    RiskItem(
      name: 'Sleep Deprivation',
      score: 75,
      description: 'Consistently getting less than 6 hours of sleep.',
      icon: Icons.bedtime,
    ),
    RiskItem(
      name: 'Ultra-processed Foods',
      score: 70,
      description: 'High intake of additives and refined sugars.',
      icon: Icons.fastfood,
    ),
  ];

  RiskItem? _selectedLeft;
  RiskItem? _selectedRight;

  @override
  void initState() {
    super.initState();
    _selectedLeft = _availableRisks[0];
    _selectedRight = _availableRisks[1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text(
                'Risk Clarity',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Compare life choices side-by-side.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
              const SizedBox(height: 48),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: _RiskSelector(
                        item: _selectedLeft!,
                        onChanged: (item) => setState(() => _selectedLeft = item),
                        items: _availableRisks,
                        label: 'BASE',
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      width: 1,
                      color: Theme.of(context).colorScheme.outlineVariant,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _RiskSelector(
                        item: _selectedRight!,
                        onChanged: (item) => setState(() => _selectedRight = item),
                        items: _availableRisks,
                        label: 'COMPARE',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),
              _ResultPanel(left: _selectedLeft!, right: _selectedRight!),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class _RiskSelector extends StatelessWidget {
  final RiskItem item;
  final ValueChanged<RiskItem> onChanged;
  final List<RiskItem> items;
  final String label;

  const _RiskSelector({
    required this.item,
    required this.onChanged,
    required this.items,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),
        PopupMenuButton<RiskItem>(
          initialValue: item,
          onSelected: onChanged,
          itemBuilder: (context) => items
              .map((i) => PopupMenuItem(value: i, child: Text(i.name)))
              .toList(),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Icon(item.icon, size: 48, color: Theme.of(context).colorScheme.primary),
                const SizedBox(height: 16),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  item.description,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ResultPanel extends StatelessWidget {
  final RiskItem left;
  final RiskItem right;

  const _ResultPanel({required this.left, required this.right});

  @override
  Widget build(BuildContext context) {
    final double diff = (right.score - left.score).abs();
    final bool rightIsHigher = right.score > left.score;
    final String relation = rightIsHigher ? 'higher' : 'lower';
    final Color resultColor = rightIsHigher 
        ? Colors.orangeAccent 
        : Colors.tealAccent.shade700;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Text(
            'THE VERDICT',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
              children: [
                TextSpan(text: right.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                const TextSpan(text: ' has a '),
                TextSpan(
                  text: '${diff.toStringAsFixed(0)}% $relation',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: resultColor,
                  ),
                ),
                const TextSpan(text: ' impact on overall health markers compared to '),
                TextSpan(text: left.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                const TextSpan(text: '.'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
