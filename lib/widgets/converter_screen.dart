import 'package:flutter/material.dart';
import '../utils/converter_logic.dart';

class ConverterScreen extends StatefulWidget {
  final String type;
  const ConverterScreen({super.key, required this.type});

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  final TextEditingController controller = TextEditingController();
  String from = '', to = '';
  double result = 0.0;

  late List<String> units;

  @override
  void initState() {
    super.initState();
    switch (widget.type) {
      case 'Length':
        units = ['Meters', 'Kilometers', 'Centimeters', 'Inches', 'Feet'];
        break;
      case 'Weight':
        units = ['Grams', 'Kilograms', 'Pounds', 'Ounces'];
        break;
      case 'Temperature':
        units = ['Celsius', 'Fahrenheit', 'Kelvin'];
        break;
    }
    from = units[0];
    to = units[1];
  }

  void convert() {
    double value = double.tryParse(controller.text) ?? 0.0;
    setState(() {
      switch (widget.type) {
        case 'Length':
          result = UnitConverter.convertLength(value, from, to);
          break;
        case 'Weight':
          result = UnitConverter.convertWeight(value, from, to);
          break;
        case 'Temperature':
          result = UnitConverter.convertTemperature(value, from, to);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.blueAccent),
    );

    BorderRadius borderRadius = BorderRadius.only(
        bottomRight: Radius.circular(20.0), topLeft: Radius.circular(20.0));

    return Scaffold(
      appBar: AppBar(title: Text('${widget.type} Converter')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                  enabledBorder: border,
                  border: border,
                  hintText: 'Enter value'),
              keyboardType: TextInputType.number,
              onChanged: (_) => convert(),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent.withValues(alpha: 0.2),
                      borderRadius: borderRadius,
                      border: Border.all(color: Colors.black26),
                    ),
                    child: DropdownButton<String>(
                      underline: Container(),
                      focusColor: Colors.blueAccent,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10.0),
                      elevation: 5,
                      dropdownColor: Colors.white.withValues(
                        alpha: 0.9,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      value: from,
                      isExpanded: true,
                      items: units
                          .map(
                            (val) => DropdownMenuItem(
                              value: val,
                              child: Text(val),
                            ),
                          )
                          .toList(),
                      onChanged: (value) => setState(() {
                        from = value ?? '';
                        convert();
                      }),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Icon(Icons.swap_horiz),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent.withValues(alpha: 0.2),
                      borderRadius: borderRadius,
                      border: Border.all(color: Colors.black26),
                    ),
                    child: DropdownButton<String>(
                      underline: Container(),
                      focusColor: Colors.blueAccent,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10.0),
                      elevation: 10,
                      dropdownColor: Colors.white.withValues(
                        alpha: 0.9,
                      ),
                      value: to,
                      isExpanded: true,
                      items: units
                          .map((val) =>
                              DropdownMenuItem(value: val, child: Text(val)))
                          .toList(),
                      onChanged: (value) => setState(() {
                        to = value ?? '';
                        convert();
                      }),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: borderRadius,
              ),
              elevation: 5.0,
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26),
                    borderRadius: borderRadius),
                child: Text(
                  'Result: ${result.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
