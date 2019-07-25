main(List<String> args) {
  fun(
    b: 2,
  );
  print("ok");
  String name = 'denglt';
  print(name[0]);
  List<String> ss = <String>['sdfdf', 'sdfsdf'];
  var sss = [
    'sdfdf',
    ...ss.map((f) => f + ' by denglt'),
    ...ss.map((f) => f + ' by denglt'),
  ];
  print(sss);

  bool b;
  if (b)
    print(b);
  else {
    print('false');
  }
}

void fun({int a, int b}) {
  print(" $a $b");
}
