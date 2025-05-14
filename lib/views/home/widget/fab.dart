import "dart:developer";

import "package:flutter/material.dart";
import "package:flutter_todo/utils/app_colors.dart";

class Fab extends StatelessWidget {
  const Fab({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // navigate to task view
        log("task view");
      },
      child: Material(
        borderRadius: BorderRadius.circular(15),
        elevation: 10, // shadow
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(child: Icon(Icons.add, color: Colors.white)),
        ),
      ),
    );
  }
}
