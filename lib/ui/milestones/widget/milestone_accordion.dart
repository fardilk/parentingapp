import 'package:flutter/material.dart';
import 'package:grouu/constants/font_family.dart';
import 'package:grouu/data/sqlite/models/milestone.dart';
import 'package:iconly/iconly.dart';
import 'package:unicons/unicons.dart';

class MilestoneAccordion extends StatefulWidget {
  final String title;
  final List<MilestoneChildren> listMilestone;
  final Function(MilestoneChildren) onSelectMilestone;
  final Widget icon;
  final Color iconBackgroundColor;

  const MilestoneAccordion({
    Key? key,
    required this.title,
    required this.listMilestone,
    required this.onSelectMilestone,
    required this.icon,
    required this.iconBackgroundColor,
  }) : super(key: key);
  @override
  _MilestoneAccordionState createState() => _MilestoneAccordionState();
}

class _MilestoneAccordionState extends State<MilestoneAccordion> {
  bool _showContent = false;

  @override
  Widget build(BuildContext context) {
    int _checked =
        widget.listMilestone.where((element) => element.checked).length;
    int _total = widget.listMilestone.length;

    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
              backgroundColor: widget.iconBackgroundColor, child: widget.icon),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontFamily: FontFamily.avenirLTStd,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "$_checked / $_total Perkembangan",
                style: TextStyle(
                  fontFamily: FontFamily.avenirLTStd,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff676767),
                ),
              ),
            ],
          ),
          trailing: IconButton(
            icon: Icon(_showContent
                ? IconlyLight.arrow_up_2
                : IconlyLight.arrow_down_2),
            onPressed: () {
              setState(() {
                _showContent = !_showContent;
              });
            },
          ),
        ),
        if (_showContent)
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: widget.listMilestone
                .map(
                  (e) => MilestoneItem(
                    milestoneChildren: e,
                    onSelect: () => widget.onSelectMilestone(e),
                  ),
                )
                .toList(),
          )
        else
          SizedBox()
      ]),
    );
  }
}

class MilestoneItem extends StatelessWidget {
  const MilestoneItem({
    Key? key,
    required this.milestoneChildren,
    required this.onSelect,
  }) : super(key: key);

  final MilestoneChildren milestoneChildren;
  final Function onSelect;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => onSelect(),
        child: Row(
          children: [
            Icon(
              UniconsSolid.check_circle,
              color: milestoneChildren.checked
                  ? Color(0xff3ED425)
                  : Color(0xffE1E1E1),
            ),
            SizedBox(width: 8),
            Expanded(
                child: Text(
              milestoneChildren.milestone.title,
              style: TextStyle(
                  color: Color(0xff676767),
                  fontFamily: FontFamily.avenirLTStd,
                  fontSize: 14),
            )),
          ],
        ));
  }
}
