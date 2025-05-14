import "dart:developer";

import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';
import 'package:flutter_todo/extensions/space_exs.dart';
import 'package:flutter_todo/utils/app_colors.dart';
import 'package:flutter_todo/utils/app_str.dart';
import 'package:flutter_todo/views/tasks/components/date_time_selection.dart';
import 'package:flutter_todo/views/tasks/components/rep_textfield.dart';
import 'package:flutter_todo/views/tasks/widget/task_view_app_bar.dart';

class TaskView extends StatefulWidget {
  const TaskView({super.key});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  final TextEditingController titleTaskController = TextEditingController();
  final TextEditingController descriptionTaskController =
      TextEditingController();

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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Delete Button
          MaterialButton(
            onPressed: () {
              // todo: delete task
              log('delete task');
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
              // todo: add or update task
              log('add task');
            },
            minWidth: 150,
            height: 55,
            color: AppColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Text(
              AppStr.addTaskString,
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
          RepTextField(controller: titleTaskController),

          10.h,

          // Task Description
          RepTextField(
            controller: descriptionTaskController,
            isForDescription: true,
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
                        // initDateTime: ,
                        onChange: (_, __) {},
                        dateFormat: 'HH:mm',
                        onConfirm: (dateTime, _) {},
                      ),
                    ),
              );
            },
          ),

          // Date Selection
          DateTimeSelectionWidget(
            onTap: () {
              DatePicker.showDatePicker(
                context,
                maxDateTime: DateTime(2030, 4, 5),
                minDateTime: DateTime.now(),
                // initialDateTime:
                onConfirm: (dateTime, _) {},
              );
            },
            title: AppStr.dateString,
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

          // Text will be changed: "ADD NEW TASK" or "UPDATE CURRENT"
          RichText(
            text: TextSpan(
              text: AppStr.addNewTask,
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
