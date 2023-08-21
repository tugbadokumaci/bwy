import 'package:bwy/bloc/profile_page/profile_cubit.dart';
import 'package:bwy/bloc/profile_page/profile_state.dart';
import 'package:bwy/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../size_config.dart';
import '../../utils/box_constants.dart';
import '../../widget/box.dart';
import '../home_page/home_view.dart';

class ProfileView extends StatefulWidget {
  final ProfileCubit viewModel;
  const ProfileView({super.key, required this.viewModel});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool _isNotificationsActive = true;
  int _selectedIndex = Pages.PROFILE.index;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.w600, color: Colors.white);
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Ana Sayfa', style: optionStyle),
    Text('Hakkımızda', style: optionStyle),
    Text('İletişim', style: optionStyle),
    Text('Hesabım', style: optionStyle),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(create: (_) => widget.viewModel, child: _buildScaffold(context));
  }

  SafeArea _buildScaffold(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Hesabım',
            style: TextStyle(
                fontFamily: 'REM',
                color: Colors.white,
                fontSize: SizeConfig.defaultSize! * 2.4,
                fontWeight: FontWeight.bold)),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.black,
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton(backgroundColor: Colors.black, onPressed: () {}),
      // // drawer: const Navbar(),
      // bottomNavigationBar: CustomBottomNavBar(),
      body: SingleChildScrollView(
          child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: ((context, state) {
          if (state is ProfileInitial) {
            // widget.viewModel.getProfile();
          }
        }),
        builder: (context, state) {
          debugPrint('Profile View State is : $state');
          // if (state is ProfileLoading) {
          //   return _buildLoading();
          // } else if (state is ProfileSuccess) {
          //   debugPrint('Now success is building');
          return _buildSuccess(context, state);
          // }
          // else if (state is ProfileError) {
          //   return _buildError();
          // }
        },
      )),
      bottomNavigationBar: Container(
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
                  text: 'Panelim',
                ),
                GButton(
                  icon: Icons.computer_outlined,
                  text: 'Likes',
                ),
                GButton(
                  icon: Icons.phone_outlined,
                  text: 'İLetişim',
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
      ),
    ));
  }

  Widget _buildLoading() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LinearProgressIndicator(
          color: Colors.yellow,
          backgroundColor: Colors.white,
        ),
      ],
    );
  }

  Widget _buildSuccess(context, state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              decoration: BoxDecoration(color: const Color(0xff222023), borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                title: Text('${Constants.USER.userName} ${Constants.USER.userSurname}',
                    style: TextStyle(
                        color: Colors.white, fontSize: SizeConfig.defaultSize! * 2, fontWeight: FontWeight.bold)),
                subtitle: Text('${Constants.USER.userEmail}',
                    style: TextStyle(
                        color: Colors.grey[400], fontSize: SizeConfig.defaultSize! * 1.5, fontWeight: FontWeight.bold)),
                trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.edit, color: Colors.white)),
                leading: CircleAvatar(
                  backgroundColor: Colors.blueGrey,
                  child: Image.asset('assets/images/default_person.png', scale: 15),
                  radius: 20,
                ),
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
            child: Row(
              children: [
                const Icon(Icons.settings, color: Colors.white),
                const Box(size: BoxSize.EXTRASMALL, type: BoxType.HORIZONTAL),
                Text('Hesap Ayarlarım',
                    style: TextStyle(
                        color: Colors.white, fontSize: SizeConfig.defaultSize! * 1.8, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Container(
              decoration: BoxDecoration(color: const Color(0xff222023), borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Icon(Icons.phonelink_lock_outlined),
                    const Box(size: BoxSize.EXTRASMALL, type: BoxType.HORIZONTAL),
                    Text('Şifremi değiştir',
                        style: TextStyle(
                            color: Colors.white, fontSize: SizeConfig.defaultSize! * 2, fontWeight: FontWeight.bold)),
                    const Spacer(),
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white)),
                  ],
                ),
              )),
          const Box(size: BoxSize.SMALL, type: BoxType.VERTICAL),
          Container(
              decoration: BoxDecoration(color: const Color(0xff222023), borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.translate_outlined,
                    ),
                    const Box(size: BoxSize.EXTRASMALL, type: BoxType.HORIZONTAL),
                    Text('Uygulama dilini değiştir',
                        style: TextStyle(
                            color: Colors.white, fontSize: SizeConfig.defaultSize! * 2, fontWeight: FontWeight.bold)),
                    const Spacer(),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_forward_ios_rounded)),
                  ],
                ),
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
            child: Row(
              children: [
                const Icon(Icons.notifications),
                const Box(size: BoxSize.EXTRASMALL, type: BoxType.HORIZONTAL),
                Text('Bildirimlerim',
                    style: TextStyle(
                        color: Colors.white, fontSize: SizeConfig.defaultSize! * 1.8, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          notificationContainer('Hizmet Bildirimleri'),
          const Box(size: BoxSize.SMALL, type: BoxType.VERTICAL),
          notificationContainer('Haber Bildirimleri'),
        ],
      ),
    );
  }

  Container notificationContainer(String title) {
    return Container(
        decoration: BoxDecoration(color: const Color(0xff222023), borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Icon(Icons.notifications_active, color: Colors.white),
              const Box(size: BoxSize.EXTRASMALL, type: BoxType.HORIZONTAL),
              Text(title,
                  style: TextStyle(
                      color: Colors.white, fontSize: SizeConfig.defaultSize! * 2, fontWeight: FontWeight.bold)),
              const Spacer(),
              CupertinoSwitch(
                  value: _isNotificationsActive,
                  onChanged: ((value) {
                    setState(() {
                      _isNotificationsActive = value;
                    });
                  })),
            ],
          ),
        ));
  }
}
