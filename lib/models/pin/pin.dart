class Pin {
  int? id;
  final String value;
  final bool isActive;
  final int createdAt;

  Pin({
    this.id,
    required this.value,
    required this.isActive,
    required this.createdAt,
  });

  Pin.fromUser(String value)
      : this(
          value: value,
          isActive: true,
          createdAt: DateTime.now().millisecondsSinceEpoch,
        );

  Pin.fromDbRecord(this.id, this.value, this.isActive, this.createdAt);

  Map<String, dynamic> toDbRecord() {
    return {
      'value': value,
      'is_active': isActive,
      'created_at': createdAt,
    };
  }

  @override
  String toString() {
    return 'Pin{value: $value, isActive: $isActive, createdAt: $createdAt}';
  }
}
