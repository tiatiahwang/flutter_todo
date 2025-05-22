import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/models/task.dart';
import 'package:flutter_todo/utils/app_colors.dart';
import 'package:flutter_todo/views/tasks/widget/task_view.dart';
import 'package:intl/intl.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({super.key, required this.task});

  final Task task;

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  TextEditingController taskControllerForTitle = TextEditingController();
  TextEditingController taskControllerForSubtitle = TextEditingController();

  @override
  void initState() {
    super.initState();
    taskControllerForTitle.text = widget.task.title;
    taskControllerForSubtitle.text = widget.task.subTitle;
  }

  @override
  void dispose() {
    taskControllerForTitle.dispose();
    taskControllerForSubtitle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //navigate to task detail view
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder:
                (context) => TaskView(
                  taskControllerForTitle: taskControllerForTitle,
                  taskControllerForSubtitle: taskControllerForSubtitle,
                  task: widget.task,
                ),
          ),
        );
      },
      // Task Card
      child: AnimatedContainer(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color:
              widget.task.isCompleted
                  ? const Color.fromARGB(154, 119, 144, 229)
                  : Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              offset: const Offset(0, 4),
              blurRadius: 10,
            ),
          ],
        ),
        duration: const Duration(milliseconds: 600),
        child: ListTile(
          // Check Icon
          leading: GestureDetector(
            onTap: () {
              // Check or uncheck the task
              widget.task.isCompleted = !widget.task.isCompleted;
              widget.task.save();
            },
            child: AnimatedContainer(
              width: 30,
              height: 30,
              duration: const Duration(milliseconds: 600),
              decoration: BoxDecoration(
                color:
                    widget.task.isCompleted
                        ? AppColors.primaryColor
                        : Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey, width: 0.8),
              ),
              child: Icon(Icons.check, color: Colors.white),
            ),
          ),

          // Task title
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5, top: 3),
            child: Text(
              taskControllerForTitle.text,
              style: TextStyle(
                color:
                    widget.task.isCompleted
                        ? AppColors.primaryColor
                        : Colors.black,
                fontWeight: FontWeight.w500,
                decoration:
                    widget.task.isCompleted ? TextDecoration.lineThrough : null,
                decorationColor: AppColors.primaryColor,
              ),
            ),
          ),

          // Task description
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                taskControllerForSubtitle.text,
                style: TextStyle(
                  color:
                      widget.task.isCompleted
                          ? AppColors.primaryColor
                          : Colors.black,
                  fontWeight: FontWeight.w300,
                  decoration:
                      widget.task.isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                  decorationColor: AppColors.primaryColor,
                ),
              ),
            ],
          ),

          // Date of task
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                DateFormat('hh:mm a').format(widget.task.createdAtTime),
                style: TextStyle(
                  fontSize: 10,
                  color: widget.task.isCompleted ? Colors.white : Colors.grey,
                ),
              ),
              Text(
                DateFormat.yMMMEd().format(widget.task.createdAtDate),
                style: TextStyle(
                  fontSize: 10,
                  color: widget.task.isCompleted ? Colors.white : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
