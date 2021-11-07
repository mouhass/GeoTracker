import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'home_page.dart';
import 'button_widget.dart';

var listPagesViewModel = [
  PageViewModel(
    title: "Find your current position",
    body: "",
    image:
        Center(child: Image.asset("assets/positions_logo.png", height: 250.0)),
  ),
  PageViewModel(
    title: "and start tracking your movements in real time",
    body: "",
    image: Center(child: Image.asset("assets/path.png", height: 250.0)),
    //decoration: const PageDecoration(
    //  pageColor: Colors.blue,
    //),
  ),
];

class OnBoardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SafeArea(
          child: IntroductionScreen(
        pages: listPagesViewModel,
        onDone: () => goToHome(context),
        onSkip: () => goToHome(context),
        showSkipButton: true,
        skip: const Icon(Icons.skip_next),
        next: const Icon(Icons.arrow_forward),
        done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
        dotsDecorator: DotsDecorator(
            size: const Size.square(10.0),
            activeSize: const Size(20.0, 10.0),
            // activeColor: theme.accentColor,
            color: Colors.black26,
            spacing: const EdgeInsets.symmetric(horizontal: 3.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0))),
      ));

  void goToHome(context) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => HomePage()),
      );

  Widget buildImage(String path) =>
      Center(child: Image.asset(path, width: 350));

  DotsDecorator getDotDecoration() => DotsDecorator(
        color: Color(0xFFBDBDBD),
        //activeColor: Colors.orange,
        size: Size(10, 10),
        activeSize: Size(22, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      );

  PageDecoration getPageDecoration() => PageDecoration(
        titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        bodyTextStyle: TextStyle(fontSize: 20),
        descriptionPadding: EdgeInsets.all(16).copyWith(bottom: 0),
        imagePadding: EdgeInsets.all(24),
        pageColor: Colors.white,
      );
}
