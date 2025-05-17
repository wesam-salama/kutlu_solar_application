/// Column data types supported by the table
enum ColumnType {
  text,
  number,
  boolean;

  factory ColumnType.fromString(String type) {
    return ColumnType.values.firstWhere(
      (t) => t.toString().split('.').last == type.toLowerCase(),
      orElse: () => ColumnType.text,
    );
  }
}

/// Represents one column in the dynamic table
class ColumnDef {
  final String key;
  final String title;
  final ColumnType type;

  const ColumnDef({
    required this.key,
    required this.title,
    required this.type,
  });

  Map<String, dynamic> toJson() => {
    'key': key,
    'title': title,
    'type': type.toString().split('.').last,
  };

  factory ColumnDef.fromJson(Map<String, dynamic> json) => ColumnDef(
    key: json['key'],
    title: json['title'],
    type: ColumnType.fromString(json['type']),
  );
}

/// Container for columns and rows
class TableData {
  final List<ColumnDef> columns;
  final List<Map<String, dynamic>> rows;

  TableData({required this.columns, required this.rows});

  Map<String, dynamic> toJson() => {
    'columns': columns.map((c) => c.toJson()).toList(),
    'rows': rows,
  };

  factory TableData.fromJson(Map<String, dynamic> json) => TableData(
    columns: (json['columns'] as List).map((c) => ColumnDef.fromJson(c)).toList(),
    rows: List<Map<String, dynamic>>.from(json['rows']),
  );
}