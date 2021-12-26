import 'package:flutter/material.dart';

List<Color> colors = [
  Color(0xFFFFFFFF),
  Color(0xff78addb),
  Color(0xFFC6B88E),
  Color(0xDCD6B0EF),
  Color(0xFFB7D484),
  Color(0xFF6F9088),
  Color(0xFFE6C9A9),
  Color(0xFFEA2E94),
  Color(0xFFB7EE20),
  Color(0xFF1A8597)
];

class PriorityPicker extends StatefulWidget {
  final Function(int) onTap;
  final int selectedIndex;
  PriorityPicker({this.onTap, this.selectedIndex});
  @override
  _PriorityPickerState createState() => _PriorityPickerState();
}

class _PriorityPickerState extends State<PriorityPicker> {
  int selectedIndex;
  List<String> priorityText = ['Low', 'Medium', 'High'];
  List<Color> priorityColor = [Colors.green, Colors.lightGreen, Colors.red];
  @override
  Widget build(BuildContext context) {
    if (selectedIndex == null) {
      selectedIndex = widget.selectedIndex;
    }
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width,
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              widget.onTap(index);
            },
            child: Container(
              padding: EdgeInsets.all(8.0),
              width: width / 3,
              height: 70,
              child: Container(
                child: Center(
                  child: Text(priorityText[index],
                      style: TextStyle(
                          color: selectedIndex == index
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.bold)),
                ),
                decoration: BoxDecoration(
                    color: selectedIndex == index
                        ? priorityColor[index]
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8.0),
                    border: selectedIndex == index
                        ? Border.all(width: 2, color: Colors.black)
                        : Border.all(width: 0, color: Colors.transparent)),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ColorPicker extends StatefulWidget {
  final Function(int) onTap;
  final int selectedIndex;
  ColorPicker({this.onTap, this.selectedIndex});
  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  int selectedIndex;

  @override
  Widget build(BuildContext context) {
    if (selectedIndex == null) {
      selectedIndex = widget.selectedIndex;
    }
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width,
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: colors.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              widget.onTap(index);
            },
            child: Container(
              padding: EdgeInsets.all(8.0),
              width: 50,
              height: 50,
              child: Container(
                child: Center(
                    child: selectedIndex == index
                        ? Icon(Icons.done)
                        : Container()),
                decoration: BoxDecoration(
                    color: colors[index],
                    shape: BoxShape.circle,
                    border: Border.all(width: 2, color: Colors.black)),
              ),
            ),
          );
        },
      ),
    );
  }
}