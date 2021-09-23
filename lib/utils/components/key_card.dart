import 'package:flutter/material.dart';
import 'package:flutter_balcoder_medicalapp/utils/constant.dart';

class KeyCard extends StatelessWidget {
  KeyCard(
      {required this.isEmpty,
      required this.nameKey,
      required this.createdDate,
      required this.descriptionKey,
      required this.position,
      required this.onTap});

  final bool isEmpty;
  final String nameKey;
  final String createdDate;
  final String descriptionKey;
  final int position;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
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
                  height: 80,
                  width: 36,
                  child: Container(
                    decoration: BoxDecoration(
                        color: isEmpty ? kSubTextColor : kPrimaryColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        )),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: ListTile(
                  leading: !isEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Icon(
                            Icons.bluetooth,
                            color: kPrimaryColor,
                            size: 32,
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Container(
                            height: 32,
                            width: 32,
                            child: Center(
                              child: Icon(
                                Icons.add,
                                size: 28,
                                color: kPrimaryLightColor,
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: kbackGroundDark,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                          ),
                        ),
                  trailing: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        height: 32,
                        width: 32,
                        child: Center(
                          child: Icon(
                            Icons.read_more_rounded,
                            size: 28,
                            color: kPrimaryLightColor,
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: isEmpty ? kSubTextColor : kbackGroundDark,
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                      ),
                    ),
                  ),
                  title: Padding(
                    padding: isEmpty
                        ? const EdgeInsets.only(top: 0.0)
                        : const EdgeInsets.only(top: 12.0),
                    child: isEmpty
                        ? Center(
                            child: RichText(
                              text: TextSpan(
                                  text: 'Agregar    ',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600, // light
                                      color: kTextColor),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'Nuevo Dispositivo.',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600, // light
                                          color: kSubTextColor),
                                    )
                                  ]),
                            ),
                          )
                        : Text(
                            nameKey,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600, // light
                                color: kTextColor),
                          ),
                  ),
                  subtitle: !isEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: RichText(
                            text: TextSpan(
                                text: 'Agregada el ' + createdDate + ' \n',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600, // light
                                    color: kSubTextColor),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: descriptionKey,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600, // light
                                        color: kSubTextColor),
                                  )
                                ]),
                          ),
                        )
                      : Container(
                          height: 1.0,
                        ),
                ),
              ),
            ],
          ),
          height: 80,
          decoration: BoxDecoration(
              color: kPrimaryLightColor,
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
      ),
    );
  }
}
