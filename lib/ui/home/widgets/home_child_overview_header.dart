import 'package:flutter/material.dart';
import 'package:grouu/constants/font_family.dart';
import 'package:grouu/data/local/constants/data_constants.dart';
import 'package:grouu/data/sqlite/db/database.dart';
import 'package:grouu/utils/locale/wording_utils.dart';
import 'package:iconly/iconly.dart';

class HomeChildOverviewHeader extends StatelessWidget {
  final bool visible;
  final Children? children;
  final bool isItem;
  final Function() onTap;
  const HomeChildOverviewHeader({
    Key? key,
    required this.visible,
    required this.onTap,
    required this.children,
    required this.isItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (visible) {
      return Container(
        color: isItem ? null : Color(0xff7AD0E2),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: InkWell(
            onTap: isItem ? onTap : () {},
            child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: _childOverview()),
          ),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  Padding _childOverview() {
    final double circleRadius = 62.0;
    final double circleBorderWidth = 3.0;
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.centerRight,
            children: [
              Padding(
                padding: EdgeInsets.only(right: circleRadius / 2),
                child: Container(
                  color: children?.gender == DataConstants.MALE
                      ? Color(0xFFDEF4F8)
                      : Color(0xFFFCE2E9),
                  width: 48,
                  height: 100,
                ),
              ),
              Container(
                width: circleRadius,
                height: circleRadius,
                decoration: ShapeDecoration(
                    shape: CircleBorder(), color: Color(0xFFF6F6F6)),
                child: Padding(
                  padding: EdgeInsets.all(circleBorderWidth),
                  child: DecoratedBox(
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: CircleBorder(),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: children?.gender == DataConstants.MALE
                            ? AssetImage("assets/images/baby_boy_profile.png")
                            : AssetImage("assets/images/baby_girl_profile.png"),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${children?.firstName} ${children?.lastName}",
                    style: TextStyle(
                      fontFamily: FontFamily.avenirLTStd,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xff13B2CC),
                    ),
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  Text(
                    WordingUtils.getAge(children?.birthday ?? DateTime.now()),
                    style: TextStyle(
                      fontFamily: FontFamily.avenirLTStd,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Color(0xff535151),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: !isItem,
            child: InkWell(
              onTap: onTap,
              child: Icon(
                IconlyBold.arrow_down_circle,
                size: 32,
                color: children?.gender == DataConstants.MALE
                    ? Color(0xff44BED5)
                    : Color(0xffEA5782),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
