import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task/OTP/onboarding_item.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task/OTP/sign_up.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = OnboardingItems();
  final pageController = PageController();
  final int totalPages = 3;

  @override
  Widget build(Object context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints(
          maxWidth: 400, // Limit the maximum width
        ),
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: PageView.builder(
            itemCount: controller.items.length,
            controller: pageController,
            itemBuilder: ((context, index) {
              return Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 50, bottom: 50.0),
                    child: SvgPicture.asset(
                      controller.items[index].logo,
                      width: 170,
                      height: 70,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 50.0, bottom: 10.0),
                        child: SvgPicture.asset(
                          controller.items[index].image,
                          width: 280,
                          height: 290,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        controller.items[index].title,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(36, 36, 36, 1),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        controller.items[index].descriptions,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                            color: Color.fromRGBO(101, 101, 101, 3)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (index == totalPages - 1)
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SignUpPage()), // Navigate to SignUpPage
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Color.fromRGBO(36, 36, 36, 1),
                        backgroundColor: Color.fromRGBO(0, 99, 123, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      child: Text(
                        "Get started !",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                ],
              );
            })),
      ),
    );
  }
}
