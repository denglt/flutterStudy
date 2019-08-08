import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormDemo extends StatefulWidget {
  @override
  _FormDemoState createState() => _FormDemoState();
}

class _FormDemoState extends State<FormDemo> {
  String _name;
  String _password;
  String _grade;
  String _phone;
  bool _isMarry = false;
  bool _isWifi = false;
  int _blood = 0; //(1、高压，2、正常，3、低压)
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scafflodKey = GlobalKey<ScaffoldState>();

  TextEditingController _nameController = new TextEditingController();

  FocusNode _addressNode = FocusNode();
  List<String> _menuItems;

  @override
  void initState() {
    super.initState();

    _nameController.value = new TextEditingValue(text: 'denglt');
    _nameController.addListener(() {
      print(_nameController.text);
    });
    //_nameController.notifyListeners();
    _menuItems = ['One', 'Two', 'Free', 'Four'];
  }

  @override
  Widget build(BuildContext context) {
    //print('Form Build');
    return Scaffold(
      key: _scafflodKey,
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Form and Input'),
      ),
      bottomNavigationBar: Text('bottomNavigationBar'),
      // bottomSheet: Text('bottomSheet'),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          // DropdownButtonFormField TextFormField
          key: _formKey,
          child: ListView(
          //  crossAxisAlignment: CrossAxisAlignment.center,
           // mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                autofocus: true,
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Your Name',
                  contentPadding: EdgeInsets.all(10.0),
                ),
                keyboardType: TextInputType.text, //获取焦点时,启用的键盘类型,
                textAlign: TextAlign.right,
                onSaved: (val) {
                  _name = val;
                },
                maxLength: 30,
                onEditingComplete: () {
                  print('onEditingComplete');
                },
                cursorColor: Colors.red, //控制鼠标
                cursorRadius: Radius.circular(16.0),
                cursorWidth: 16.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  contentPadding: EdgeInsets.all(10.0),
                ),
                autovalidate: true,
                obscureText: true, // 隐藏输入明文
                validator: (val) {
                  return val.length < 4 ? "密码长度错误" : null;
                },
                onSaved: (val) {
                  // FormState.save
                  print('Password: onSaved -> $val');
                  _password = val;
                },
                onEditingComplete: () {
                  // 键盘的done触发
                  print('onEditingComplete');
                  FocusScope.of(context).requestFocus(_addressNode); // 切换焦点
                },
                onFieldSubmitted: (val) {
                  // 键盘的done触发
                  // 与onSubmitted一样,则是在输入结束,点击完成的时候触发。
                  print('Password: onFieldSubmitted -> $val');
                },
                textInputAction: TextInputAction.search, // 控制键盘输入完成键
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Your Phone',
                  contentPadding: EdgeInsets.all(10.0),
                  icon: Icon(Icons.text_fields),
                ),
                maxLength: 13,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.go,
                onSaved: (val) => _phone = val,
              ),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  labelText: 'Your 年级',
                  contentPadding: EdgeInsets.all(10.0),
                  icon: Icon(Icons.text_fields),
                ),
                value: _grade,
                items: _menuItems.map((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text('年级 $e'),
                  );
                }).toList(),
                onChanged: (t) {
                  print('onChanged -> $t');
                  _grade = t;
                  setState(() {});
                },
                onSaved: (t) => print('onSaved -> $t'),
              ),
              //Checkbox
              CheckboxListTile(
                isThreeLine: false,
                secondary: const Icon(Icons.shutter_speed),
                title: const Text('是否已婚'),
                value: _isMarry,
                //activeColor: Colors.red,
                onChanged: (bool value) {
                  _isMarry = value;
                  setState(() {});
                },
              ),
              //Switch
              SwitchListTile(
                isThreeLine: false,
                secondary: const Icon(Icons.wifi),
                //selected: true,
                title: Text('Wi-Fi'),
                subtitle: Text('wifi'),
                value: _isWifi,
                onChanged: (bool value) {
                  setState(() {
                    _isWifi = value;
                  });
                },
                activeTrackColor: Colors.lightGreenAccent,
                activeColor: Colors.green,
              ),
              //Radio(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: RadioListTile<int>(
                      title: Text('升压'),
                      value: 1,
                      groupValue: _blood,
                      onChanged: _onChangeBlood,
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<int>(
                      title: Text('正常'),
                      value: 2,
                      groupValue: _blood,
                      onChanged: _onChangeBlood,
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<int>(
                      title: Text('低压'),
                      value: 3,
                      groupValue: _blood,
                      onChanged: _onChangeBlood,
                    ),
                  ),
                ],
              ),
              TextField(
                // controller: _controller,
                focusNode: _addressNode,
                decoration: InputDecoration(
                  labelText: 'Your Address',
                  contentPadding: EdgeInsets.all(10.0),
                  //helperText: '密码长度错误',
                  helperStyle: TextStyle(
                    color: Colors.red,
                  ),
                ),
                onChanged: (val) {
                  print('Address: onChanged -> $val');
                },
                autofocus: false,
                onSubmitted: (val) {
                  print('Address: onSubmitted -> $val');
                },
              ),
              TextField(
                autocorrect: false, // 是否自动校正
                autofocus: false, //自动获取焦点
                enabled: true, // 是否启用
                inputFormatters: [], //����输入的文字进行限制和校验
                keyboardType: TextInputType.text, //获取焦点时,���用的键盘类型
                maxLines: 2, // 输入框最大的显示行数
                maxLength: 3, //允许输入的字符长度/
                maxLengthEnforced: false, //是�����允许输入的字符长度超过限定的字符长度
                obscureText: false, // 是否隐藏输入的内容
                onChanged: (newValue) {
                  // print(newValue); // 当输入内容变更时,如何处理
                },
                onSubmitted: (value) {
                  // print("whar"); // 当用户确定已经完成编辑时触发
                },
                //    style: new TextStyle(
                //        color: new Color(Colors.amberAccent.green)), // 设置字��样式
                textAlign: TextAlign.center, //输入的内容在水平方向如何显示
                decoration: new InputDecoration(
                  labelText: "城市",
                  icon: new Icon(Icons.location_city),
                  border: new OutlineInputBorder(), // 边框样式
                  helperText: 'required',
                  hintText: '请选择你要投保的城市',
                  prefixIcon: Icon(Icons.android),
                  // suffix: Text('>'),
                  suffixIcon: Icon(Icons.ac_unit),
                  prefixText: 'prefix',
                  suffixText: 'subbfix',
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //dsd print('conrtext -> $context');
          _forSubmitted(context);
        },
        child: new Text('提交'),
      ),
    );
  }

  void _forSubmitted(BuildContext context) {
    print('$_name, $_password, $context');
    FormState formState2 = Form.of(context); // can not find FormState; ???
    print('forstate2 -> $formState2');
    FormState formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      //formState.reset(); // 有controll的无法reset
      print('$_name, $_password, $_phone,$_grade ,$_isMarry ,$_isWifi,$_blood');

      // Scaffold.of(context)
      _scafflodKey.currentState.showBottomSheet((BuildContext context) {
        return Text(
            '$_name, $_password, $_phone,$_grade ,$_isMarry ,$_isWifi,$_blood');
      });
      SnackBar snackBar = _snackBar();
      _scafflodKey.currentState.showSnackBar(snackBar);
    }
  }

  void _onChangeBlood(int val) {
    _blood = val;
    setState(() {});
  }

  Widget _snackBar() {
    return SnackBar(
      content: Container(
        height: 300,
        child: Text(
          '你的输入是:$_name, $_password, $_phone,$_grade ,$_isMarry ,$_isWifi,$_blood',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      action: SnackBarAction(
        label: 'ok',
        onPressed: () {
          print('ok');
        },
      ),
      duration: Duration(seconds: 10000), //默认4s
      // animation: null, ???
    );
  }
}
