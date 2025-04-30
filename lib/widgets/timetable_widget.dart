import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab_board/models/timetable_entry.dart';
import 'package:lab_board/utils.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:lab_board/constants.dart';

part 'timetable_entry_widget.dart';

class TimetableWidget extends StatefulWidget {
  final List<TimetableEntry> entries;

  const TimetableWidget({super.key, required this.entries});

  @override
  State<TimetableWidget> createState() => TimetableWidgetState();
}

class TimetableWidgetState extends State<TimetableWidget> {
  final ItemScrollController _itemScrollController = ItemScrollController();
  late Timer _timer;
  var _firstIndex = 0;
  var _canCatchIndex = 0;
  var _needScroll = false;

  @override
  void initState() {
    super.initState();
    _updateState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateState();
      if (_needScroll) {
        Future.delayed(const Duration(milliseconds: 1000), () {
          scrollToFirstIndex();
        });
        _needScroll = false;
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollToFirstIndex();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScrollablePositionedList.builder(
      itemCount: widget.entries.length,
      itemBuilder: (context, index) {
        return _TimetableEntryWidget(
          entry: widget.entries[index],
          showDetails: [_firstIndex, _canCatchIndex].contains(index),
          isFirst: index == _firstIndex,
          isSecond: index == (_firstIndex + 1),
          canCatch: index == _canCatchIndex,
        );
      },
      itemScrollController: _itemScrollController,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      reverse: false,
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void scrollToFirstIndex() {
    if (_firstIndex >= 0) {
      _itemScrollController.scrollTo(
        index: _firstIndex,
        duration: const Duration(milliseconds: 1000),
      );
    }
  }

  void _updateState() {
    final now = DateTime.now();
    final nowTotalSeconds = now.hour * 3600 + now.minute * 60 + now.second;
    var firstIndex = -1;
    var canCatchIndex = -1;
    for (var i = 0; i < widget.entries.length; i++) {
      widget.entries[i].updateRemaining(nowTotalSeconds);
      if (firstIndex == -1 && widget.entries[i].remaining > 0) {
        firstIndex = i;
      }
      if (canCatchIndex == -1 &&
          widget.entries[i].remaining > Constants.secondsToStation) {
        canCatchIndex = i;
      }
    }
    setState(() {
      _needScroll = _firstIndex != firstIndex && firstIndex != -1;
      _firstIndex = firstIndex;
      _canCatchIndex = canCatchIndex;
    });
  }
}
