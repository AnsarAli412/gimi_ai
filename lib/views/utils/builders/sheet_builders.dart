import 'package:flutter/material.dart';

class SheetBuilders{
  Future<T?> showTopModalSheet<T>(
      BuildContext context,
      Widget child, {
        bool barrierDismissible = true,
        BorderRadiusGeometry? borderRadius,
      }) {
    return showGeneralDialog<T?>(
      context: context,
      barrierDismissible: barrierDismissible,
      transitionDuration: const Duration(milliseconds: 250),
      barrierLabel: MaterialLocalizations.of(context).dialogLabel,
      barrierColor: Colors.black.withOpacity(0.5),
      pageBuilder: (context, _, __) => child,
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: CurvedAnimation(parent: animation, curve: Curves.easeOutCubic)
              .drive(
              Tween<Offset>(begin: const Offset(0, -1.0), end: Offset.zero)),
          child: Column(
            children: [
              Material(
                borderRadius: borderRadius,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [child],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  showDialogOnTop(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext ext) {
          return const Dialog(
            alignment: Alignment.topLeft,
            child: ListTile(
              dense: true,
              title: Text(
                "Alert!",
              ),
            ),
          );
        });
  }
}