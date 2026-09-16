import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/database/app_database.dart';
import '../data/repositories/drift_card_repository.dart';
import '../data/repositories/drift_inventory_repository.dart';
import '../data/repositories/drift_price_repository.dart';
import '../data/repositories/mock_auth_repository.dart';
import '../data/repositories/on_device_scan_repository.dart';
import '../domain/repositories/auth_repository.dart';
import '../domain/repositories/card_repository.dart';
import '../domain/repositories/inventory_repository.dart';
import '../domain/repositories/price_repository.dart';
import '../domain/repositories/scan_repository.dart';

/// Database instance provider (singleton per app lifecycle).
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

/// Card catalog repository provider.
final cardRepositoryProvider = Provider<CardRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return DriftCardRepository(db);
});

/// Inventory repository provider.
final inventoryRepositoryProvider = Provider<InventoryRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return DriftInventoryRepository(db);
});

/// Pricing repository provider.
final priceRepositoryProvider = Provider<PriceRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return DriftPriceRepository(db);
});

/// Auth repository provider (mock for prototype).
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return MockAuthRepository();
});

/// On-device scan repository provider.
final scanRepositoryProvider = Provider<ScanRepository>((ref) {
  final cardRepo = ref.watch(cardRepositoryProvider);
  final scanRepo = OnDeviceScanRepository(cardRepo);
  ref.onDispose(() => scanRepo.dispose());
  return scanRepo;
});
