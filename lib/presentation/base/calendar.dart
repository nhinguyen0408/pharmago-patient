import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../constants/colors.dart';
import '../constants/spacing.dart';
import '../constants/typography.dart';

class _Const {
  static const days = <String>['CN', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7'];
}

class CalendarPicker extends StatefulWidget {
  final List<String?> selectedDate;
  final Function(String)? onConfirm;
  final DateRangePickerSelectionMode selectionMode;

  const CalendarPicker({
    Key? key,
    this.selectedDate = const [],
    this.onConfirm,
    this.selectionMode = DateRangePickerSelectionMode.range,
  }) : super(key: key);

  @override
  State<CalendarPicker> createState() => _CalendarPickerState();
}

class _CalendarPickerState extends State<CalendarPicker> {
  final DateRangePickerController _controller = DateRangePickerController();
  String headerString = '';
  String _range = '';

  @override
  void initState() {
    initializeDateFormatting("vi_VN", null);
    super.initState();
  }

  void _onViewChanged(DateRangePickerViewChangedArgs args) {
    final DateTime visibleStartDate = args.visibleDateRange.startDate!;
    final DateTime visibleEndDate = args.visibleDateRange.endDate!;
    final int totalVisibleDays =
        (visibleStartDate.difference(visibleEndDate).inDays);
    final DateTime midDate =
        visibleEndDate.add(Duration(days: totalVisibleDays ~/ 2));
    headerString = _controller.view == DateRangePickerView.month
        ? DateFormat.yMMMM('vi_VN').format(midDate).toString()
        : "Năm ${DateFormat.y('vi_VN').format(midDate).toString()}";
    SchedulerBinding.instance.addPostFrameCallback((duration) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double cellWidth = width / 9;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.only(top: sp4),
          color: whiteColor,
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  const SizedBox(width: sp4),
                  GestureDetector(
                    onTap: () {
                      _controller.backward!();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      width: cellWidth,
                      height: cellWidth,
                      child: const Icon(Icons.arrow_back_ios,
                          color: greyColor, size: sp20),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        _controller.view = DateRangePickerView.year;
                        setState(() {});
                      },
                      child: Text(
                        headerString,
                        textAlign: TextAlign.center,
                        style: h3,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _controller.forward!();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      width: cellWidth,
                      height: cellWidth,
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        color: greyColor,
                        size: sp20,
                      ),
                    ),
                  ),
                  const SizedBox(width: sp4),
                ],
              ),
              const SizedBox(height: sp8),
              _controller.view == DateRangePickerView.month
                  ? SizedBox(
                      width: width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(
                          _Const.days.length,
                          (index) => SizedBox(
                            width: cellWidth,
                            child: Center(
                              child: Text(
                                _Const.days[index],
                                style: h5.copyWith(
                                  color: bg_1,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
        SfDateRangePicker(
          controller: _controller,
          monthFormat: "MM",
          navigationMode: DateRangePickerNavigationMode.snap,
          navigationDirection: DateRangePickerNavigationDirection.horizontal,
          headerHeight: 0,
          monthViewSettings: const DateRangePickerMonthViewSettings(
            viewHeaderHeight: 0,
            showTrailingAndLeadingDates: true,
          ),
          onSelectionChanged: _onSelectionChanged,
          onViewChanged: _onViewChanged,
          onSubmit: (value) {},
          rangeTextStyle: h5.copyWith(color: whiteColor),
          selectionMode: widget.selectionMode,
          backgroundColor: whiteColor,
          todayHighlightColor: mainColor,
          startRangeSelectionColor: mainColor,
          endRangeSelectionColor: mainColor,
          selectionColor: mainColor,
          rangeSelectionColor: accentColor_3,
          yearCellStyle: DateRangePickerYearCellStyle(
            textStyle: h5.copyWith(color: blackColor),
            todayTextStyle: h5.copyWith(color: mainColor),
          ),
          monthCellStyle: DateRangePickerMonthCellStyle(
            textStyle: h5.copyWith(color: blackColor),
            todayTextStyle: h5.copyWith(color: mainColor),
            trailingDatesTextStyle: h5.copyWith(color: greyColor),
            leadingDatesTextStyle: h5.copyWith(color: greyColor),
          ),
          selectionTextStyle: h5.copyWith(color: whiteColor),
          initialSelectedRange: _initialDate(),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: sp12),
          color: whiteColor,
          child: Row(
            children: <Widget>[
              const Spacer(),
              const SizedBox(width: sp4),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(sp12),
                    border: Border.all(
                      color: blackColor,
                      width: 0.5,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: sp12, horizontal: sp16),
                  child: const Text(
                    "Huỷ bỏ",
                    style: p3,
                  ),
                ),
              ),
              const SizedBox(width: sp8),
              GestureDetector(
                onTap: () {
                  if (widget.selectedDate[0] != null &&
                      widget.selectedDate[1] == null) {
                    _range =
                        "${widget.selectedDate[0]}${_range != "" ? " - $_range" : ""}";
                  }
                  if (_range == "") {
                    _range = DateFormat('dd-MM-yyyy').format(DateTime.now());
                  }
                  Navigator.of(context).pop(_range);
                  widget.onConfirm?.call(_range);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.circular(sp12),
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: sp12, horizontal: sp16),
                  child: Text(
                    "Xác nhận",
                    style: p3.copyWith(color: whiteColor),
                  ),
                ),
              ),
              const SizedBox(width: sp4),
            ],
          ),
        ),
      ],
    );
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        if (args.value.endDate == null) {
          _range = DateFormat('dd-MM-yyyy').format(args.value.startDate);
          return;
        }
        _range = '${DateFormat('dd-MM-yyyy').format(args.value.startDate)} -'
            ' ${DateFormat('dd-MM-yyyy').format(args.value.endDate ?? args.value.startDate)}';
      } else {
        _range = DateFormat('dd-MM-yyyy').format(args.value);
      }
    });
  }

  PickerDateRange _initialDate() {
    final startDate = widget.selectedDate[0] != null
        ? DateFormat('dd-MM-yyyy').parse(widget.selectedDate[0]!)
        : DateTime.now();
    final endDate = widget.selectedDate[1] != null
        ? DateFormat('dd-MM-yyyy').parse(widget.selectedDate[1]!)
        : startDate;
    return PickerDateRange(startDate, endDate);
  }
}
