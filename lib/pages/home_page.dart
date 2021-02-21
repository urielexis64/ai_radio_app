import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:radio_app/model/radio.dart';
import 'package:radio_app/utils/ai_utils.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MyRadio> radios;

  @override
  void initState() {
    super.initState();
    fetchRadios();
  }

  fetchRadios() async {
    final radioJson = await rootBundle.loadString('assets/radio.json');
    radios = MyRadioList.fromJson(radioJson).radios;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      body: Stack(
        children: [
          VxAnimatedBox()
              .size(context.screenWidth, context.screenHeight)
              .withGradient(LinearGradient(
                  colors: [AIColors.primaryColor1, AIColors.primaryColor2],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight))
              .make(),
          AppBar(
            title: "AI Radio"
                .text
                .xl4
                .bold
                .white
                .make()
                .shimmer(
                    primaryColor: Vx.purple300, secondaryColor: Colors.white)
                .p16(),
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
          ),
          VxSwiper.builder(
              itemCount: radios.length,
              aspectRatio: 1.0,
              enlargeCenterPage: true,
              itemBuilder: (context, index) {
                final rad = radios[index];
                return VxBox(
                        child: ZStack([
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: VStack(
                      [
                        rad.name.text.xl3.white.bold.make(),
                        5.heightBox,
                        rad.tagline.text.sm.white.semiBold.make()
                      ],
                      crossAlignment: CrossAxisAlignment.center,
                    ),
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: [
                        Icon(
                          CupertinoIcons.play_circle,
                          color: Colors.white,
                        ),
                        10.heightBox,
                        "Double tap to play".text.gray300.make()
                      ].vStack()),
                ]))
                    .bgImage(DecorationImage(
                        image: NetworkImage(rad.image),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.3), BlendMode.darken)))
                    .border(color: Colors.black, width: 2)
                    .withRounded(value: 60)
                    .make()
                    .p16()
                    .centered();
              })
        ],
        fit: StackFit.expand,
      ),
    );
  }
}
