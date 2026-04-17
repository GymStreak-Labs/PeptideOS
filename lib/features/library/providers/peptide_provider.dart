import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';

import '../../../models/peptide.dart';
import '../../../services/database_service.dart';

/// Read-only view of the seeded peptide library with search + filter helpers.
class PeptideProvider extends ChangeNotifier {
  PeptideProvider(this._db) {
    _load();
  }

  final DatabaseService _db;

  List<Peptide> _all = <Peptide>[];
  bool _loading = true;
  String? _error;

  List<Peptide> get all => _all;
  bool get isLoading => _loading;
  String? get error => _error;

  Future<void> _load() async {
    try {
      _all = await _db.peptides.filter().nameIsNotEmpty().sortByName().findAll();
      _loading = false;
      _error = null;
    } catch (e, st) {
      debugPrint('PeptideProvider load failed: $e\n$st');
      _loading = false;
      _error = 'Failed to load peptide library.';
    }
    notifyListeners();
  }

  Future<void> refresh() => _load();

  Peptide? findBySlug(String slug) {
    for (final p in _all) {
      if (p.slug == slug) return p;
    }
    return null;
  }

  /// Case-insensitive search + optional category filter.
  List<Peptide> search({String query = '', PeptideCategory? category}) {
    final q = query.trim().toLowerCase();
    return _all.where((p) {
      if (category != null && p.category != category) return false;
      if (q.isEmpty) return true;
      return p.name.toLowerCase().contains(q) ||
          p.description.toLowerCase().contains(q) ||
          p.category.label.toLowerCase().contains(q);
    }).toList();
  }
}
