import 'package:flutter/material.dart';
import 'package:flutter_balcoder_medicalapp/utils/components/default_button.dart';
import 'package:flutter_balcoder_medicalapp/utils/constant.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController controller = PageController();
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "title": "Regístrate",
      "text":
          "Accede a este increíble servicio que puede salvarte en muchos momentos",
      "image": "assets/images/Medicalapp_OnBoarding_01.png"
    },
    {
      "title": "Conecte su Dispositivo fácilmente",
      "text":
          " Contamos con Servidores en la Nube, \nsomos su aliado perfecto\n y sin restricciones",
      "image": "assets/images/Medicalapp_OnBoarding_02.png"
    },
    {
      "title": "Almacene su Información médica",
      "text": " Y píde que le envien una alerta\n a sus familiares o allegados",
      "image": "assets/images/Medicalapp_OnBoarding_03.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 51.0, right: 20.0),
              child: Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: navigationPage,
                  child: Text(
                    'Saltar',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 3,
                child: PageView.builder(
                    controller: controller,
                    onPageChanged: (value) {
                      setState(() {
                        currentPage = value;
                      });
                    },
                    itemCount: splashData.length,
                    itemBuilder: (context, index) => howToUse(index))),
            Expanded(
                child: Column(
              children: [
                Spacer(),
                DefaultButton(
                  color: kPrimaryColor,
                  text: currentPage != 2 ? "Siguiente" : "!Vamos!",
                  press: () {
                    controller.animateToPage(controller.page!.toInt() + 1,
                        duration: Duration(milliseconds: 400),
                        curve: Curves.easeIn);

                    if (currentPage == 2) {
                      navigationPage();
                    }
                  },
                ),
                Spacer()
              ],
            ))
          ],
        ),
      ),
    );
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/RootService');
  }

  Widget howToUse(index) {
    return Column(children: [
      Spacer(),
      Spacer(),
      Image.asset(
        splashData[index]["image"]!,
        width: 240,
        height: 232,
      ),
      Spacer(),
      Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) => buildDot(index: index))),
      SizedBox(
        height: 24,
      ),
      Text(
        splashData[index]["title"]!,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20),
      ),
      SizedBox(
        height: 24,
      ),
      Text(
        splashData[index]["text"]!,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18),
      ),
    ]);
  }

  AnimatedContainer buildDot({index: int}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: index == currentPage ? 20 : 6,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: currentPage == index ? kPrimaryColor : Colors.grey),
    );
  }
}
