// ignore_for_file: must_be_immutable

import 'package:bwy/utils/box_constants.dart';
import 'package:bwy/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:intl/intl.dart';
import '../../models/service_model.dart';
import '../../size_config.dart';
import '../../utils/custom_colors.dart';
import '../../widget/box.dart';
import '../../widget/container.dart';
import 'home_cubit.dart';
import 'home_state.dart';

class HomeView extends StatefulWidget {
  // outside world of our constractor
  HomeCubit viewModel;
  HomeView({super.key, required this.viewModel});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = Pages.HOME.index; // creating index field for our state
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.w600, color: Colors.white);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Home',
      style: optionStyle,
    ),
    Text(
      'Likes',
      style: optionStyle,
    ),
    Text(
      'Search',
      style: optionStyle,
    ),
    Text(
      'Profile',
      style: optionStyle,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(create: (_) => widget.viewModel, child: _buildScaffold(context));
  }

  SafeArea _buildScaffold(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
      // appBar: AppBar(
      //   title: Text('Panelim',
      //       style:
      //           TextStyle(color: Colors.white, fontSize: SizeConfig.defaultSize! * 2.2, fontWeight: FontWeight.bold)),
      //   centerTitle: true,
      //   automaticallyImplyLeading: false,
      // ),
      backgroundColor: Colors.black,
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton(
      //     backgroundColor: Colors.black,
      //     onPressed: () {
      //       Navigator.pushReplacementNamed(context, '/bwy');
      //     },
      //     child: Padding(
      //       padding: const EdgeInsets.all(.5),
      //       child: Image.asset('assets/images/bwy_logo.png'),
      //     )),
      // drawer: const Navbar(),
      // bottomNavigationBar: CustomBottomNavBar(),
      body: SingleChildScrollView(
          child: BlocConsumer<HomeCubit, HomeState>(
        listener: ((context, state) {}),
        builder: (context, state) {
          debugPrint('Home View State is : $state');
          if (state is HomeInitial) {
            // widget.viewModel.getData();
            widget.viewModel.getServices();
          } else if (state is HomeLoading) {
            return _buildLoading();
          } else if (state is HomeSuccess) {
            return _buildSuccess(context, state);
          } else if (state is HomeError) {
            return _buildError();
          }
          return Container();
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
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Color(0xff222023),
              color: Colors.grey,
              tabs: [
                GButton(
                  icon: Icons.dashboard_outlined,
                  text: 'Panelim',
                ),
                GButton(
                  icon: Icons.favorite_outline,
                  text: 'Likes',
                ),
                GButton(
                  icon: Icons.search_outlined,
                  text: 'Search',
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
                  // Navigator.pushNamed(context, '/home');
                  case 2:
                  // Navigator.pushNamed(context, '/home');
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

  Widget _buildSuccess(BuildContext context, HomeSuccess state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: MyContainer(
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    child: Image.asset('assets/images/default_person.png'),
                    radius: 15,
                  ),
                  Box(size: BoxSize.EXTRASMALL, type: BoxType.HORIZONTAL),
                  Text('Merhaba, ${Constants.USER.userName} ${Constants.USER.userSurname}',
                      style: TextStyle(fontSize: SizeConfig.defaultSize! * 2, fontWeight: FontWeight.bold)),
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/profile');
                      },
                      icon: Icon(Icons.arrow_forward_ios_rounded, color: Colors.white))
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: _headerContainer(),
          ),
          _servicesTile(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              children: [
                Icon(Icons.history, color: Colors.white),
                Box(size: BoxSize.EXTRASMALL, type: BoxType.HORIZONTAL),
                Text('Hizmet Geçmişim',
                    style: TextStyle(
                        color: Colors.white, fontSize: SizeConfig.defaultSize! * 2.2, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          _historyTile(state.serviceResource.data!),
        ],
      ),
    );
  }

  Widget _headerContainer() {
    return Stack(
      // alignment: Alignment.topLeft,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset('assets/images/bwy_header.png', height: 180, fit: BoxFit.fitHeight),
        ),
        Positioned(
            bottom: 8,
            right: 24,
            child: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_circle_right, color: Colors.white, size: 40))),
      ],
    );
  }

  Widget _servicesTile() {
    return Container(
      height: 180,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _serviceTile(Image.asset(
            'assets/images/2.png',
            fit: BoxFit.scaleDown,
          )),
          Box(size: BoxSize.SMALL, type: BoxType.HORIZONTAL),
          _serviceTile(Image.asset(
            'assets/images/3.png',
            fit: BoxFit.scaleDown,
          )),
          Box(size: BoxSize.SMALL, type: BoxType.HORIZONTAL),
          _serviceTile(Image.asset(
            'assets/images/4.png',
            fit: BoxFit.scaleDown,
          )),
        ],
      ),
    );
  }

  Stack _serviceTile(Image image) {
    return Stack(
      // alignment: Alignment.topLeft,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(height: 180, width: 250, child: image),
        ),
        Positioned(
            top: 16,
            left: 16,
            child: Text('Hizmetimizi \ngörüntüleyin',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: SizeConfig.defaultSize! * 2.5,
                  fontWeight: FontWeight.bold,
                ))),
        Positioned(
            top: 8,
            right: 24,
            child: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_circle_right, color: Colors.white, size: 40))),
      ],
    );
  }

  Widget _historyTile(List<ServiceModel> services) {
    return SizedBox(
      height: SizeConfig.screenHeight,
      child: ListView.builder(
        // scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        itemCount: services.length,
        itemBuilder: (context, index) {
          final service = services[index];
          bool isActive = DateTime.now().compareTo(service.finishDate) < 0;
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xff222023),
              ),
              height: 200,
              child: Column(
                children: [
                  ListTile(
                      title: Row(
                        children: [
                          Text(service.domainName,
                              style: TextStyle(
                                  color: CustomColors.bwyYellow,
                                  fontSize: SizeConfig.defaultSize! * 2,
                                  fontWeight: FontWeight.bold)),
                          isActive ? isActiveTrueRow() : isActiveFalseRow()
                        ],
                      ),
                      subtitle: Text('Hizmet No: #${service.productId}')),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            // color: Color(0xff729DFE),
                            color: Color.fromARGB(255, 84, 126, 224),

                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Hizmet Tipi: ${service.productType}',
                                  style:
                                      TextStyle(fontSize: SizeConfig.defaultSize! * 1.5, fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                        Box(size: BoxSize.SMALL, type: BoxType.HORIZONTAL),
                        Container(
                          decoration: BoxDecoration(
                            // color: Color(0xff729DFE),
                            color: Color.fromARGB(255, 84, 126, 224),

                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(Icons.sync, color: Colors.white),
                                  Text(service.cycle,
                                      style: TextStyle(
                                          fontSize: SizeConfig.defaultSize! * 1.5, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // Icon(Icons.sync, color: Colors.white),
                        // Text('Döngü Tipi: ${service.cycle}',
                        //     style: TextStyle(fontSize: SizeConfig.defaultSize! * 1.5, fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Text('Hizmet Bitiş Tarihi: ${DateFormat('dd.MM.yyyy').format(service.finishDate)}',
                            style: TextStyle(
                                color: Color.fromARGB(255, 193, 193, 193),
                                fontSize: SizeConfig.defaultSize! * 1.5,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Row isActiveTrueRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
              radius: 12,
              backgroundColor: Color(0xff60C289),
              child: Icon(Icons.check_rounded, color: Colors.white, size: 20)),
        ),
        Text('Aktif',
            style: TextStyle(
                color: Color(0xff60C289), fontSize: SizeConfig.defaultSize! * 1.7, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Row isActiveFalseRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
              radius: 12,
              backgroundColor: Color.fromARGB(255, 212, 84, 84),
              child: Icon(Icons.close_rounded, color: Colors.white, size: 20)),
        ),
        Text('Pasif',
            style: TextStyle(
                color: Color.fromARGB(255, 234, 99, 99),
                fontSize: SizeConfig.defaultSize! * 1.7,
                fontWeight: FontWeight.bold)),
      ],
    );
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

  Widget _buildError() {
    return const Column(
      children: [Text('Home Error')],
    );
  }
}

enum Pages {
  HOME,
  FAVORITE,
  SEARCH,
  PROFILE,
}
