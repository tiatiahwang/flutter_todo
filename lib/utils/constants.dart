// lottie asset location
import 'package:flutter/material.dart';
import 'package:ftoast/ftoast.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:flutter_todo/utils/app_str.dart';

String lottieURL = 'assets/lottie/1.json';

// empty title or subtitle textfield warning
dynamic emptyWanring(BuildContext context) {
  return FToast.toast(
    context,
    msg: AppStr.oopsMsg,
    subMsg: 'You must fill all fields!',
    corner: 20.0,
    duration: 2000,
    padding: const EdgeInsets.all(20),
  );
}

// nothing entered when user try to edit or update the task
dynamic updateTaskWanring(BuildContext context) {
  return FToast.toast(
    context,
    msg: AppStr.oopsMsg,
    subMsg: 'You must edit task then try to update it!',
    corner: 20.0,
    duration: 5000,
    padding: const EdgeInsets.all(20),
  );
}

// no task warning when user try to delete
dynamic noTaskWarning(BuildContext context) {
  return PanaraInfoDialog.showAnimatedGrow(
    context,
    title: AppStr.oopsMsg,
    message: "No task to delete!",
    buttonText: "Okay",
    onTapDismiss: () {
      Navigator.pop(context);
    },
    panaraDialogType: PanaraDialogType.warning,
  );
}

// delete all task from db
dynamic deleteAllTasks(BuildContext context) {
  return PanaraConfirmDialog.show(
    context,
    title: AppStr.areYouSure,
    message:
        "Do you really want to delete all task? You will not be able to undo this action!",
    confirmButtonText: "Yes",
    cancelButtonText: "No",
    onTapConfirm: () {
      // BaseWidget.of(context).dataStore.box.clear();
      Navigator.pop(context);
    },
    onTapCancel: () {
      Navigator.pop(context);
    },
    panaraDialogType: PanaraDialogType.error,
    barrierDismissible: false,
  );
}
