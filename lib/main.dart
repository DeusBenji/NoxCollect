import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/providers.dart';
import 'data/seeder/dev_card_seeder.dart';
import 'features/home/screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: NoxCollectApp()));
}

class NoxCollectApp extends StatelessWidget {
  const NoxCollectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NoxCollect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.amber,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const _AppBootstrap(),
    );
  }
}

/// Bootstrap widget that seeds the dev database before showing the scanner.
class _AppBootstrap extends ConsumerStatefulWidget {
  const _AppBootstrap();

  @override
  ConsumerState<_AppBootstrap> createState() => _AppBootstrapState();
}

class _AppBootstrapState extends ConsumerState<_AppBootstrap> {
  bool _isSeeding = true;

  @override
  void initState() {
    super.initState();
    _runDevSeeder();
  }

  Future<void> _runDevSeeder() async {
    try {
      final cardRepo = ref.read(cardRepositoryProvider);
      final seeder = DevCardSeeder(cardRepo);
      final count = await seeder.seedIfEmpty();
      if (mounted) {
        setState(() {
          _isSeeding = false;
        });
        if (count > 0) {
          debugPrint('DevCardSeeder: Inserted $count test cards into SQLite.');
        } else {
          debugPrint('DevCardSeeder: Database already seeded, skipping.');
        }
      }
    } catch (e) {
      debugPrint('DevCardSeeder error: $e');
      if (mounted) {
        setState(() => _isSeeding = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isSeeding) {
      return const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Preparing test database...'),
            ],
          ),
        ),
      );
    }

    return const HomeScreen();
  }
}
