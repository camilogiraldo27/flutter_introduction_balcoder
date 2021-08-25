import 'package:flutter/material.dart';
import 'package:flutter_balcoder_medicalapp/utils/constant.dart';

class TripCard extends StatelessWidget {
  TripCard(
      {required this.showSetting,
      required this.title,
      required this.subTitle,
      required this.onTap,
      required this.onSetting});

  bool showSetting;
  final String title;
  final String subTitle;
  final VoidCallback onTap;
  final VoidCallback onSetting;

  @override
  Widget build(BuildContext context) {
    showSetting = showSetting != null ? showSetting : false;
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          child: Stack(
            overflow: Overflow.clip,
            alignment: Alignment.topRight,
            children: [
              Positioned(
                  height: 160,
                  width: 36,
                  child: Container(
                    decoration: BoxDecoration(
                        color: (showSetting != null ? showSetting : false)
                            ? kSubTextColor
                            : kPrimaryColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        )),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Icon(
                        Icons.motorcycle_outlined,
                        color: kPrimaryColor,
                        size: 32,
                      ),
                    ),
                    trailing: (showSetting != null ? showSetting : false)
                        ? Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: GestureDetector(
                                onTap: onSetting,
                                child: Container(
                                  height: 32,
                                  width: 32,
                                  child: Center(
                                    child: Icon(
                                      Icons.settings,
                                      size: 28,
                                      color: kPrimaryLightColor,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      color: (showSetting != null
                                              ? showSetting
                                              : false)
                                          ? kSubTextColor
                                          : kbackGroundDark,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50))),
                                ),
                              ),
                            ),
                          )
                        : Container(
                            width: 1,
                          ),
                    title: Padding(
                      padding: (showSetting != null ? showSetting : false)
                          ? const EdgeInsets.only(top: 0.0)
                          : const EdgeInsets.only(top: 12.0),
                      child: Text(
                        title,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600, // light
                            color: kTextColor),
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: RichText(
                        text: TextSpan(
                            text: ' ',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600, // light
                                color: kSubTextColor),
                            children: <TextSpan>[
                              TextSpan(
                                text: subTitle,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600, // light
                                    color: kSubTextColor),
                              )
                            ]),
                      ),
                    )),
              ),
            ],
          ),
          height: 160,
          decoration: BoxDecoration(
              color: kPrimaryLightColor,
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
      ),
    );
  }
}
