import 'package:flutter/material.dart';
import 'employee.dart';
import 'employee_bloc.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final EmployeeBloc _employeeBloc = EmployeeBloc();

  @override
  void dispose() {
    super.dispose();
    _employeeBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee BLoc App'),
      ),
      body: Container(
        child: StreamBuilder<List<Employee>>(
          stream: _employeeBloc.employeesStream,
          builder: (BuildContext context, AsyncSnapshot<List<Employee>> snapshot){
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index){
                return Card(
                  elevation: 5.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          '${snapshot.data[index].id}',
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Text(
                              '${snapshot.data[index].name}',
                              style: TextStyle(fontSize: 18.0),
                            ),
                            Text(
                              '${snapshot.data[index].salary}',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: IconButton(
                          icon: Icon(Icons.arrow_upward),
                          color: Colors.green,
                          onPressed: () => _employeeBloc
                            .employeeSalaryIncrease
                            .add(snapshot.data[index]),
                        )
                      ),
                      Container(
                        child: IconButton(
                          icon: Icon(Icons.arrow_downward),
                          color: Colors.red,
                          onPressed: () => _employeeBloc
                            .employeeSalaryDecrease
                            .add(snapshot.data[index]),
                        )
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}