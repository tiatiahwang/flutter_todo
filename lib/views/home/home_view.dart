import 'package:flutter/material.dart';
import 'package:flutter_todo/extensions/space_exs.dart';
import 'package:flutter_todo/utils/app_colors.dart';
import 'package:flutter_todo/utils/app_str.dart';
import 'package:flutter_todo/views/home/widget/fab.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white,

      // FAB
      floatingActionButton: const Fab(),

      // Body
      body: SafeArea(
        child: SingleChildScrollView(
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
                        valueColor: AlwaysStoppedAnimation(
                          AppColors.primaryColor,
                        ),
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
                height: 745,
                child: ListView.builder(
                  itemCount: 20,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // navigate to task detail view
                      },
                      child: AnimatedContainer(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withValues(alpha: 0.1),
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
                            },
                            child: AnimatedContainer(
                              width: 30,
                              height: 30,
                              duration: const Duration(milliseconds: 600),
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 0.8,
                                ),
                              ),
                              child: Icon(Icons.check, color: Colors.white),
                            ),
                          ),

                          // Task title
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 5, top: 3),
                            child: Text(
                              "Done",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),

                          // Task description
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Description",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),

                          // Date of task
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Date",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                "SubDate",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
