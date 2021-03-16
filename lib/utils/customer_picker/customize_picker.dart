import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef PickerRowCallBack = int Function(int section);
typedef PickerItemBuilder = Widget Function(int section, int row);
typedef PickerVoidCallBack = void Function(int section, int row);

class PickerView extends StatefulWidget {
  final PickerRowCallBack numberofRowsAtSection;
  final PickerItemBuilder itemBuilder;
  final PickerVoidCallBack onSelectRowChanged;
  final double itemExtent;
  final PickerController controller;
  int itemSelect;
  final Color backgroundColor;
  final FixedExtentScrollController fixedExtentScrollController;

  PickerView({
    @required this.numberofRowsAtSection,
    @required this.itemBuilder,
    @required this.controller,
    @required this.backgroundColor,
    @required this.fixedExtentScrollController,
    this.itemExtent = 40,
    this.itemSelect,
    this.onSelectRowChanged,
  }) : super();

  @override
  State<StatefulWidget> createState() {
    return PickerViewState();
  }
}

class PickerViewState extends State<PickerView> {
  PickerController _controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(PickerView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      _controller = widget.controller;
    }
  }

  @override
  void didChangeDependencies() {
    _controller = widget.controller ?? PickerController(count: 0);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    //remove material widget to make CupertinoPicker background color transparent
    // return Material(
    //       child: Container(
    //       color: Colors.transparent, child: Row(children: _buildPickers())),
    // );
    return Container(
        color: Colors.transparent, child: Row(children: _buildPickers()));
  }

  List<Widget> _buildPickers() {
    List<Widget> children = [];

    for (int section = 0; section < _controller.count; section++) {
      children
          .add(Expanded(flex: 1, child: _buildPickerItem(section: section)));
    }

    return children;
  }

  Widget _buildPickerItem({int section}) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 0, color: widget.backgroundColor),
          color: widget.backgroundColor),
      child: CupertinoPicker.builder(
        backgroundColor: widget.backgroundColor,
        scrollController: widget.fixedExtentScrollController,
        diameterRatio: 1,
        itemExtent: widget.itemExtent ?? 40,
        childCount: widget.numberofRowsAtSection(section),
        onSelectedItemChanged: (row) {
          if (widget.onSelectRowChanged != null) {
            setState(() {
              widget.itemSelect = row;
            });
            widget.onSelectRowChanged(section, row);
          }
        },
        itemBuilder: (context, row) {
          return widget.itemSelect == row
              ? Container(
                  alignment: Alignment.center,
                  color: Colors.transparent,
                  child: widget.itemBuilder(section, row))
              : Container(
                  alignment: Alignment.center,
                  color: widget.backgroundColor,
                  child: widget.itemBuilder(section, row));
        },
      ),
    );
  }
}

class PickerController {
  final int count;
  final List<FixedExtentScrollController> scrollControllers;

  PickerController({@required this.count, List<int> selectedItems})
      : scrollControllers = [] {
    for (int i = 0; i < count; i++) {
      if (selectedItems != null && i < selectedItems.length) {
        scrollControllers
            .add(FixedExtentScrollController(initialItem: selectedItems[i]));
      } else {
        scrollControllers.add(FixedExtentScrollController());
      }
    }
  }

  void dispose() {
    scrollControllers.forEach((item) {
      item.dispose();
    });
  }

  int selectedRowAt({@required int section}) {
    try {
      FixedExtentScrollController scrollController = scrollControllers[section];
      if (scrollController != null) {
        return scrollController.selectedItem;
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }

  void jumpToRow(int row, {@required int atSection}) {
    try {
      if (scrollControllers.length <= atSection) {
        return;
      }
      FixedExtentScrollController scrollController = scrollControllers[1];
      scrollController.jumpToItem(row);
    } catch (err) {
      print(err);
    }
  }

  Future<void> animateToRow(
    int row, {
    @required int atSection,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) async {
    try {
      if (scrollControllers.length <= atSection) {
        return;
      }
      FixedExtentScrollController scrollController =
          scrollControllers[atSection];
      await scrollController.animateToItem(row,
          duration: duration, curve: curve);
    } catch (err) {}
  }
}
