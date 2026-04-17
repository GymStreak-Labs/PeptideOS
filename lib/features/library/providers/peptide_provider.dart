import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../data/repositories/peptide_library_repository.dart';
import '../../../models/peptide.dart';

/// Reactive view of the global peptide library (`peptideLibrary/*`).
///
/// Library data is read-only per user — seeding happens at app bootstrap.
/// The provider subscribes to a Firestore stream so offline-cached data
/// renders instantly while remote updates arrive asynchronously.
class PeptideProvider extends ChangeNotifier {
  PeptideProvider(this._repo) {
    _subscribe();
  }

  final PeptideLibraryRepository _repo;
  StreamSubscription<List<Peptide>>? _sub;

  List<Peptide> _all = <Peptide>[];
  bool _loading = true;
  String? _error;

  List<Peptide> get all => _all;
  bool get isLoading => _loading;
  String? get error => _error;

  void _subscribe() {
    _sub?.cancel();
    _sub = _repo.watchAll().listen(
      (items) {
        _all = items;
        _loading = false;
        _error = null;
        notifyListeners();
      },
      onError: (Object e, StackTrace st) {
        debugPrint('PeptideProvider stream failed: $e');
        _loading = false;
        _error = 'Failed to load peptide library.';
        notifyListeners();
      },
    );
  }

  Future<void> refresh() async {
    try {
      _all = await _repo.fetchAllOnce();
      _loading = false;
      _error = null;
    } catch (e) {
      debugPrint('PeptideProvider refresh failed: $e');
      _error = 'Failed to load peptide library.';
    }
    notifyListeners();
  }

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

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}
