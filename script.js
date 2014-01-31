// Generated by CoffeeScript 1.6.3
(function() {
  $(function() {
    var averageWPM, charsTyped, currentTime, display_selector, keypress, resetTimer, sensor_selector, setup, stop, times, typing, wordTimer, wpm;
    sensor_selector = '.wpmcalc-sensor';
    display_selector = '.wpmcalc-display';
    typing = null;
    currentTime = null;
    wordTimer = null;
    wpm = null;
    charsTyped = null;
    times = null;
    setup = function(w) {
      typing = false;
      currentTime = 0;
      wordTimer = null;
      wpm = null;
      charsTyped = 0;
      times = [];
      return $(sensor_selector).keypress(function(e) {
        return keypress(e);
      });
    };
    averageWPM = function() {
      var t, time, _i, _len;
      t = 0;
      for (_i = 0, _len = times.length; _i < _len; _i++) {
        time = times[_i];
        t += 6000 / time;
      }
      return Math.floor(t / times.length);
    };
    resetTimer = function() {
      if (typing) {
        times.push(currentTime / 2);
        charsTyped = 0;
      }
      clearInterval(wordTimer);
      wordTimer = null;
      currentTime = 0;
      return wordTimer = setInterval((function() {
        return currentTime += 1;
      }), 10);
    };
    stop = function() {
      clearInterval(wordTimer);
      wordTimer = null;
      currentTime = 0;
      $(display_selector).text("Your average wpm is " + (averageWPM()));
      return typing = false;
    };
    return keypress = function(e) {
      var char;
      char = String.fromCharCode(e.keyCode);
      if (!typing) {
        resetTimer();
        typing = true;
      }
      charsTyped += 1;
      if (charsTyped === 12) {
        resetTimer();
        return $(display_selector).text('#{averageWPM()} WPM');
      }
    };
  });

}).call(this);
