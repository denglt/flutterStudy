import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:camera/camera.dart';

import 'src/colors_demo.dart';
import 'src/my_layout.dart';
import 'src/pavlova.dart';
import 'src/random_words.dart';
import 'src/my_scaffold.dart';
import 'src/counter.dart';
import 'src/shop.dart';
import 'src/card_and_stack.dart';
import 'src/grid_and_list.dart';
import 'src/utils/buttons.dart';
import 'src/play_video.dart';
import 'src/utils/dialogs.dart';
import 'src/animate/animated_list.dart';
import 'src/pic_screen.dart';
import 'src/animate/animated_container.dart';
import 'src/animate/bar_loading_screen.dart';

import 'src/animate/hero_animation.dart';
import 'src/animate/stagger_animation.dart';
import 'src/animate/logo_screen.dart';
import 'src/scroll/sliver_demo.dart';
import 'src/scroll/scroll_limit_reached.dart';
import 'src/input/form_demo.dart';
import 'src/state_manage/redux/counter_main.dart';
import 'src/scroll/scroll_move.dart';
import 'src/scroll/scroll_status.dart';
import 'src/test_ui.dart';
import 'src/state_manage/bloc/counter_main.dart';
import 'src/platform_channel/battery_page.dart';

import 'src/camera/take_picture.dart';
import 'src/open_browser.dart';

import 'src/camera/camera_example_home.dart';
import 'src/image_picker/image_picker_demo.dart';
import 'src/image_picker/image_picker_saver.dart';
import 'src/location/location_page.dart';
import 'src/chart/line_chart_sample1.dart';

class RandoomWordsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 检测手势的小部件(给事件的widget，添加手势)
      onTap: () {
        print('MyButton was tapped!');
        _pushRandomWords(context);
      },
      child: Container(
        height: 36.0,
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.lightGreen[500],
        ),
        child: Center(
          child: Text('RandomWords'),
        ),
      ),
    );
  }

  void _pushRandomWords(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (BuildContext context) {
        return RandomWords();
      }),
    );
  }
}

class ShippingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.shopping_cart),
      tooltip: 'shopping',
      onPressed: () => _onPressed(context),
    );
  }

  void _onPressed(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (BuildContext context) {
        return ShoppingList(
          products: <Product>[
            Product(name: 'Eggs'),
            Product(name: 'Flour'),
            Product(name: 'Chocolate chips'),
          ],
        );
      }),
    );
  }
}

class MyLayoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.layers),
      tooltip: 'shopping',
      onPressed: () => _onPressed(context),
    );
  }

  void _onPressed(BuildContext context) {
    /*
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (BuildContext context) {
        return MyLayout();
      }),
    );
    */
    Navigator.pushNamed(context, '/mylayout');
    //Navigator.pushReplacement(context, newRoute)
  }
}

class PavlovaButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.cake),
      tooltip: 'pavalova',
      onPressed: () => _onPressed(context),
    );
  }

  void _onPressed(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (BuildContext context) {
        return Pvalova();
      }),
    );
  }
}

class MyScaffoldIconButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.help),
      tooltip: 'my scaffold',
      onPressed: () => _onPressed(context),
    );
  }

  void _onPressed(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (BuildContext context) {
        return MyScaffold();
      }),
    );
  }
}

class GridAndListButton extends StatelessWidget {
  final bool showGrid;
  final String label;
  GridAndListButton({@required this.showGrid, @required this.label});
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return buildLabelButton(
      color: color,
      icon: Icons.ac_unit,
      label: label,
      onPressed: () => _onPressed(context),
    );
  }

  void _onPressed(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (BuildContext context) {
        return GridAndList(
          showGrid: showGrid,
        );
      }),
    );
  }
}

class ColorButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return buildLabelButton(
      color: color,
      icon: Icons.color_lens,
      label: 'COLOR',
      onPressed: () => _onPressed(context),
    );
  }

  void _onPressed(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (BuildContext context) {
        return ColorsDemo();
      }),
    );
  }
}

class CardAndStackButton extends StatelessWidget {
  final String label;
  final bool showCard;

