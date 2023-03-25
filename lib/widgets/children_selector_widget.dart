import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:grouu/data/sqlite/db/database.dart';
import 'package:grouu/stores/children/children_store.dart';
import 'package:iconly/iconly.dart';

class ChildrenSelectorWidget extends StatelessWidget {
  const ChildrenSelectorWidget({
    Key? key,
    required ChildrenStore childrenStore,
  })  : _childrenStore = childrenStore,
        super(key: key);

  final ChildrenStore _childrenStore;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      List<Children> childrens = _childrenStore.childrens as List<Children>;
      return DecoratedBox(
        decoration: ShapeDecoration(
          color: Color(0xfff6f6f6),
          shape: RoundedRectangleBorder(
            side: BorderSide(
                width: 1.0, style: BorderStyle.solid, color: Color(0xffE1E1E1)),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: DropdownButton<String>(
            isExpanded: true,
            value: _childrenStore.selectedChildrenId.toString(),
            icon: const Icon(IconlyLight.arrow_down_2),
            elevation: 0,
            underline: SizedBox(),
            onChanged: (String? value) {
              _childrenStore.selectChildren(childrens.firstWhere(
                  (Children element) => element.id.toString() == value));
            },
            items: childrens.map<DropdownMenuItem<String>>((children) {
              return DropdownMenuItem<String>(
                value: children.id.toString(),
                child: Text("${children.firstName} ${children.lastName}"),
              );
            }).toList(),
          ),
        ),
      );
    });
  }
}
