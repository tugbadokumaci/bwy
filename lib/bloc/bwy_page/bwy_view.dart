import 'package:bwy/utils/box_constants.dart';
import 'package:bwy/utils/custom_colors.dart';
import 'package:bwy/widget/box.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../size_config.dart';
import '../../widget/container.dart';
import '../../widget/fabs.dart';
import '../home_page/home_view.dart';

class BwyView extends StatefulWidget {
  const BwyView({super.key});

  @override
  State<BwyView> createState() => _BwyViewState();
}

class _BwyViewState extends State<BwyView> {
  List<bool> expansionStates = List.generate(3, (index) => false);
  int _selectedIndex = Pages.ABOUTUS.index;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.w600, color: Colors.white);
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Ana Sayfa', style: optionStyle),
    Text('Hakkımızda', style: optionStyle),
    Text('İletişim', style: optionStyle),
    Text('Hesabım', style: optionStyle),
  ];

  // final Text _headerTitle =
  //     Text('Bursa Web Yazılım olarak 1997 yılından beri birlikte çalıştığımız işletmelere kesintisiz ve entegre web tasarım, SEO ve yazılım çözüm ürünleri sunuyoruz. ');

  final Text _headerTitle = Text(
      'Bursa Web Yazılım olarak 1997 yılından beri birlikte çalıştığımız işletmelere kesintisiz ve entegre web tasarım, SEO ve yazılım çözüm ürünleri sunuyoruz.',
      style: TextStyle(color: Colors.white, fontSize: SizeConfig.defaultSize! * 2.2, fontWeight: FontWeight.w400));
  final Text _headerSubTitle = Text('Ekibimiz ve tecrübemizle başlamaya hazırız.',
      style: TextStyle(
          color: Colors.white,
          fontSize: SizeConfig.defaultSize! * 2.2,
          fontWeight: FontWeight.w400)); // final RichText _headerTitle = RichText(
  //   text: TextSpan(
  //     style: const TextStyle(
  //       fontSize: 14.0,
  //       color: Colors.black,
  //     ),
  //     children: <TextSpan>[
  //       TextSpan(
  //           text:
  //               'Bursa Web Yazılım olarak 1997 yılından beri birlikte çalıştığımız işletmelere kesintisiz ve entegre ',
  //           style: CustomTextStyles().titleTextStyle()),
  //       TextSpan(text: 'web tasarım', style: CustomTextStyles(isBold: true).titleTextStyle()),
  //       TextSpan(text: ', ', style: CustomTextStyles().titleTextStyle()),
  //       TextSpan(text: 'SEO', style: CustomTextStyles(isBold: true).titleTextStyle()),
  //       TextSpan(text: ' ve ', style: CustomTextStyles().titleTextStyle()),
  //       TextSpan(text: 'yazılım', style: CustomTextStyles(isBold: true).titleTextStyle()),
  //       TextSpan(text: ' çözüm ürünleri sunuyoruz.', style: CustomTextStyles().titleTextStyle()),
  //     ],
  //   ),
  // );

  @override
  Widget build(BuildContext context) {
    return _buildScaffold(context);
  }

  SafeArea _buildScaffold(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Hakkımızda',
            style: TextStyle(
                fontFamily: 'REM',
                color: Colors.white,
                fontSize: SizeConfig.defaultSize! * 2.4,
                fontWeight: FontWeight.bold)),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.black,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FABs.buildMessageFab(context),
      body: SingleChildScrollView(
        child: _buildBody(context),
      ),
      bottomNavigationBar: _bottomNavigationBar(context),
    ));
  }

  Container _bottomNavigationBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.white.withOpacity(.1), // beyaza cevir
          )
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
            rippleColor: Colors.grey[300]!,
            hoverColor: Colors.grey[100]!,
            gap: 8,
            activeColor: Colors.white,
            iconSize: 24,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: const Duration(milliseconds: 400),
            tabBackgroundColor: const Color(0xff222023),
            color: Colors.grey,
            tabs: const [
              GButton(
                icon: Icons.dashboard_outlined,
                text: 'Ana Sayfa',
              ),
              GButton(
                icon: Icons.computer_outlined,
                text: 'Hakkımızda',
              ),
              GButton(
                icon: Icons.phone_outlined,
                text: 'İletişim',
              ),
              GButton(
                icon: Icons.person_outline,
                text: 'Hesabım',
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
              switch (index) {
                case 0:
                  Navigator.pushNamed(context, '/home');
                case 1:
                  Navigator.pushNamed(context, '/bwy');
                case 2:
                  Navigator.pushNamed(context, '/contact');
                case 3:
                  Navigator.pushNamed(context, '/profile');
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Box(size: BoxSize.SMALL, type: BoxType.VERTICAL),
          _headerContainer(),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text('Hizmetlerimiz',
                  style: TextStyle(
                      color: Colors.white, fontSize: SizeConfig.defaultSize! * 2.2, fontWeight: FontWeight.bold))),
          serviceExpansionTile('Hosting', 'Bu bir hosting hizmetidir.', 0, CustomColors.bwyYellowPastel),
          Box(size: BoxSize.SMALL, type: BoxType.VERTICAL),
          serviceExpansionTile('Domain', 'Bu bir domain hizmetidir.', 1, CustomColors.bwyRedPastel),
          Box(size: BoxSize.SMALL, type: BoxType.VERTICAL),
          serviceExpansionTile('Tasarım', 'Bu bir tasarım hizmetidir.', 2, CustomColors.bwyGreenPastel),
        ],
      ),
    );
  }

  Widget serviceExpansionTile(String title, String description, int index, Color activeColor) {
    return MyContainer(
      // backgroundColor: expansionStates[index] ? activeColor : null,
      child: ExpansionTile(
        title: Text(title,
            style: TextStyle(
                color: expansionStates[index] ? activeColor : Colors.white,
                fontSize: SizeConfig.defaultSize! * 2,
                fontWeight: FontWeight.bold)),
        children: [
          ListTile(
              title: Text(description,
                  style: TextStyle(
                      color: Colors.white, fontSize: SizeConfig.defaultSize! * 1.8, fontWeight: FontWeight.bold)))
        ],
        onExpansionChanged: (bool expanded) {
          setState(() {
            expansionStates[index] = expanded;
          });
        },
      ),
    );
  }

  Widget _headerContainer() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset('assets/images/bwy_header_about_us1.png', height: 360, fit: BoxFit.fitHeight),
        ),
        Positioned(
          top: 24,
          left: 24,
          child: Container(width: 290, child: _headerTitle),
        ),
        Positioned(
          left: 24,
          bottom: 120,
          child: Container(width: 290, child: _headerSubTitle),
        ),
        Positioned(
            bottom: 50,
            left: 24,
            child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                    backgroundColor: Color(0xff47A979),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                child: Row(
                  children: [
                    SizedBox(width: 3),
                    Text('Bizimle Bugün Başlayın',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: SizeConfig.defaultSize! * 1.8,
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(width: 3),
                    Icon(Icons.arrow_circle_right, size: 30, color: Colors.white)
                  ],
                ))),
      ],
    );
  }
}
