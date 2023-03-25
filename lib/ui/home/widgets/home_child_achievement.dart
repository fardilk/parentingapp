import 'package:flutter/material.dart';
import 'package:grouu/constants/font_family.dart';

class HomeChildAchievement extends StatelessWidget {
  final bool visible;
  final String lastName;
  final int value;
  final int totalValue;
  final Function() onTap;
  const HomeChildAchievement({
    Key? key,
    required this.lastName,
    required this.value,
    required this.totalValue,
    required this.visible,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (visible && totalValue > 0) {
      return Padding(
        padding: EdgeInsets.all(16.0),
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          child: Container(
            width: MediaQuery.of(context).copyWith().size.width,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomRight,
                  child: Image.asset(
                    "assets/images/baby_girl_n_notes.png",
                    alignment: Alignment.bottomRight,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Perkembangan $lastName saat ini",
                              style: TextStyle(
                                fontFamily: FontFamily.avenirLTStd,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Color(0xFF3E3C3C),
                              ),
                            ),
                            SizedBox(height: 12),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: LinearProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Color(0xFFFFE873)),
                                value: value / totalValue,
                              ),
                            ),
                            SizedBox(height: 12),
                            Text(
                              "$value/$totalValue perkembangan",
                              style: TextStyle(
                                fontFamily: FontFamily.avenirLTStd,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Color(0xFF3E3C3C),
                              ),
                            ),
                            SizedBox(height: 12),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: Color(0xFF44BED5),
                                minimumSize: Size(100, 24),
                                padding: EdgeInsets.symmetric(vertical: 12.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadiusDirectional.circular(25),
                                ),
                              ),
                              onPressed: onTap,
                              child: Text(
                                "Yuk Stimulasi",
                                style: Theme.of(context)
                                    .textTheme
                                    .button!
                                    .copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                        fontSize: 10),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(
                        flex: 1,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }
}
