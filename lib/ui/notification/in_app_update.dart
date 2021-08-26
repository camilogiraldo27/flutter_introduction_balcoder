import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_balcoder_medicalapp/ui/boarding/model/onboard_page_item.dart';
import 'package:flutter_balcoder_medicalapp/utils/components/fade_animation.dart';
import 'package:flutter_balcoder_medicalapp/utils/constant.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class InAppUpdatePage extends StatefulWidget {
  final OnboardPageItem onboardPageItem;

  InAppUpdatePage({required this.onboardPageItem});

  @override
  _OnboardState createState() => _OnboardState();
}

class _OnboardState extends State<InAppUpdatePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: height * 0.1),
        child: Column(
          children: <Widget>[
            Lottie.asset(
              widget.onboardPageItem.lottieAsset,
              controller: _animationController,
              onLoaded: (composition) {
                _animationController
                  ..duration = composition.duration
                  ..forward()
                  ..addListener(() {
                    if (widget.onboardPageItem.animationDuration != null) {
                      if (_animationController.lastElapsedDuration! >
                          widget.onboardPageItem.animationDuration!) {
                        _animationController.stop();
                      }
                    }
                  });
              },
              width: width * 0.9,
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: FadeAnimation(
                fadeDirection: FadeDirection.top,
                delay: 2,
                child: Text(
                  widget.onboardPageItem.text,
                  style: TextStyle(
                    fontSize: width * 0.05,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            FadeAnimation(
              fadeDirection: FadeDirection.bottom,
              delay: 2.3,
              child: Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: FloatingActionButton(
                  backgroundColor: kPrimaryColor,
                  child: Icon(
                    Icons.download_rounded,
                    color: Colors.white,
                  ),
                  onPressed: () => setState(() {
                    try {
                      launch("https://appdistribution.firebase.google.com/pub/i/4015fd911304e468");
                    } on PlatformException catch (e) {
                      launch(
                          "https://appdistribution.firebase.google.com/pub/i/4015fd911304e468");
                    } finally {
                      launch("https://appdistribution.firebase.google.com/pub/i/4015fd911304e468");
                    }
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