  CardAndStackButton({this.showCard, this.label});
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return buildLabelButton(
      color: color,
      icon: Icons.credit_card,
      label: label,
      onPressed: () => _onPressed(context),
    );
  }

  void _onPressed(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (BuildContext context) {
        return CardAndStack(
          showCard: showCard,
        );
      }),
    );
  }
}

class PlayVideoButton extends StatelessWidget {
  final String label;
  final String url;

  PlayVideoButton({@required this.label, @required this.url});
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return buildLabelButton(
      color: color,
      icon: Icons.video_call,
      label: label,
      onPressed: () => _onPressed(context),
    );
  }

  void _onPressed(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (BuildContext context) {
        return PlayVideo(url: url);
      }),
    );
  }
}

class AskOkButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return buildLabelButton(
      color: color,
      icon: Icons.do_not_disturb_on,
      label: 'AskOK',
      onPressed: () => _onPressed(context),
    );
  }

  void _onPressed(BuildContext context) async {
    // 这儿应该使用了Isolate技术, 同时获取route 的返回值
    bool value = await Navigator.push(context,
        MaterialPageRoute<bool>(builder: (BuildContext context) {
      return Center(
        child: GestureDetector(
            child: Text('OK'),
            onTap: () {
              Navigator.pop(context, true);
            }),
      );
    }));
    print('AskOk ->' + value.toString());
  }
}

class DialogButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return buildLabelButton(
      color: color,
      icon: Icons.dashboard,
      label: 'DIALOG',
      onPressed: () => _onPressed(context),
    );
  }

  void _onPressed(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Center(
          child: GestureDetector(
              child: Text('OK'),
              onTap: () {
                print('dialog ontap');
                Navigator.pop(context, true);
              }),
        );
      },
    );
  }
}

class AlertDialogButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return buildLabelButton(
      color: color,
      icon: Icons.dashboard,
      label: 'ALERT',
      onPressed: () => _onPressed(context),
    );
  }

  void _onPressed(BuildContext context) async {
    alertDialog(context: context, title: '注意：', content: '你无权限操作！');
  }
}

class ConfirmDialogButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return buildLabelButton(
      color: color,
      icon: Icons.dashboard,
      label: 'Confirm',
      onPressed: () => _onPressed(context),
    );
  }

  void _onPressed(BuildContext context) async {
    ConfirmAction confirmAction = await confirmDialog(
      context: context,
      title: '告知',
      content: '你同意吗？',
    );
    print('你的操作是: $confirmAction');
  }
}

class SelectOptionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return buildLabelButton(
      color: color,
      icon: Icons.dashboard,
      label: 'Select',
      onPressed: () => _onPressed(context),
    );
  }

  void _onPressed(BuildContext context) async {
    List<String> lists =
        generateWordPairs().take(30).map((e) => e.asLowerCase).toList();
    int index =
        await selectOptionDialog(context: context, title: '请选择', lists: lists);
    print('你的选择是：${lists[index]}');
  }
}

class AnimatedListButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return buildLabelButton(
      color: color,
      icon: Icons.android,
      label: 'Ani_List',
      onPressed: () => _onPressed(context),
    );
  }

  void _onPressed(BuildContext context) async {
    Navigator.of(context).pushNamed('/animatedList');
  }
}

class AnimatedContainerButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return buildLabelButton(
      color: color,
      icon: Icons.android,
      label: 'Ani_Container',
      onPressed: () => _onPressed(context),
    );
  }

  void _onPressed(BuildContext context) async {
    Navigator.of(context).pushNamed('/animatedContainer');
  }
}

class AnimatedBarButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return buildLabelButton(
      color: color,
      icon: Icons.android,
      label: 'Ani_Bar',
      onPressed: () => _onPressed(context),
    );
  }

  void _onPressed(BuildContext context) async {
    Navigator.of(context).pushNamed('/barscreen');
  }
}

class AnimatedLogoButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return buildLabelButton(
      color: color,
      icon: Icons.android,
      label: 'Ani_Logo',
      onPressed: () => _onPressed(context),
    );
  }

  void _onPressed(BuildContext context) async {
    await Navigator.of(context).pushNamed('/logoscreen');
    timeDilation = 1.0;
  }
}

// hero动画
class HeroButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return buildLabelButton(
      color: color,
      icon: Icons.android,
      label: 'Ani_Hero',
      onPressed: () => _onPressed(context),
    );
  }

  void _onPressed(BuildContext context) async {
    await Navigator.of(context).pushNamed('/hero');
    timeDilation = 1.0;
  }
}

//交错动画
class StaggerButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return buildLabelButton(
      color: color,
      icon: Icons.android,
      label: 'Ani_Stagger',
      onPressed: () => _onPressed(context),
    );
  }

  void _onPressed(BuildContext context) async {
    await Navigator.of(context).pushNamed('/stagger');
    timeDilation = 1.0;
  }
}

class SliverButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return buildLabelButton(
      color: color,
      icon: Icons.rotate_left,
      label: 'Sliver',
      onPressed: () => _onPressed(context),
    );
  }

  void _onPressed(BuildContext context) async {
    await Navigator.of(context).pushNamed('/sliver');
    timeDilation = 1.0;
  }
}

class ScrollLimitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return buildLabelButton(
      color: color,
      icon: Icons.rotate_left,
      label: 'Limit',
      onPressed: () => _onPressed(context),
    );
  }

  void _onPressed(BuildContext context) async {
    await Navigator.of(context).pushNamed('/scrollLimit');
    timeDilation = 1.0;
  }
}

class ScrollMoveButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return buildLabelButton(
      color: color,
      icon: Icons.rotate_left,
      label: 'Move',
      onPressed: () => _onPressed(context),
    );
  }

  void _onPressed(BuildContext context) async {
    await Navigator.of(context).pushNamed('/scrollMove');
    timeDilation = 1.0;
  }
}

class ScrollStatusButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return buildLabelButton(
      color: color,
      icon: Icons.rotate_left,
      label: 'Status',
      onPressed: () => _onPressed(context),
    );
  }

  void _onPressed(BuildContext context) async {
    await Navigator.of(context).pushNamed('/scrollStatus');
    timeDilation = 1.0;
  }
}

class FormDemoButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return buildLabelButton(
      color: color,
      icon: Icons.format_align_left,
      label: 'Form',
      onPressed: () => _onPressed(context),
    );
  }

  void _onPressed(BuildContext context) async {
    await Navigator.of(context).pushNamed('/form');
    timeDilation = 1.0;
  }
}

class ReduxCounterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return buildLabelButton(
      color: color,
      icon: Icons.format_align_left,
      label: 'Redux_Counter',
      onPressed: () => _onPressed(context),
    );
  }

  void _onPressed(BuildContext context) async {
    await Navigator.of(context).pushNamed('/reduxCounter');
    timeDilation = 1.0;
  }
}

class BlocCounterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return buildLabelButton(
      color: color,
      icon: Icons.format_align_left,
      label: 'Bloc_Counter',
      onPressed: () => _onPressed(context),
    );
  }

  void _onPressed(BuildContext context) async {
    await Navigator.of(context).pushNamed('/blocCounter');
    timeDilation = 1.0;
  }
}

class BatteryPageButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return buildLabelButton(
      color: color,
      icon: Icons.battery_unknown,
      label: 'Battery',
      onPressed: () => _onPressed(context),
    );
  }

  void _onPressed(BuildContext context) async {
    await Navigator.of(context).pushNamed('/batteryPage');
    timeDilation = 1.0;
  }
}

class OpenBrowserPageButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return buildLabelButton(
      color: color,
      icon: Icons.open_in_browser,
      label: 'Browser',
      onPressed: () => _onPressed(context),
    );
  }

  void _onPressed(BuildContext context) async {
    await Navigator.of(context).pushNamed('/openBrowserPage');
    timeDilation = 1.0;
  }
}

class CameraTakePictureButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return buildLabelButton(
      color: color,
      icon: Icons.camera_alt,
      label: 'Camera',
      onPressed: () => _onPressed(context),
    );
  }

  void _onPressed(BuildContext context) async {
    await Navigator.of(context).pushNamed('/cameraTakePicture');
    timeDilation = 1.0;
  }
}

class CameraExampleHomeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return buildLabelButton(
      color: color,
      icon: Icons.camera_alt,
      label: 'Camera2',
      onPressed: () => _onPressed(context),
    );
  }

  void _onPressed(BuildContext context) async {
    List<CameraDescription> cameras;
    try {
      cameras = await availableCameras();
    } on CameraException catch (e) {
      logError(e.code, e.description);
    }
    if (cameras != null) {
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) {
            return CameraExampleHome(cameras: cameras);
          },
        ),
      );
    }
  }
}

class ImagePickerPageButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return buildLabelButton(
      color: color,
      icon: Icons.camera_alt,
      label: 'Camera3',
      onPressed: () => _onPressed(context),
    );
  }

  void _onPressed(BuildContext context) async {
    Navigator.pushNamed(context, '/imagePickerPage');
  }
}

class ImagePickerSaverPageButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return buildLabelButton(
      color: color,
      icon: Icons.camera_alt,
      label: 'Camera4',
      onPressed: () => _onPressed(context),
    );
  }

  void _onPressed(BuildContext context) async {
    Navigator.pushNamed(context, '/imagePickerSaverPage');
  }
}

class LocationPageButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return buildLabelButton(
      color: color,
      icon: Icons.location_on,
      label: 'GPS',
      onPressed: () => _onPressed(context),
    );
  }

  _onPressed(BuildContext context) {
    Navigator.pushNamed(context, '/locationPageButton');
  }
}

class LineChartSample1PageButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return buildLabelButton(
      color: color,
      icon: Icons.insert_chart,
      label: 'Chart1',
      onPressed: () => _onPressed(context),
    );
  }

  _onPressed(BuildContext context) {
    Navigator.pushNamed(context, '/lineChartSample1');
  }
}

class TutorialHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for the major Material Components.
    return Scaffold(
      appBar: AppBar(
        leading: MyScaffoldIconButton(),
        title: Text('Example title'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Search',
            onPressed: null,
          ),
          RandoomWordsButton(),
          MyLayoutButton(),
          PavlovaButton(),
          PopupMenuButton(
            elevation: 4,
            // padding: EdgeInsets.symmetric(horizontal: 50),
            offset: Offset(0, 100), //(-400,100)
            icon: Icon(Icons.add_to_photos),
            child: null, // 菜单显示
            onSelected: (t) => print(t),
            itemBuilder: (BuildContext context) {
              var list = List<PopupMenuEntry<int>>();
              list.add(PopupMenuDivider(
                height: 10,
              ));
              return <PopupMenuItem<int>>[
                PopupMenuItem(
                  value: 1,
                  child: Text('item 1'),
                ),
                PopupMenuItem(
                  value: 2,
                  child: Text('item 2'),
                ),
                CheckedPopupMenuItem(
                  child: Text(
                    "English",
                    style: TextStyle(color: Colors.black),
                  ),
                  value: 3,
                  checked: true,
                ),
              ];
            },
          ),
        ],
      ),
      // body is the majority of the screen.
      body: Center(
        child: ListView(
          children: <Widget>[
            RandoomWordsButton(),
            Counter(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ShippingButton(),
                MyLayoutButton(),
                PavlovaButton(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GridAndListButton(showGrid: true, label: 'GRID VIEW'),
                GridAndListButton(showGrid: false, label: 'LIST'),
                ColorButton(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CardAndStackButton(showCard: true, label: 'CARD'),
                CardAndStackButton(
                  showCard: false,
                  label: 'STACK',
                ),
                PlayVideoButton(
                  label: 'VIDEO',
                  url: 'https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4',
                  //'http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4',
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                AskOkButton(),
                DialogButton(),
                AlertDialogButton(),
                ConfirmDialogButton(),
                SelectOptionButton(),
              ],
            ),
            // 动画
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                AnimatedListButton(),
                AnimatedContainerButton(),
                AnimatedBarButton(),
                AnimatedLogoButton(),
                HeroButton(),
                StaggerButton(),
              ],
            ),
            // scrolπ
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SliverButton(),
                ScrollLimitButton(),
                ScrollMoveButton(),
                ScrollStatusButton(),
              ],
            ),
            // form
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FormDemoButton(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ReduxCounterButton(),
                BlocCounterButton(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                BatteryPageButton(),
                OpenBrowserPageButton(),
                CameraTakePictureButton(),
                CameraExampleHomeButton(),
                ImagePickerPageButton(),
                ImagePickerSaverPageButton(),
              ],
            ),
            Row(
              // GPS
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                LocationPageButton(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                LineChartSample1PageButton(),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Debug', // used by assistive technologies
        child: Icon(Icons.add),
        onPressed: () {
          // debugDumpApp(); // Widget tree
          //debugDumpRenderTree(); // Render tree
          debugDumpLayerTree(); // Layer tree
        },
      ),
      bottomNavigationBar: Text('datadfsdfsdfdfsdfsdfdsfsf'),
    );
  }
}

