import 'package:equatable/equatable.dart';

enum IdType {
  aadhaar('Aadhaar'),
  pan('PAN'),
  voter('Voter'),
  drivingLicense('DL');

  const IdType(this.label);
  final String label;
}

class DetectedId extends Equatable {
  const DetectedId(this.type, this.value);

  final IdType type;
  final String value;

  @override
  List<Object> get props => [type, value];

  @override
  String toString() => '${type.label}: $value';
}
