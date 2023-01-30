import 'dart:async';
import 'dart:ui';

class Debounce {
  final int milliseconds;
  Timer? _timer;

  Debounce({this.milliseconds = 3000});

  void run(VoidCallback action) {
    if (_timer?.isActive ?? false) _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  void dispose() => _timer?.cancel();
}
