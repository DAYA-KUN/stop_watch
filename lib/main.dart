import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(StopWatchApp());

class StopWatchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stop Watch App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: StopWatchPage(),
    );
  }
}

class StopWatchPage extends StatefulWidget {
  @override
  _StopWatchPageState createState() => _StopWatchPageState();
}

class _StopWatchPageState extends State<StopWatchPage> {
  bool _isRunning = false;
  bool _isHolding = false;
  Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;

  void _startTimer() {
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {});
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  void _resetTimer() {
    _stopwatch.reset();
    setState(() {});
  }

  void _toggleHolding() {
    if (_isHolding) {
      _startTimer();
    } else {
      _stopTimer();
    }
    setState(() {
      _isHolding = !_isHolding;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stop Watch')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${_stopwatch.elapsed.inMinutes}:${(_stopwatch.elapsed.inSeconds % 60).toString().padLeft(2, '0')}.${(_stopwatch.elapsed.inMilliseconds % 1000).toString().padLeft(3, '0')}',
              style: TextStyle(fontSize: 48.0),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (!_isRunning) {
                      _stopwatch.start();
                      _startTimer();
                      setState(() {
                        _isRunning = true;
                      });
                    }
                  },
                  child: Text('Start'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_isRunning) {
                      _stopwatch.stop();
                      _stopTimer();
                      setState(() {
                        _isRunning = false;
                      });
                    }
                  },
                  child: Text('Stop'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    _toggleHolding();
                  },
                  child: Text(_isHolding ? 'Resume' : 'Hold'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    _stopwatch.stop();
                    _stopTimer();
                    _resetTimer();
                    setState(() {
                      _isRunning = false;
                    });
                  },
                  child: Text('Restart'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

