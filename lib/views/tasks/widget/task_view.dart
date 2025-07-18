import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';
import 'package:flutter_todo/extensions/space_exs.dart';
import 'package:flutter_todo/main.dart';
import 'package:flutter_todo/models/task.dart';
import 'package:flutter_todo/utils/app_colors.dart';
import 'package:flutter_todo/utils/app_str.dart';
import 'package:flutter_todo/utils/constants.dart';
import 'package:flutter_todo/views/tasks/components/date_time_selection.dart';
import 'package:flutter_todo/views/tasks/components/rep_textfield.dart';
import 'package:flutter_todo/views/tasks/widget/task_view_app_bar.dart';
import 'package:intl/intl.dart';

class TaskView extends StatefulWidget {
  const TaskView({
    super.key,
    required this.taskControllerForTitle,
    required this.taskControllerForSubtitle,
    required this.task,
  });

  final TextEditingController? taskControllerForTitle;
  final TextEditingController? taskControllerForSubtitle;
  final Task? task;

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  var title;
  var subTitle;
  DateTime? time;
  DateTime? date;

  // Show selected time as string format
  String showTime(DateTime? time) {
    if (widget.task?.createdAtTime == null) {
      if (time == null) {
        return DateFormat('hh:mm a').format(DateTime.now()).toString();
      } else {
        return DateFormat('hh:mm a').format(time).toString();
      }
    } else {
      return DateFormat(
        'hh:mm a',
      ).format(widget.task!.createdAtTime).toString();
    }
  }

  // format inititial time and date
  DateTime formatInitial(DateTime? date) {
    if (widget.task?.createdAtDate == null) {
      if (date == null) {
        return DateTime.now();
      } else {
        return date;
      }
    } else {
      return widget.task!.createdAtDate;
    }
  }

  // Show selected date as string format
  String showDate(DateTime? date) {
    if (widget.task?.createdAtDate == null) {
      if (date == null) {
        return DateFormat.yMMMEd().format(DateTime.now()).toString();
      } else {
        return DateFormat.yMMMEd().format(date).toString();
      }
    } else {
      return DateFormat.yMMMEd().format(widget.task!.createdAtDate).toString();
    }
  }

  // If task already exists, return true
  bool isTaskAlreadyExist() {
    if (widget.taskControllerForTitle?.text == null &&
        widget.taskControllerForSubtitle?.text == null) {
      return true;
    } else {
      return false;
    }
  }

  // main function for creating or updating task
  dynamic createOrUpdateTask() {
    // update
    if (widget.taskControllerForTitle?.text != null &&
        widget.taskControllerForSubtitle?.text != null) {
      try {
        widget.taskControllerForTitle?.text = title;
        widget.taskControllerForSubtitle?.text = subTitle;

        widget.task?.save();
        Navigator.pop(context);
      } catch (e) {
        updateTaskWarning(context);
      }
    } else {
      // create new task
      if (title != null && subTitle != null) {
        var task = Task.create(
          title: title,
          subTitle: subTitle,
          createdAtDate: date,
          createdAtTime: time,
        );

        // add task data to Hibe DB using inherited widghet
        BaseWidget.of(context).dataStore.addTask(task: task);
        Navigator.pop(context);
      } else {
        emptyWanring(context);
      }
    }
  }

  // delete task
  dynamic deleteTask() {
    return widget.task?.delete();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        // AppBar
        appBar: TaskViewAppBar(),

        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Top Side Texts
                  _buildTopSideTexts(textTheme),

                  // Main Task View Activity
                  _buildMainTaskViewActivity(textTheme, context),

                  // Bottom Side Buttons
                  _buildBottomSideButtons(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Bottom Side Buttons
  Widget _buildBottomSideButtons() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment:
            isTaskAlreadyExist()
                ? MainAxisAlignment.center
                : MainAxisAlignment.spaceEvenly,
        children: [
          isTaskAlreadyExist()
              ? Container()
              :
              // Delete Button
              MaterialButton(
                onPressed: () {
                  deleteTask();
                  Navigator.pop(context);
                },
                minWidth: 150,
                height: 55,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Icon(Icons.close, color: AppColors.primaryColor),
                    5.w,
                    const Text(
                      AppStr.deleteTask,
                      style: TextStyle(color: AppColors.primaryColor),
                    ),
                  ],
                ),
              ),

          // Add or Update Button
          MaterialButton(
            onPressed: () {
              createOrUpdateTask();
            },
            minWidth: 150,
            height: 55,
            color: AppColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              isTaskAlreadyExist()
                  ? AppStr.addTaskString
                  : AppStr.updateTaskString,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // Main Task View Activity
  Widget _buildMainTaskViewActivity(TextTheme textTheme, BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 530,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title of text field
          Padding(
            padding: EdgeInsets.only(left: 30),
            child: Text(
              AppStr.titleOfTitleTextField,
              style: textTheme.headlineMedium,
            ),
          ),

          // Task Title
          RepTextField(
            controller: widget.taskControllerForTitle,
            onFieldSubmitted: (String inputTitle) {
              title = inputTitle;
            },
            onChanged: (String inputTitle) {
              title = inputTitle;
            },
          ),

          10.h,

          // Task Description
          RepTextField(
            controller: widget.taskControllerForSubtitle,
            isForDescription: true,
            onFieldSubmitted: (String inputSubtitle) {
              subTitle = inputSubtitle;
            },
            onChanged: (String inputSubtitle) {
              subTitle = inputSubtitle;
            },
          ),

          // Time Selection
          DateTimeSelectionWidget(
            title: AppStr.timeString,
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder:
                    (_) => SizedBox(
                      height: 280,
                      child: TimePickerWidget(
                        initDateTime: formatInitial(time),
                        dateFormat: 'HH:mm',
                        onChange: (_, __) {},
                        onConfirm: (dateTime, _) {
                          setState(() {
                            if (widget.task?.createdAtTime == null) {
                              time = dateTime;
                            } else {
                              widget.task!.createdAtTime = dateTime;
                            }
                          });
                        },
                      ),
                    ),
              );
            },
            isTime: true,
            time: showTime(time),
          ),

          // Date Selection
          DateTimeSelectionWidget(
            onTap: () {
              DatePicker.showDatePicker(
                context,
                maxDateTime: DateTime(2030, 4, 5),
                minDateTime: DateTime.now(),
                initialDateTime: formatInitial(date),
                onConfirm: (dateTime, _) {
                  setState(() {
                    if (widget.task?.createdAtDate == null) {
                      date = dateTime;
                    } else {
                      widget.task!.createdAtDate = dateTime;
                    }
                  });
                },
              );
            },
            title: AppStr.dateString,
            time: showDate(date),
          ),
        ],
      ),
    );
  }

  // Top Side Texts
  Widget _buildTopSideTexts(TextTheme textTheme) {
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Divider
          const SizedBox(width: 70, child: Divider(thickness: 2)),

          // Top Title
          RichText(
            text: TextSpan(
              text:
                  isTaskAlreadyExist()
                      ? AppStr.addNewTask
                      : AppStr.updateCurrentTask,
              style: textTheme.titleLarge,
              children: [
                TextSpan(
                  text: AppStr.taskString,
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),

          // Divider
          const SizedBox(width: 70, child: Divider(thickness: 2)),
        ],
      ),
    );
  }
}
