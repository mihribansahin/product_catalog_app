import 'package:flutter/material.dart';
import 'package:product_catalog_app/utils/constants/my_colors.dart';

class MyProductCard extends StatelessWidget {
  String cardName = " ";
  String cardDate = "";
  var handleNavigator;

  MyProductCard(
      {Key? key,
      required String this.cardName,
      required String this.cardDate,
      required var this.handleNavigator})
      : super(key: key);
  double? screenHeight, screenWidth;

  List<String> tempShowTaskList = [
    "Lorem impsum lorem impsum lorem",
    "Lorem impsum lorem impsum lorem",
    "Lorem impsum lorem impsum lorem",
    "Lorem impsum lorem impsum lorem"
  ];

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: screenHeight! * .4,
      decoration: BoxDecoration(
        color: MyColors.myPink,
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: Colors.green.shade50, //edited
            spreadRadius: 2,
            blurRadius: 2, //e,dited
          )
        ],
      ),
      child: Container(
        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Text(
                    cardName,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4),
                  ),
                  Text(
                    cardDate,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 40, top: 100),
              child: ListView(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                children: [
                  for (int i = 0; i < tempShowTaskList.length; i++)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tempShowTaskList[i],
                          style: TextStyle(
                              color: Colors.blue.shade800,
                              fontSize: 13,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              decorationColor: Colors.black,
                              decorationStyle: TextDecorationStyle.solid,
                              decoration: i % 2 == 0
                                  ? TextDecoration.lineThrough
                                  : null,
                              letterSpacing: 1),
                        ),
                        Divider(),
                      ],
                    ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: IconButton(
                  onPressed: () {
                    // open today page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => handleNavigator,
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.keyboard_arrow_down_sharp,
                    color: Colors.blueAccent.shade700,
                    size: 30,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
