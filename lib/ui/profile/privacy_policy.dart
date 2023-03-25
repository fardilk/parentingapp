import 'package:flutter/material.dart';
import 'package:grouu/constants/font_family.dart';
import 'package:grouu/widgets/back_appbar_widget.dart';

class PrivacyScreen extends StatelessWidget {
  PrivacyScreen({super.key});

  final List<String> listPolicy = [
    "Had repulsive dashwoods suspicion sincerity but advantage now him. Remark easily garret nor nay. Civil those mrs enjoy shy fat merry. You greatest jointure saw horrible. He private he on be imagine suppose. Fertile beloved evident through no service elderly is. Blind there if every no so at. ",
    "Own neglected you preferred way sincerity delivered his attempted. To of message cottage windows do besides against uncivil.His followed carriage proposal entrance directly had elegance. Greater for cottage gay parties natural. Remaining he furniture on he discourse suspected perpetual. Power dried her taken place day ought the. Four and our ham west miss. ",
    "Education shameless who middleton agreement how. We in found world chief is at means weeks smile.Increasing impression interested expression he my at. Respect invited request charmed me warrant to. Expect no pretty as do though so genius afraid cousin. Girl when of ye snug poor draw. ",
    "Mistake totally of in chiefly. Justice visitor him entered for. Continue delicate as unlocked entirely mr relation diverted in. ",
    "Known not end fully being style house. An whom down kept lain name so at easy."
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BackAppBar(title: Text("Privacy Policy")),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildContentScroll(children: [
                Text(
                  "Privacy Policy",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      fontFamily: FontFamily.candyCake,
                      color: Color(0xff3E3C3C)),
                ),
                SizedBox(height: 16),
                ...List.generate(listPolicy.length, (index) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${index + 1}. ",
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.5,
                          fontWeight: FontWeight.w400,
                          fontFamily: FontFamily.avenirLTStd,
                          color: Color(0xff242424),
                        ),
                      ),
                      Expanded(
                          child: Text(
                        listPolicy[index],
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.5,
                          fontWeight: FontWeight.w400,
                          fontFamily: FontFamily.avenirLTStd,
                          color: Color(0xff242424),
                        ),
                      )),
                    ],
                  );
                })
              ]),
            ],
          ),
        ],
      ),
    );
  }

  Expanded _buildContentScroll({required List<Widget> children}) {
    return Expanded(
      flex: 1,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRoundedTop(),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children,
              ),
            )
          ],
        ),
      ),
    );
  }

  Stack _buildRoundedTop() {
    return Stack(
      children: [
        Container(height: 16, color: Color(0xff7AD0E2)),
        Container(
          height: 16,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(16), topLeft: Radius.circular(16)),
          ),
        )
      ],
    );
  }
}
