import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../size_config.dart';
import '../../utils/box_constants.dart';
import '../../widget/box.dart';
import '../../widget/fabs.dart';
import '../home_page/home_view.dart';

class ContactView extends StatefulWidget {
  const ContactView({super.key});

  @override
  State<ContactView> createState() => _ContactViewState();
}

class _ContactViewState extends State<ContactView> {
  int _selectedIndex = Pages.CONTACTUS.index;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.w600, color: Colors.white);
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Ana Sayfa', style: optionStyle),
    Text('Hakkımızda', style: optionStyle),
    Text('İletişim', style: optionStyle),
    Text('Hesabım', style: optionStyle),
  ];

  @override
  Widget build(BuildContext context) {
    return _buildScaffold(context);
  }

  SafeArea _buildScaffold(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('İletişim',
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
      floatingActionButton: Stack(
        children: [
          Positioned(right: 0, bottom: 0, child: FABs.buildMessageFab(context)),
          Positioned(left: 24, bottom: 0, child: FABs.buildCallFab(context)),
        ],
      ),
      body: SingleChildScrollView(
        child: _buildBody(context),
      ),
      bottomNavigationBar: _bottomNavigationBar(context),
    ));
  }

  Widget _buildBody(BuildContext context) {
    return _contactBuilder(context);
  }

  Widget _contactBuilder(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: [
        _contactTile(Image.asset(
          'assets/images/bwy_contact_us_phone.png',
        )),
        const Box(size: BoxSize.SMALL, type: BoxType.VERTICAL),
        _contactTile(Image.asset('assets/images/bwy_contact_us_mail.png')),
        const Box(size: BoxSize.SMALL, type: BoxType.VERTICAL),
        _contactTile(Image.asset('assets/images/bwy_contact_us_location.png')),
        const Box(size: BoxSize.SMALL, type: BoxType.VERTICAL),
      ],
    );
  }

  Stack _contactTile(Image image) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(height: 130, width: 400, child: image),
        ),
      ],
    );
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
}
