import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NoseService{

}
class InheritedNose extends InheritedWidget {

  final NoseService service;
  InheritedNose(this.service, Widget child) : super(child: child);
  @override
  bool updateShouldNotify(InheritedNose oldWidget) {
    return oldWidget.service != service;
  }

  static InheritedNose of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(InheritedNose); // 只能找tree上最近的父亲节点，不能会找兄弟
      
}

class FilipWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final nose = context.inheritFromWidgetOfExactType(InheritedNose).asset;

    final nose = InheritedNose.of(context);
    return null;
  }
}