main(List<String> args) {
  //_titleSection
  debugPaintSizeEnabled = false; // Set to true for visual layout
  debugPrintBeginFrameBanner = false;
  debugPrintEndFrameBanner = false;
  timeDilation = 1.0; // 控制动画的快慢
/*
  runApp(CupertinoApp(
    title: 'My App',
    home: TutorialHome(),
  ));
  */

  /// 强制竖屏
  ///
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MaterialApp(
    title: 'My app',
    debugShowCheckedModeBanner: false,
    showPerformanceOverlay: false,
    // home: MainScreen(), //MyScaffold(),
    //initialRoute: '/testUI',
    routes: <String, WidgetBuilder>{
      // '/' 代表最先启动(不能与home同时配置)
      '/': (BuildContext context) => TutorialHome(),
      '/mylayout': (BuildContext context) => MyLayout(),
      '/color': (BuildContext context) => ColorsDemo(),
      '/pavlova': (BuildContext context) => Pvalova(),
      '/picscreen': (BuildContext context) => PicScreen(),
      '/barscreen': (BuildContext context) => BarLoadingScreen(),
      '/animatedList': (BuildContext context) => AnimatedListSample(),
      '/init': (BuildContext context) => PicScreen(),
      '/animatedContainer': (BuildContext context) => AnimatedContainerSample(),
      '/logoscreen': (BuildContext context) => LogoScreen(),
      '/hero': (BuildContext context) => HeroAnimation(),
      '/stagger': (BuildContext context) => StaggerDemo(),
      '/sliver': (BuildContext context) => SliverDemo(),
      '/scrollLimit': (BuildContext context) => ScrollLimitReached(),
      '/scrollMove': (BuildContext context) => ScrollMove(),
      '/scrollStatus': (BuildContext context) => ScrollStatus(),
      '/form': (BuildContext context) => FormDemo(),
      '/testUI': (BuildContext context) => TestUI(),
      '/reduxCounter': (BuildContext context) => MainCounter(),
      '/blocCounter': (BuildContext context) => MainBlocCounter(),
      '/batteryPage': (BuildContext context) => BatteryPage(),
      '/openBrowserPage': (BuildContext context) => OpenBrowserPage(),
      '/cameraTakePicture': (BuildContext context) => TakePictureScreen(),
      '/imagePickerPage': (BuildContext context) => ImagePickerPage(),
      '/imagePickerSaverPage': (BuildContext context) => ImagePickerSaverPage(),
      '/locationPageButton': (BuildContext context) => LocationPage(),
      '/lineChartSample1': (BuildContext context) => LineChartSample1(),
    },
    localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: [
      const Locale('en'),
      const Locale('he'),
      const Locale.fromSubtags(languageCode: 'zh'),
    ],
  ));
}

void logError(String code, String message) =>
    print('Error: $code\nError Message: $message');
