import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

class HomeAppBar extends StatefulWidget {
  final GlobalKey<SliderDrawerState> drawerKey;

  const HomeAppBar({super.key, required this.drawerKey});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar>
    with SingleTickerProviderStateMixin {
  late AnimationController animatecontroller;
  bool isDrwaerOpen = false;

  @override
  void initState() {
    animatecontroller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    super.initState();
  }

  @override
  void dispose() {
    animatecontroller.dispose();
    super.dispose();
  }

  // OnToggle
  void onDrawerToggle() {
    setState(() {
      isDrwaerOpen = !isDrwaerOpen;
      if (isDrwaerOpen) {
        animatecontroller.forward();
        widget.drawerKey.currentState!.openSlider();
      } else {
        animatecontroller.reverse();
        widget.drawerKey.currentState!.closeSlider();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 130,
      child: Padding(
        padding: EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Menu icon
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: IconButton(
                onPressed: onDrawerToggle,
                icon: AnimatedIcon(
                  icon: AnimatedIcons.menu_close,
                  progress: animatecontroller,
                  size: 40,
                ),
              ),
            ),

            // Trash icon
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: IconButton(
                onPressed: () {
                  // todo: remove all tasks from db
                },
                icon: const Icon(CupertinoIcons.trash_fill, size: 40),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
