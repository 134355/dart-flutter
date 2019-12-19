import 'dart:async';

class TimerUtils {
  /// 设置回调一次的定时器
  static Timer setTimeout(callback, int wait) {
    Timer _timer = Timer(Duration(milliseconds: wait), () {
      callback();
    });
    
    return _timer;
  }

  /// 设置周期性回调的定时器
  static Timer setInterval(callback, int interval) {
    Timer _timer = Timer.periodic(Duration(milliseconds: interval), (Timer timer) {
      callback(timer);
    });

    return _timer;
  }

  /// 设置倒计时
  static Timer setCountDown(callback, { int interval = 1000, int countdown = 60 }) {
    Timer _timer = Timer.periodic(Duration(milliseconds: interval), (Timer timer) {
      countdown--;
      if (countdown < 1) {
        timer.cancel();
      }
      callback(timer);
    });

    return _timer;
  }
}

debounce(callback, { int wait = 300, bool immediate = true }) {
  Timer timer;
  
  return () {
    timer?.cancel();
    bool now = (timer == null);

    if (immediate) {
      timer = TimerUtils.setTimeout(() {
        timer = null;
      }, wait);
      if (now) callback();
    } else {
      timer = TimerUtils.setTimeout(() {
        callback();
      }, wait);
    }
  };
}

throttle(callback, { int wait = 300, bool immediate = true }) {
  int previous = 0;
  Timer timer;

  return () {
    if (immediate) {
      int now = DateTime.now().millisecond;

      if (now - previous > wait) {
        callback();
        previous = now;
      }
    } else {
      if (timer == null) {
        timer = TimerUtils.setTimeout(() {
          timer = null;
          callback();
        }, wait);
      }
    }
  };
}
