import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'models/column_def.dart';
import 'widgets/table_styles.dart';  // Import the models

// Keep only the styles in this file


class DynamicTablesBuilder extends StatefulWidget {
  final String productId;
  final TableData? initialData;
  final Function(TableData) onSave;  // Add this line

  const DynamicTablesBuilder({
    super.key,
    required this.productId,
    required this.onSave,  // Add this line
    this.initialData,
  });

  @override
  DynamicTablesBuilderState createState() => DynamicTablesBuilderState();
}

class DynamicTablesBuilderState extends State<DynamicTablesBuilder> {
  late List<ColumnDef> _columns;
  late List<Map<String, dynamic>> _rows;
  int _colCounter = 1;
  int _rowCounter = 1;  // Add this line for unique row keys

  @override
  void initState() {
    super.initState();
    // Initialize from passed data or empty
    // if (widget.initialData != null) {
    //   _columns = widget.initialData!.columns;
    //   _rows = widget.initialData!.rows;
    //   _colCounter = _columns.length + 1;
    // } else {
    //   _columns = [];
    //   _rows = [];
    // }

    // Uncomment below to use dummy data for testing
    _testData();
  }


  _testData(){
    _columns = [
    const ColumnDef(key: 'model_no', title: 'Model No', type: ColumnType.text),
    const ColumnDef(key: 'led_power', title: 'Led Power', type: ColumnType.text),
    const ColumnDef(key: 'lumen_output', title: 'Lumen Output', type: ColumnType.text),
    const ColumnDef(key: 'solar_panel', title: 'Mono Solar Panel', type: ColumnType.text),
    const ColumnDef(key: 'controller_sensor', title: 'Controller & Sensor', type: ColumnType.text),
    const ColumnDef(key: 'battery', title: 'LiFePO4 Battery', type: ColumnType.text),
    const ColumnDef(key: 'mounting_height', title: 'Mounting Height', type: ColumnType.text),
    const ColumnDef(key: 'mounting_distance', title: 'Mounting Distance', type: ColumnType.text),
  ];
    _rows = [
      {
        'model_no': 'TH-60',
        'led_power': '60W（Bridgelux 5050)',
        'lumen_output': '9600lm-10800lm',
        'solar_panel': '90W 18V',
        'controller_sensor': 'MPPT & Microwave',
        'battery': '36ah 12.8v',
        'mounting_height': '6-7m',
        'mounting_distance': '16-19m',
      },
      {
        'model_no': 'TH-80',
        'led_power': '80W（Bridgelux 5050)',
        'lumen_output': '12800lm-14400lm',
        'solar_panel': '120W 18V',
        'controller_sensor': 'MPPT & Microwave',
        'battery': '36ah 12.8v',
        'mounting_height': '7-8m',
        'mounting_distance': '19-22m',
      },
      {
        'model_no': 'TH-100',
        'led_power': '100W（Bridgelux 5050)',
        'lumen_output': '16000lm-18000lm',
        'solar_panel': '150W 18V',
        'controller_sensor': 'MPPT & Microwave',
        'battery': '36ah 12.8v',
        'mounting_height': '8-9m',
        'mounting_distance': '22-25m',
      },
      {
        'model_no': 'TH-120',
        'led_power': '120W（Bridgelux 5050)',
        'lumen_output': '19200lm-21600lm',
        'solar_panel': '180W 18V',
        'controller_sensor': 'MPPT & Microwave',
        'battery': '36ah 12.8v',
        'mounting_height': '9-10m',
        'mounting_distance': '25-28m',
      },
      {
        'model_no': 'TH-150',
        'led_power': '150W（Bridgelux 5050)',
        'lumen_output': '24000lm-27000lm',
        'solar_panel': '210W 18V',
        'controller_sensor': 'MPPT & Microwave',
        'battery': '36ah 12.8v',
        'mounting_height': '10-11m',
        'mounting_distance': '28-31m',
      },
      {
        'model_no': 'TH-200',
        'led_power': '200W（Bridgelux 5050)',
        'lumen_output': '32000lm-36000lm',
        'solar_panel': '270W 18V',
        'controller_sensor': 'MPPT & Microwave',
        'battery': '36ah 12.8v',
        'mounting_height': '11-12m',
        'mounting_distance': '31-35m',
      },
      {
        'model_no': 'TH-250',
        'led_power': '250W（Bridgelux 5050)',
        'lumen_output': '40000lm-45000lm',
        'solar_panel': '330W 18V',
        'controller_sensor': 'MPPT & Microwave',
        'battery': '36ah 12.8v',
        'mounting_height': '12-13m',
        'mounting_distance': '35-39m',
      },
      {
        'model_no': 'TH-60',
        'led_power': '60W（Bridgelux 5050)',
        'lumen_output': '9600lm-10800lm',
        'solar_panel': '90W 18V',
        'controller_sensor': 'MPPT & Microwave',
        'battery': '36ah 12.8v',
        'mounting_height': '6-7m',
        'mounting_distance': '16-19m',
      },
      {
        'model_no': 'TH-80',
        'led_power': '80W（Bridgelux 5050)',
        'lumen_output': '12800lm-14400lm',
        'solar_panel': '120W 18V',
        'controller_sensor': 'MPPT & Microwave',
        'battery': '36ah 12.8v',
        'mounting_height': '7-8m',
        'mounting_distance': '19-22m',
      },
      {
        'model_no': 'TH-100',
        'led_power': '100W（Bridgelux 5050)',
        'lumen_output': '16000lm-18000lm',
        'solar_panel': '150W 18V',
        'controller_sensor': 'MPPT & Microwave',
        'battery': '36ah 12.8v',
        'mounting_height': '8-9m',
        'mounting_distance': '22-25m',
      },
      {
        'model_no': 'TH-120',
        'led_power': '120W（Bridgelux 5050)',
        'lumen_output': '19200lm-21600lm',
        'solar_panel': '180W 18V',
        'controller_sensor': 'MPPT & Microwave',
        'battery': '36ah 12.8v',
        'mounting_height': '9-10m',
        'mounting_distance': '25-28m',
      },
      {
        'model_no': 'TH-150',
        'led_power': '150W（Bridgelux 5050)',
        'lumen_output': '24000lm-27000lm',
        'solar_panel': '210W 18V',
        'controller_sensor': 'MPPT & Microwave',
        'battery': '36ah 12.8v',
        'mounting_height': '10-11m',
        'mounting_distance': '28-31m',
      },
      {
        'model_no': 'TH-200',
        'led_power': '200W（Bridgelux 5050)',
        'lumen_output': '32000lm-36000lm',
        'solar_panel': '270W 18V',
        'controller_sensor': 'MPPT & Microwave',
        'battery': '36ah 12.8v',
        'mounting_height': '11-12m',
        'mounting_distance': '31-35m',
      },
      {
        'model_no': 'TH-250',
        'led_power': '250W（Bridgelux 5050)',
        'lumen_output': '40000lm-45000lm',
        'solar_panel': '330W 18V',
        'controller_sensor': 'MPPT & Microwave',
        'battery': '36ah 12.8v',
        'mounting_height': '12-13m',
        'mounting_distance': '35-39m',
      },
      {
        'model_no': 'TH-60',
        'led_power': '60W（Bridgelux 5050)',
        'lumen_output': '9600lm-10800lm',
        'solar_panel': '90W 18V',
        'controller_sensor': 'MPPT & Microwave',
        'battery': '36ah 12.8v',
        'mounting_height': '6-7m',
        'mounting_distance': '16-19m',
      },
      {
        'model_no': 'TH-80',
        'led_power': '80W（Bridgelux 5050)',
        'lumen_output': '12800lm-14400lm',
        'solar_panel': '120W 18V',
        'controller_sensor': 'MPPT & Microwave',
        'battery': '36ah 12.8v',
        'mounting_height': '7-8m',
        'mounting_distance': '19-22m',
      },
      {
        'model_no': 'TH-100',
        'led_power': '100W（Bridgelux 5050)',
        'lumen_output': '16000lm-18000lm',
        'solar_panel': '150W 18V',
        'controller_sensor': 'MPPT & Microwave',
        'battery': '36ah 12.8v',
        'mounting_height': '8-9m',
        'mounting_distance': '22-25m',
      },
      {
        'model_no': 'TH-120',
        'led_power': '120W（Bridgelux 5050)',
        'lumen_output': '19200lm-21600lm',
        'solar_panel': '180W 18V',
        'controller_sensor': 'MPPT & Microwave',
        'battery': '36ah 12.8v',
        'mounting_height': '9-10m',
        'mounting_distance': '25-28m',
      },
      {
        'model_no': 'TH-150',
        'led_power': '150W（Bridgelux 5050)',
        'lumen_output': '24000lm-27000lm',
        'solar_panel': '210W 18V',
        'controller_sensor': 'MPPT & Microwave',
        'battery': '36ah 12.8v',
        'mounting_height': '10-11m',
        'mounting_distance': '28-31m',
      },
      {
        'model_no': 'TH-200',
        'led_power': '200W（Bridgelux 5050)',
        'lumen_output': '32000lm-36000lm',
        'solar_panel': '270W 18V',
        'controller_sensor': 'MPPT & Microwave',
        'battery': '36ah 12.8v',
        'mounting_height': '11-12m',
        'mounting_distance': '31-35m',
      },
      {
        'model_no': 'TH-250',
        'led_power': '250W（Bridgelux 5050)',
        'lumen_output': '40000lm-45000lm',
        'solar_panel': '330W 18V',
        'controller_sensor': 'MPPT & Microwave',
        'battery': '36ah 12.8v',
        'mounting_height': '12-13m',
        'mounting_distance': '35-39m',
      },
      
    ].map((row) {
      final rowData = Map<String, dynamic>.from(row);
      rowData['rowKey'] = 'row${_rowCounter++}';  // Add unique key
      return rowData;
    }).toList();

  }
  // 4) TABLE ACTIONS

