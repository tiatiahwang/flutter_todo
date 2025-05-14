import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';
import 'package:flutter_todo/extensions/space_exs.dart';
import 'package:flutter_todo/utils/app_str.dart';
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

                  // Main
                  SizedBox(
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

                        // Date selection
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
                  ),
                ],
              ),
            ),
          ),
        ),
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

          const SizedBox(width: 70, child: Divider(thickness: 2)),
        ],
      ),
    );
  }
}

class DateTimeSelectionWidget extends StatelessWidget {
  const DateTimeSelectionWidget({
    super.key,
    required this.onTap,
    required this.title,
  });

  final VoidCallback onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(title, style: textTheme.headlineSmall),
            ),

            Container(
              margin: const EdgeInsets.only(right: 10),
              width: 80,
              height: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade100,
              ),
              child: Center(child: Text(title, style: textTheme.titleSmall)),
            ),
          ],
        ),
      ),
    );
  }
}
