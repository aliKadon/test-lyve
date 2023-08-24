import 'package:flutter/material.dart';

import '../../widget/dialogs/loading_dialog_widget.dart';


mixin Helpers {


  void showSnackBar(BuildContext context,
      {required String message, bool error = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: error ? Colors.red : Colors.green,
        duration: const Duration(seconds: 3),
        dismissDirection: DismissDirection.horizontal,
      ),
    );
  }

  // show loading dialog.
  void showLoadingDialog({
    required BuildContext context,
    String? title,
  }) {
    showDialog(
      context: context,
      builder: (_) => LoadingDialogWidget(
        title: title,
      ),
      barrierDismissible: false,
    );
  }
}