# How to dynamically change row colors based on the theme in Flutter DataTable (SfDataGrid)?.

In this article, we will show you how to dynamically change row colors based on the theme in [Flutter DataTable](https://www.syncfusion.com/flutter-widgets/flutter-datagrid).

Initialize the [SfDataGrid](https://pub.dev/documentation/syncfusion_flutter_datagrid/latest/datagrid/SfDataGrid-class.html) widget with all the necessary properties. To achieve this, set the appropriate [context](https://api.flutter.dev/flutter/widgets/BuildContext-class.html) to the `DataGridSource.context` property and call [notifyListeners](https://pub.dev/documentation/syncfusion_flutter_datagrid/latest/datagrid/DataGridSourceChangeNotifier/notifyListeners.html) from the [DataGridSource](https://pub.dev/documentation/syncfusion_flutter_datagrid/latest/datagrid/DataGridSource-class.html) when the theme is changed.

```dart
Brightness brightness = Brightness.light;

@override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(brightness: brightness),
      child: Scaffold(
          appBar: AppBar(title: const Text('Syncfusion Flutter DataGrid')),
          body: Builder(builder: (context) {
            return Column(
              children: [
                ElevatedButton(
                    onPressed: (() {
                      setState(() {
                        if (brightness == Brightness.dark) {
                          brightness = Brightness.light;
                          _employeeDataSource.context = context;
                        } else {
                          brightness = Brightness.dark;
                          _employeeDataSource.context = context;
                        }
                      });
                      _employeeDataSource.updateDataGrid();
                    }),
                    child: const Text('Change Theme')),
                const Padding(padding: EdgeInsets.all(5)),
                Expanded(
                  child: SfDataGrid(
                    source: _employeeDataSource,
                    columns: getColumns,
                    columnWidthMode: ColumnWidthMode.fill,
                  ),
                ),
              ],
            );
          })),
    );
  }

class EmployeeDataSource extends DataGridSource {

…

  BuildContext context;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.teal
            : Colors.deepOrangeAccent,
        cells: row.getCells().map<Widget>((dataGridCell) {
          return Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                dataGridCell.value.toString(),
                overflow: TextOverflow.ellipsis,
              ));
        }).toList());
  }

  void updateDataGrid() {
    notifyListeners();
  }
}
```

You can download the example from [GitHub](https://github.com/SyncfusionExamples/How-to-dynamically-change-row-colors-based-on-the-theme-in-Flutter-DataTable).