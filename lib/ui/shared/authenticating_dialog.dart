import 'package:flutter/material.dart';
import 'package:americonictv_tv/ui/shared/focusable_button.dart';

class AuthenticatingDialog extends StatelessWidget {
  final String label;

  AuthenticatingDialog({@required this.label});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / 4,
        ),
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    label,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FocusableButton(
                      width: 160,
                      height: 48,
                      autofocus: true,
                      label: 'TRY AGAIN',
                      color: Colors.black26,
                      onTap: () => Navigator.pop(context, false),
                    ),

                    FocusableButton(
                      width: 160,
                      height: 48,
                      label: 'CANCEL',
                      color: Colors.black26,
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pop(context, false);
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
