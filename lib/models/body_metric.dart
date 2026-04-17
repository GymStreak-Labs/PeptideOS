import 'package:isar/isar.dart';

part 'body_metric.g.dart';

/// A body measurement log (weight, body fat %, circumference measurements).
@collection
class BodyMetric {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index()
  late DateTime date;

  double? weightKg;
  double? bodyFatPct;

  /// Optional circumference measurements, keyed by site (`waist`, `chest`,
  /// `arm`, etc.). Values are always centimetres — UI converts when needed.
  List<MeasurementEntry> measurements = <MeasurementEntry>[];

  String notes = '';

  BodyMetric();
}

@embedded
class MeasurementEntry {
  String key = '';
  double valueCm = 0;

  MeasurementEntry();
}
