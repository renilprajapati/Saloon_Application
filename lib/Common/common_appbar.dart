import 'package:flutter/material.dart';
import 'package:saloon_app/Common/common_colors.dart';
class CommonAppbar extends StatelessWidget {
  Widget? leading,title;
  List<Widget>? actions;
   CommonAppbar(this.leading,this.actions,this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: common_clr,
      leading:leading,
      title: title,
      actions: actions,
      centerTitle: true,
    );
  }
}
