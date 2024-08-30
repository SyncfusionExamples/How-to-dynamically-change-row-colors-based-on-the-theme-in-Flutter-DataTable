import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

void main() {
  runApp(
    const MaterialApp(home: SfDataGridDemo()),
  );
}

Brightness brightness = Brightness.light;

class SfDataGridDemo extends StatefulWidget {
  const SfDataGridDemo({super.key});

  @override
  SfDataGridDemoState createState() => SfDataGridDemoState();
}

class SfDataGridDemoState extends State<SfDataGridDemo> {
  List<Employee> _employees = <Employee>[];
  late EmployeeDataSource _employeeDataSource;

  @override
  void initState() {
    _employees = getEmployeeData();
    _employeeDataSource = EmployeeDataSource(_employees, context);
    super.initState();
  }

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
                SizedBox(
                  width: 500,
                  height: 550,
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

  List<GridColumn> get getColumns {
    return <GridColumn>[
      GridColumn(
          columnName: 'id',
          label: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.center,
              child: const Text('ID'))),
      GridColumn(
          columnName: 'name',
          label: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.center,
              child: const Text('Name'))),
      GridColumn(
          columnName: 'designation',
          label: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.center,
              child:
                  const Text('Designation', overflow: TextOverflow.ellipsis))),
      GridColumn(
          columnName: 'salary',
          label: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.center,
              child: const Text('Salary'))),
    ];
  }

  List<Employee> getEmployeeData() {
    return [
      Employee(10001, 'Kathryn', 'Manager', 30000),
      Employee(10002, 'James', 'Project Lead', 20000),
      Employee(10003, 'Lara', 'Developer', 20000),
      Employee(10004, 'Michael', 'Designer', 30000),
      Employee(10005, 'Martin', 'Developer', 30000),
      Employee(10006, 'Newberry', 'Developer', 15000),
      Employee(10007, 'Balnc', 'Developer', 15000),
      Employee(10008, 'Perry', 'Developer', 20000),
      Employee(10009, 'Gable', 'Developer', 20000),
      Employee(10010, 'Grimes', 'Developer', 30000),
    ];
  }
}

class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource(this.employees, this.context) {
    dataGridRows = employees.map<DataGridRow>((employee) {
      return DataGridRow(cells: [
        DataGridCell<int>(columnName: 'id', value: employee.id),
        DataGridCell<String>(columnName: 'name', value: employee.name),
        DataGridCell<String>(
            columnName: 'designation', value: employee.designation),
        DataGridCell<int>(columnName: 'salary', value: employee.salary)
      ]);
    }).toList();
  }

  List<Employee> employees = [];

  List<DataGridRow> dataGridRows = [];

  BuildContext context;

  @override
  List<DataGridRow> get rows => dataGridRows;

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

class Employee {
  Employee(this.id, this.name, this.designation, this.salary);

  int? id;
  String? name;
  String? designation;
  int? salary;
}
