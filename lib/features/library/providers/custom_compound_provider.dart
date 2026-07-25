import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../../../data/repositories/custom_compound_repository.dart';
import '../../../models/custom_compound.dart';

class CustomCompoundProvider extends ChangeNotifier {
  CustomCompoundProvider(this._store, {required String uid}) : _uid = uid {
    _subscribe();
  }

  final CustomCompoundStore _store;
  final _uuid = const Uuid();
  String _uid;
  StreamSubscription<List<CustomCompound>>? _subscription;

  List<CustomCompound> _all = const [];
  bool _loading = true;
  String? _error;

  List<CustomCompound> get all => List.unmodifiable(_all);
  List<CustomCompound> get active =>
      _all.where((compound) => !compound.archived).toList(growable: false);
  List<CustomCompound> get archived =>
      _all.where((compound) => compound.archived).toList(growable: false);
  bool get isLoading => _loading;
  String? get error => _error;

  void setUid(String uid) {
    if (_uid == uid) return;
    _uid = uid;
    _all = const [];
    _loading = true;
    _error = null;
    _subscribe();
  }

  void _subscribe() {
    _subscription?.cancel();
    if (_uid.isEmpty) {
      _loading = false;
      notifyListeners();
      return;
    }
    _subscription = _store
        .watchAll(_uid)
        .listen(
          (items) {
            _all = items;
            _loading = false;
            _error = null;
            notifyListeners();
          },
          onError: (Object error, StackTrace stackTrace) {
            debugPrint('CustomCompoundProvider stream failed: $error');
            _loading = false;
            _error = 'Could not load your compounds.';
            notifyListeners();
          },
        );
  }

  Future<CustomCompound> save({
    CustomCompound? existing,
    required String name,
    required double vialAmount,
    required String vialUnit,
    required String trackingUnit,
    required String route,
    String notes = '',
  }) async {
    final now = DateTime.now();
    final compound = CustomCompound(
      id: existing?.id ?? _uuid.v4(),
      name: name.trim(),
      vialAmount: vialAmount,
      vialUnit: vialUnit,
      trackingUnit: trackingUnit,
      route: route,
      notes: notes.trim(),
      archived: existing?.archived ?? false,
      createdAt: existing?.createdAt ?? now,
      updatedAt: now,
    );
    if (_uid.isNotEmpty) await _store.upsert(_uid, compound);
    return compound;
  }

  Future<void> setArchived(CustomCompound compound, bool archived) async {
    if (_uid.isEmpty) return;
    await _store.upsert(
      _uid,
      compound.copyWith(archived: archived, updatedAt: DateTime.now()),
    );
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
