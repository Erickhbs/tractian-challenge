import 'package:flutter/material.dart';
class AlertFilter extends StatefulWidget {
  final Function(bool) onFilterChanged;
  const AlertFilter({required this.onFilterChanged, super.key});

  @override
  State<AlertFilter> createState() => _AlertFilterState();
}

class _AlertFilterState extends State<AlertFilter> {
  bool _isButtonPressed = false;

  final colorIcon1 = Colors.grey[700];
  final colorIcon2 = Colors.white;
  final colorBack1 = Colors.white;
  final colorBack2 = Colors.blue;

  final ButtonStyle buttonStyle = OutlinedButton.styleFrom(
    side: const BorderSide(width: 1, color: Colors.grey),
    elevation: 0,
    minimumSize: const Size(80, 40),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(Icons.info_outline, color: _isButtonPressed ? colorIcon2 : colorIcon1),
      label: Text(
        "Crítico",
        style: TextStyle(color: _isButtonPressed ? colorIcon2 : colorIcon1),
      ),
      onPressed: () {
        setState(() {
          _isButtonPressed = !_isButtonPressed;
          widget.onFilterChanged(_isButtonPressed);
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: _isButtonPressed ? colorBack2 : colorBack1,
      ).merge(buttonStyle),
    );
  }
}