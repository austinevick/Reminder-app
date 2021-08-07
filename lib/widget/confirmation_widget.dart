import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ConfirmationBottomSheet {
  static buildBottomSheet(BuildContext context, Function onPressed,
          String title, String content) =>
      showBarModalBottomSheet(
        shape: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        context: context,
        builder: (ctx) => Container(
          height: MediaQuery.of(context).size.height / 5.5,
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '$title',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              child: Text(
                '$content',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildButton(
                    text: 'CANCEL',
                    onPressed: () => Navigator.of(context).pop()),
                buildButton(text: 'OK', onPressed: onPressed),
              ],
            )
          ]),
        ),
      );
  static buildButton({Function onPressed, String text}) => Expanded(
        child: Container(
          decoration: BoxDecoration(
              border: Border(
                  left: BorderSide(color: Colors.grey[300]),
                  top: BorderSide(color: Colors.grey[300]))),
          child: TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.all(15)),
              ),
              onPressed: onPressed,
              child: Text(
                text,
                style: TextStyle(fontSize: 18),
              )),
        ),
      );
}
