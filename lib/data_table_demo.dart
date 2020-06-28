import 'package:flutter/material.dart';

class DataTableDemo extends StatefulWidget {
  @override
  _DataTableDemoState createState() => _DataTableDemoState();
}

class _DataTableDemoState extends State<DataTableDemo> {
  List<_User> users;

  _UserDataSource _dataSource;

  int rowPerPage;

  int _sortColumnIndex;

  bool _sortAscending = true;

  @override
  void initState() {
    super.initState();
    users = [];
    List.generate(100, (index) {
      users.add(_User(
        'User $index',
        index % 50,
        index % 2 == 0 ? '男' : '女',
        'Address $index',
        index + 10.0,
        isSelect: false,
      ));
    });
    _dataSource = _UserDataSource(data: users);
    rowPerPage = PaginatedDataTable.defaultRowsPerPage;
  }

  void _sort<T>(Comparable<T> getField(_User user), int columnIndex, bool ascending) {
    _dataSource._sort<T>(getField, ascending);
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: PaginatedDataTable(
        header: Text('共选中0条'),
        actions: [
          FlatButton(
            onPressed: () {},
            child: Text('显示选中项'),
          ),
        ],
        columns: [
          DataColumn(label: Text('Name')),
          DataColumn(
            label: Text('Age'),
            numeric: true,
            onSort: (index, ascending) => _sort((_User user) => user.age, index, ascending),
          ),
          DataColumn(label: Text('Sex')),
          DataColumn(label: Text('Address')),
          DataColumn(
            label: Text('Weight'),
            numeric: true,
            onSort: (index, ascending) => _sort((_User user) => user.weight, index, ascending),
          ),
        ],
        sortColumnIndex: _sortColumnIndex,
        sortAscending: _sortAscending,
        source: _dataSource,
        onSelectAll: (selectAll) {
          _dataSource.selectAll(selectAll);
        },
        onPageChanged: (page) {},
        rowsPerPage: rowPerPage,
        availableRowsPerPage: [5, 10, 20],
        onRowsPerPageChanged: (perPage) {
          setState(() {
            rowPerPage = perPage;
          });
        },
      ),
    );
  }
}

class _UserDataSource extends DataTableSource {
  _UserDataSource({this.data}) : _selectedCount = 0;

  final List<_User> data;

  int _selectedCount;

  void _sort<T>(Comparable<T> getField(_User user), bool ascending) {
    data.sort((_User a, _User b) {
      if (!ascending) {
        final _User c = a;
        a = b;
        b = c;
      }
      final Comparable<T> aValue = getField(a);
      final Comparable<T> bValue = getField(b);
      return Comparable.compare(aValue, bValue);
    });
    notifyListeners();
  }

  void selectAll(isSelect) {
    for (var user in data) user.isSelect = isSelect;
    _selectedCount = isSelect ? data.length : 0;
    notifyListeners();
  }

  @override
  DataRow getRow(int index) {
    if (index > data.length) {
      return null;
    }
    return DataRow.byIndex(
      index: index,
      selected: data[index].isSelect,
      onSelectChanged: (isSelect) {
        data[index].isSelect = isSelect;
        _selectedCount += isSelect ? 1 : -1;
        notifyListeners();
      },
      cells: [
        DataCell(Text('${data[index].name}')),
        DataCell(Text('${data[index].age}')),
        DataCell(Text('${data[index].sex}')),
        DataCell(Text('${data[index].address}')),
        DataCell(Text('${data[index].weight}')),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => _selectedCount;
}

class _User {
  _User(this.name, this.age, this.sex, this.address, this.weight, {this.isSelect});

  final String name;

  final int age;

  final String sex;

  final String address;

  final double weight;

  bool isSelect;
}
