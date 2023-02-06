class Medication {
  final String id;
  final String name;
  final String description;
  final String dosageUnits;
  final String dosage;

  Medication({
    required this.id,
    required this.name,
    required this.description,
    required this.dosageUnits,
    required this.dosage,
  });
  Map toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'dosage': dosage,
        'dosageunit': dosageUnits,
      };
}
