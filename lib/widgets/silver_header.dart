import 'package:flutter/material.dart';

class SilverHeader extends StatelessWidget {
  SilverHeader({
    this.name,
    this.type,
    this.totalSelected,
    this.more: false,
    this.funcDelete,
    this.refresh,
  });

  final String name;
  final int type;
  final int totalSelected;
  final bool more;
  final funcDelete, refresh;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: more ? Color(0xffff4757) : Color(0xfffafafa),
      centerTitle: false,
      title: Text(
        more ? "$totalSelected selected" : name,
        style: TextStyle(
            fontSize: more ? 18 : 24, color: Colors.black, fontFamily: "CB"),
      ),
      floating: true,
      snap: true,
      actions: <Widget>[
        more
            ? IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  funcDelete();
                  refresh();
                })
            : IconButton(
                icon: Icon(
                  Icons.search,
                  color: Color(0xff2f3542),
                ),
                onPressed: () {}),
        SizedBox(width: 10)
      ],
    );
  }
}
