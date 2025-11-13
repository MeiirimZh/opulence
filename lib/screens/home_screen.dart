import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:opulence/screens/statistics_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();

  // Контролеры для получения текста
  final _sumController = TextEditingController();

  @override
  void dispose() {
    _sumController.dispose();
    super.dispose();
  }

  String _msg = "";
  String _inputAction = "+";

  void _setMsg(String newMsg) {
    setState(() {
      _msg = newMsg;
      saveData();
    });
  }

  void _setInputAction() {
    setState(() {
      if (_inputAction == "+") {
        _inputAction = "−";
      } else {
        _inputAction = "+";
      }
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final sum = _sumController.text;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Введенная сумма: $sum')));
    }
  }

  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('msg', _msg);
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    String msg = prefs.getString('msg') ?? "Привет, Lorem!";

    _setMsg(msg);
  }

  @override
  void initState() {
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const StatisticsScreen(),
                ),
              );
            },
            icon: SvgPicture.asset(
              'assets/icons/graph.svg',
              width: 24,
              height: 24,
            ),
          ),
          IconButton(
            onPressed: () {
              print("hello");
            },
            icon: SvgPicture.asset(
              'assets/icons/calendar.svg',
              width: 24,
              height: 24,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 20, top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10.0,
            children: [
              Text('Доходы', style: TextStyle(fontSize: 16)),
              Table(
                border: TableBorder.all(color: Colors.black),
                columnWidths: const <int, TableColumnWidth>{
                  0: FixedColumnWidth(60.0),
                  1: FixedColumnWidth(100.0),
                  2: FixedColumnWidth(190.0),
                },
                children: [
                  TableRow(
                    children: [
                      TableCell(child: Center(child: Text('Время'))),
                      TableCell(child: Center(child: Text('Доход'))),
                      TableCell(child: Center(child: Text('Источник'))),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Center(child: Text('11:45'))),
                      TableCell(child: Center(child: Text('10 000'))),
                      TableCell(child: Center(child: Text('Lorem'))),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Center(child: Text('19:23'))),
                      TableCell(child: Center(child: Text('5 000'))),
                      TableCell(child: Center(child: Text('Ipsum'))),
                    ],
                  ),
                ],
              ),
              Text('Расходы', style: TextStyle(fontSize: 16)),
              Table(
                border: TableBorder.all(color: Colors.black),
                columnWidths: const <int, TableColumnWidth>{
                  0: FixedColumnWidth(60.0),
                  1: FixedColumnWidth(100.0),
                  2: FixedColumnWidth(190.0),
                },
                children: [
                  TableRow(
                    children: [
                      TableCell(child: Center(child: Text('Время'))),
                      TableCell(child: Center(child: Text('Расход'))),
                      TableCell(child: Center(child: Text('Источник'))),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Center(child: Text('12:16'))),
                      TableCell(child: Center(child: Text('1 000'))),
                      TableCell(child: Center(child: Text('Lorem'))),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Center(child: Text('14:42'))),
                      TableCell(child: Center(child: Text('2000'))),
                      TableCell(child: Center(child: Text('Ipsum'))),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Center(child: Text('20:01'))),
                      TableCell(child: Center(child: Text('300'))),
                      TableCell(child: Center(child: Text('Dolor'))),
                    ],
                  ),
                ],
              ),
              Form(
                key: _formKey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  children: [
                    ElevatedButton(
                      onPressed: () => _setInputAction(),
                      child: Text(_inputAction),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightGreen,
                        foregroundColor: Colors.white
                      )
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _sumController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Сумма',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Поле обязательно для заполнения';
                          }

                          if (int.parse(value) < 0) {
                            return 'Сумма не может быть меньше нуля';
                          }
                          return null;
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => _submitForm(),
                      child: Text(">"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightGreen,
                        foregroundColor: Colors.white
                      )
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
