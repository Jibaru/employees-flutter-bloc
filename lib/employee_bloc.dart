import 'dart:async';

import 'employee.dart';

class EmployeeBloc {

  List<Employee> _employees = [

    Employee(1, "Employee 1", 1000.0),
    Employee(2, "Employee 2", 2000.0),
    Employee(3, "Employee 3", 3000.0),
    Employee(4, "Employee 4", 4000.0),
    Employee(5, "Employee 5", 5000.0),

  ];

  final _employeesStreamController = StreamController<List<Employee>>();

  final _employeeSalaryIncreaseStreamController = StreamController<Employee>();

  final _employeeSalaryDecreaseStreamController = StreamController<Employee>();

  Stream <List<Employee>> get employeesStream => _employeesStreamController.stream;

  StreamSink <List<Employee>> get employeesSink => _employeesStreamController.sink;

  StreamSink <Employee> get employeeSalaryIncrease => _employeeSalaryIncreaseStreamController.sink;

  StreamSink <Employee> get employeeSalaryDecrease => _employeeSalaryDecreaseStreamController.sink;

  EmployeeBloc(){
    _employeesStreamController.add(_employees);
    _employeeSalaryIncreaseStreamController.stream.listen(_incrementSalary);
    _employeeSalaryDecreaseStreamController.stream.listen(_decrementSalary);
  }

  _incrementSalary(Employee employee){
    double currentSalary = employee.salary;
    double increaseSalary = currentSalary * 20/100;

    _employees[employee.id - 1].salary = currentSalary + increaseSalary;

    employeesSink.add(_employees);
  }

  _decrementSalary(Employee employee){
    double currentSalary = employee.salary;
    double decreaseSalary = currentSalary * 20/100;

    _employees[employee.id - 1].salary = currentSalary - decreaseSalary;

    employeesSink.add(_employees);
  }

  void dispose(){
    _employeesStreamController.close();
    _employeeSalaryIncreaseStreamController.close();
    _employeeSalaryDecreaseStreamController.close();
  }
}