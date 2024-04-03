import 'package:flutter/material.dart';

class MpinAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPress;
  final VoidCallback? onMorePress;

  const MpinAppBar({
    super.key,
    required this.title,
    this.onBackPress,
    this.onMorePress,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Align(
        alignment: Alignment.centerLeft,
        child: Text(title),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(2.0), // Adjust the height as needed
        child: Divider(
          height: 2.0, // Adjust the height to match preferredSize
          color: Theme.of(context).colorScheme.primary, // Set the color of the underline
          thickness: 2.0, // Set the thickness of the underline
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: onBackPress,
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: onMorePress,
        ),
      ],
    );
  }
}