  /// Show dialog to add a new column with validation
  Future<void> _showColumnDialog() async {
    String title = '';
    ColumnType type = ColumnType.text; // Changed to use enum

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add Column'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Column Title',
                hintText: 'Enter column name',
              ),
              onChanged: (v) => title = v.trim(),
            ),
            SizedBox(height: 10.h),
            DropdownButtonFormField<ColumnType>(
              value: type,
              items: ColumnType.values.map((t) => DropdownMenuItem(
                value: t,
                child: Text(t.toString().split('.').last.toUpperCase()),
              )).toList(),
              onChanged: (v) => type = v!,
              decoration: const InputDecoration(
                labelText: 'Data Type',
                hintText: 'Select the type of data',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (title.isEmpty) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.red,
                    content: Text('Column title cannot be empty!',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
                return;
              }
              if (_columns.any((col) => col.title.toLowerCase() == title.toLowerCase())) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.red,
                    content: Text('Column title already exists!',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
                return;
              }
              final key = 'col${_colCounter++}';
              setState(() {
                _columns.add(ColumnDef(key: key, title: title, type: type));
                for (var row in _rows) {
                  row[key] = '';
                }
              });
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  /// Add a new column, show error if not allowed
  void _onAddColumn() {
    _showColumnDialog();
  }

  /// Delete a column and remove its data from all rows
  void _onDeleteColumn(int index) {
    final key = _columns[index].key;
    setState(() {
      _columns.removeAt(index);
      for (var row in _rows) {
        row.remove(key);
      }
    });
  }

  /// Add a new row (empty values for each column), show error if not allowed
  void _onAddRow() {
    if (_columns.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Add at least one column first!')),
      );
      return;
    }
    setState(() {
      _rows.add({for (var col in _columns) col.key: '', 'rowKey': 'row${_rowCounter++}'});
    });
  }

  /// Save table data (example: show snackbar, real save is commented)
  Future<void> _onSave() async {
    final data = TableData(columns: _columns, rows: _rows);
    widget.onSave(data);  // Call the callback with table data
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Table data saved!')));
  }

  /// Widget for Add Column and Add Row buttons (used in header)
  Widget _buildAddColumnRowButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.view_column_sharp, size: 8.sp, color: Colors.black),
          tooltip: 'Add Column',
          onPressed: _onAddColumn,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        IconButton(
          icon: Icon(Icons.table_rows_sharp, size: 8.sp, color: Colors.black),
          tooltip: 'Add Row',
          onPressed: _onAddRow,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ],
    );
  }

  // 5) BUILD TABLE UI

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Action Bar (top of table)
        Row(
          children: [
            // const Spacer(),  
            IconButton(icon: const Icon(Icons.save), onPressed: _onSave),
          ],
        ),
        SizedBox(height: 8.h),
        // Table Area
        Expanded(
          child: _columns.isEmpty
              // If no columns, show only the add buttons in the header
              ? SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Table(
                    border: TableStyles.tableBorder,
                    defaultColumnWidth: FixedColumnWidth(TableStyles.cellWidth),
                    children: [
                      TableRow(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        children: [
                          _buildAddColumnRowButtons(),
                        ],
                      ),
                    ],
                  ),
                )
              // If columns exist, show full table
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Table(
                    border: TableStyles.tableBorder,
                    defaultColumnWidth: FixedColumnWidth(TableStyles.cellWidth),
                    children: [
                      // HEADER ROW
                      TableRow(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        children: [
                          // Column headers with delete icon
                          for (int c = 0; c < _columns.length; c++)
                            Container(
                              padding: TableStyles.headerPadding,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(_columns[c].title,
                                        style: TableStyles.headerTextStyle),
                                  ),
                                  GestureDetector(
                                    onTap: () => _onDeleteColumn(c),
                                    child: Icon(Icons.close, size: 6.sp),
                                  ),
                                ],
                              ),
                            ),
                          // Add Column/Row buttons at end of header
                          _buildAddColumnRowButtons(),
                        ],
                      ),
                      // DATA ROWS
                      ..._rows.asMap().entries.map((entry) {
                        final r = entry.key;
                        final row = entry.value;
                        return TableRow(
                          key: ValueKey(row['rowKey']),  // Use the unique row key
                          decoration: BoxDecoration(
                            color: r.isOdd ? Colors.grey[50] : Colors.white,
                          ),
                          children: [
                            for (var col in _columns)
                              Padding(
                                padding: TableStyles.cellPadding,
                                child: TextFormField(
                                  key: ValueKey('${row['rowKey']}_${col.key}'),
                                  initialValue: row[col.key]?.toString() ?? '',
                                  style: TableStyles.cellTextStyle,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    isDense: true,
                                  ),
                                  onChanged: (v) => setState(() => row[col.key] = v),
                                ),
                              ),
                            Container(
                              padding: TableStyles.cellPadding,
                              alignment: Alignment.center,
                              child: IconButton(
                                key: ValueKey('delete_${row['rowKey']}'),
                                icon: Icon(Icons.delete, color: Colors.red, size: 6.sp),
                                onPressed: () => setState(() {
                                  final indexToRemove = _rows.indexWhere((r) => r['rowKey'] == row['rowKey']);
                                  if (indexToRemove != -1) {
                                    _rows.removeAt(indexToRemove);
                                  }
                                }),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                              ),
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
        ),
      ],
    );
  }
}
