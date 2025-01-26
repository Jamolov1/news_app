import 'package:flutter/material.dart';

import 'package:news_app/pages/login_page.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  int currentIndex = 0;
  PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          PageView(
              controller: _controller,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              children: [
                item_intro(image: "assets/intro_1.png"),
                item_intro(image: "assets/intro_2.png"),
                item_intro(image: "assets/intro_3.png"),
              ]),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Row(
              children: buildIndecator(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {
                    _controller.animateToPage(currentIndex - 1,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeIn);
                  },
                  child: Text(
                    "Back",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )),
              currentIndex == 2
                  ? InkWell(
                      onTap: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) {
                          return LoginPage();
                        }));
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 30, bottom: 20),
                        height: 50,
                        width: 120,
                        child: Center(
                          child: Text(
                            "Get Started",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Color(0xFF1877F2),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        _controller.animateToPage(currentIndex + 1,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 30, bottom: 20),
                        height: 50,
                        width: 80,
                        child: Center(
                          child: Text(
                            "Next",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Color(0xFF1877F2),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }

  Widget item_intro({image}) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.6,
          width: double.infinity,
          child: Image.asset(
            image,
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(
              left: 20,
              top: 20,
              right: 60,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Lorem Ipsum is simply dummy",
                  style: TextStyle(
                    color: Color(0xFF000000),
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                Text(
                  "Lorem Ipsum is simply dummy text of the printing and typessoting industry.",
                  style: TextStyle(
                    color: Color(0xFF4E4B66),
                    fontSize: 20,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _indicator(isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      height: 20,
      width: 20,
      margin: EdgeInsets.only(right: 6),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? Color(0xFF1877F2) : Color(0xFFA0A3BD),
      ),
    );
  }

  List<Widget> buildIndecator() {
    List<Widget> indecators = [];
    for (int i = 0; i < 3; i++) {
      if (currentIndex == i) {
        indecators.add(_indicator(true));
      } else {
        indecators.add(_indicator(false));
      }
    }
    return indecators;
  }
}
