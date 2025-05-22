import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_todo/main.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

import 'package:flutter_todo/extensions/space_exs.dart';
import 'package:flutter_todo/models/task.dart';
import 'package:flutter_todo/utils/app_colors.dart';
import 'package:flutter_todo/utils/app_str.dart';
import 'package:flutter_todo/utils/constants.dart';
import 'package:flutter_todo/views/home/components/home_app_bar.dart';
import 'package:flutter_todo/views/home/components/slider_drawer.dart';
import 'package:flutter_todo/views/home/widget/fab.dart';
import 'package:flutter_todo/views/home/widget/task_widget.dart';
import 'package:lottie/lottie.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final GlobalKey<SliderDrawerState> drawerKey = GlobalKey<SliderDrawerState>();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    final base = BaseWidget.of(context);

    return ValueListenableBuilder(
      valueListenable: base.dataStore.listenToTask(),
      builder: (ctx, Box<Task> box, Widget? child) {
        var tasks = box.values.toList();

        tasks.sort((a, b) => a.createdAtDate.compareTo(b.createdAtDate));

        return Scaffold(
          backgroundColor: Colors.white,

          // Floating Action Button
          floatingActionButton: const Fab(),

          // Body
          body: SliderDrawer(
            key: drawerKey,
            isDraggable: false,
            animationDuration: 1000,

            // Drawer
            slider: CustomDrawer(),

            appBar: HomeAppBar(drawerKey: drawerKey),

            // Main Body
            child: _buildHomeBody(textTheme, base, tasks),
          ),
        );
      },
    );
  }

  Widget _buildHomeBody(
    TextTheme textTheme,
    BaseWidget base,
    List<Task> tasks,
  ) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          // Custom App Bar
          Container(
            margin: const EdgeInsets.only(top: 60),
            width: double.infinity,
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Progress Indicator
                SizedBox(
                  width: 30,
                  height: 30,
                  child: const CircularProgressIndicator(
                    value: 1 / 3,
                    backgroundColor: Colors.grey,
                    valueColor: AlwaysStoppedAnimation(AppColors.primaryColor),
                  ),
                ),

                25.w,

                // Top level Task Info
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppStr.mainTitle, style: textTheme.displayLarge),
                    3.h,
                    Text("1 of 3 tasks", style: textTheme.titleMedium),
                  ],
                ),
              ],
            ),
          ),

          // Divider
          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Divider(thickness: 2, indent: 100),
          ),

          // Tasks
          SizedBox(
            width: double.infinity,
            height: 585,
            child:
                tasks.isNotEmpty
                    ? ListView.builder(
                      itemCount: tasks.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        var task = tasks[index];

                        return Dismissible(
                          direction: DismissDirection.horizontal,
                          onDismissed: (_) {
                            // remove current task from DB
                            base.dataStore.deleteTask(task: task);
                          },
                          background: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.delete_outline, color: Colors.grey),
                              8.w,
                              const Text(
                                AppStr.deletedTask,
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          key: Key(task.id),
                          child: TaskWidget(task: task),
                        );
                      },
                    )
                    // Task list is empty
                    : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Lottie animation
                        FadeIn(
                          child: SizedBox(
                            width: 200,
                            height: 200,
                            child: Lottie.asset(
                              lottieURL,
                              animate: tasks.isNotEmpty ? false : true,
                            ),
                          ),
                        ),

                        // Subtext
                        FadeInUp(
                          from: 30,
                          child: const Text(AppStr.doneAllTask),
                        ),
                      ],
                    ),
          ),
        ],
      ),
    );
  }
}
