import 'package:flutter/cupertino.dart';

// 所有 BLoCs 的通用接口
abstract class BlocBase {
  void dispose();
}

class BlocProvider<State extends BlocBase> extends InheritedWidget {
  State _state;
  BlocProvider({Key key, @required State state, @required Widget child})
      : assert(state != null),
        assert(child != null),
        _state = state,
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static State of<State extends BlocBase>(BuildContext context) {
    Type _typeOf<T>() => T;
    final type = _typeOf<BlocProvider<State>>();

    final provider =
           context.inheritFromWidgetOfExactType(type) as BlocProvider<State>;
       // context.ancestorWidgetOfExactType(type) as BlocProvider<State>;
    if (provider == null) throw BlocProviderError(BlocProvider);
    return provider._state;
  }
}

class BlocProviderError extends Error {
  /// The type of the class the user tried to retrieve
  Type type;

  /// Creates a StoreProviderError
  BlocProviderError(this.type);

  @override
  String toString() {
    return '''Error: No $type found.''';
  }
}
