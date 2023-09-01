import 'package:bwy/extension/string_extension.dart';
import 'package:bwy/lang/locale_keys.g.dart';
import 'package:bwy/utils/box_constants.dart';
import 'package:bwy/utils/custom_colors.dart';
import 'package:bwy/utils/custom_text_styles.dart';
import 'package:bwy/widget/box.dart';
import 'package:bwy/widget/text/locale_text.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../BottomNavBar.dart';
import '../../constants/strings.dart';
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
  List<bool> expansionStates = List.generate(5, (index) => false);
  int _selectedIndex = Pages.ABOUTUS.index;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.w600, color: Colors.white);
  static List<Widget> _widgetOptions = <Widget>[
    Text(LocaleKeys.home_appBarTitle.locale, style: optionStyle),
    Text(LocaleKeys.about_us_appBarTitle.locale, style: optionStyle),
    Text(LocaleKeys.contact_appBarTitle.locale, style: optionStyle),
    Text(LocaleKeys.profile_appBarTitle.locale, style: optionStyle),
  ];

  // final Text _headerTitle =
  //     Text('Bursa Web Yazılım olarak 1997 yılından beri birlikte çalıştığımız işletmelere kesintisiz ve entegre web tasarım, SEO ve yazılım çözüm ürünleri sunuyoruz. ');

  final Text _headerTitle = Text(LocaleKeys.about_us_headerTitle.locale,
      style: CustomTextStyles.titleSmallTextStyle().copyWith(fontWeight: FontWeight.w400));
  final Text _headerSubTitle = Text(LocaleKeys.about_us_headerSubTitle.locale,
      style: CustomTextStyles.titleSmallTextStyle().copyWith(fontWeight: FontWeight.w400));

  @override
  Widget build(BuildContext context) {
    final int focusIndex = ModalRoute.of(context)!.settings.arguments as int;

    return _buildScaffold(context, focusIndex);
  }

  SafeArea _buildScaffold(BuildContext context, int focusIndex) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.about_us_appBarTitle.locale, style: CustomTextStyles.appBarTitleTextStyle()),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.black,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FABs.buildMessageFab(context),
      body: SingleChildScrollView(
        child: _buildBody(context, focusIndex),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        onTabChange: (int index) {
          setState(() {
            _selectedIndex = index;
          });
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/home');
            case 1:
              Navigator.pushNamed(context, '/bwy', arguments: -1);
            case 2:
              Navigator.pushNamed(context, '/contact');
            case 3:
              Navigator.pushNamed(context, '/profile');
          }
        },
        selectedIndex: _selectedIndex,
      ),
    ));
  }

  Widget _buildBody(BuildContext context, int focusIndex) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Box(size: BoxSize.SMALL, type: BoxType.VERTICAL),
          _headerContainer(),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(LocaleKeys.about_us_services.locale, style: CustomTextStyles.titleMediumTextStyle())),
          serviceExpansionTile(
              Strings.service1Title, Strings.service1Description, 0, 0 == focusIndex, Color(0xff88B14B)),
          Box(size: BoxSize.SMALL, type: BoxType.VERTICAL),
          serviceExpansionTile(
              Strings.service2Title, Strings.service2Description, 1, 1 == focusIndex, Color(0xff88B14B)),
          Box(size: BoxSize.SMALL, type: BoxType.VERTICAL),
          serviceExpansionTile(
              Strings.service3Title, Strings.service3Description, 2, 2 == focusIndex, Color(0xff88B14B)),
          Box(size: BoxSize.SMALL, type: BoxType.VERTICAL),
          serviceExpansionTile(
              Strings.service4Title, Strings.service4Description, 3, 3 == focusIndex, Color(0xff88B14B)),
          Box(size: BoxSize.SMALL, type: BoxType.VERTICAL),
          serviceExpansionTile(
              Strings.service5Title, Strings.service5Description, 4, 4 == focusIndex, Color(0xff88B14B)),
        ],
      ),
    );
  }

  Widget serviceExpansionTile(
      String title, String description, int index, bool isInitiallyExpanded, Color activeColor) {
    return MyContainer(
      // backgroundColor: expansionStates[index] ? activeColor : Color(0xff005329),
      backgroundColor: Color(0xff222023),
      child: ExpansionTile(
        initiallyExpanded: isInitiallyExpanded,
        title: Text(
          title,
          style: CustomTextStyles.titleSmallTextStyle(),
        ),
        children: [
          ListTile(
              title: Text(
            description,
            style: CustomTextStyles.titleExtraSmallTextStyle(),
          ))
        ],
        trailing: expansionStates[index]
            ? Icon(Icons.keyboard_arrow_up_rounded, color: Colors.grey)
            : Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey),
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
                onPressed: () {
                  Navigator.pushNamed(context, '/contact');
                },
                style: TextButton.styleFrom(
                    backgroundColor: Color(0xff47A979),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                child: Row(
                  children: [
                    SizedBox(width: 3),
                    Text(LocaleKeys.about_us_button.locale,
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
