import 'package:flutter/material.dart';

Widget buildLabelButton(
    {Color color,
    @required IconData icon,
    String label,
    @required VoidCallback onPressed}) {
  return LabelButton(
    color: color,
    icon: icon,
    label: label,
    onPressed: onPressed,
  );
}

class LabelButton extends StatefulWidget {
  final Color color;
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  LabelButton(
      {this.color, @required this.icon, this.label, @required this.onPressed});
  @override
  _LabelButtonState createState() => _LabelButtonState();
}

class _LabelButtonState extends State<LabelButton> {
  bool _highlight = false;

  void _handleTapDown(TapDownDetails details) {
    print('onTapDown');
    setState(() {
      _highlight = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    print('onTapUp');
    setState(() {
      _highlight = false;
    });
  }

  void _handleTapCancel() {
    print('onTapCancel');
    setState(() {
      _highlight = false;
    });
  }

  void _handleTap() {
    print('onTap');
    if (widget.onPressed != null) widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    // Listener();// A widget that calls callbacks in response to pointer events.
    // NotificationListener() ;//A widget that listens for [Notification]s bubbling up the tree
    return GestureDetector(
      onTap: _handleTap,
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(widget.icon, color: widget.color),
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: Text(
                widget.label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: widget.color,
                ),
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          //color: Colors.white,
          border: _highlight
              ? Border.all(
                  color: Colors.teal[700],
                  width: 2.0,
                )
              : null,
        ),
      ),
    );
  }
}

Widget buildLabelIconButton(
    {Color color,
    @required IconData icon,
    String label,
    @required VoidCallback onPressed}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      IconButton(
        icon: Icon(icon, color: color),
        onPressed: onPressed,
      ),
      Container(
        margin: const EdgeInsets.only(top: 0),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: color,
          ),
        ),
      ),
    ],
  );
}