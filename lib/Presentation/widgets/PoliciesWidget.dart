import 'package:flutter/material.dart';

class PoliciesWidget extends StatelessWidget {
  List<String> _list = [];
  String _title = "";
  PoliciesWidget({super.key, required List<String> list, required String title}) {
    _list = list;
    _title = title;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    List<Widget> widgets = _list.map((item) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:  const EdgeInsets.only(top: 3),
              child: Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                  color: theme.textTheme.headlineLarge?.color,
                  borderRadius: BorderRadius.circular(4), // Adjust the radius as needed
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(item,
                style: theme.textTheme.bodySmall)
          ],
        ),
      );
    }).toList();
    widgets.insert(0, Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(_title),
    ));

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widgets
    );
  }
}
