// ignore_for_file: must_be_immutable

import 'package:bwy/utils/box_constants.dart';
import 'package:bwy/utils/constants.dart';
import 'package:bwy/utils/custom_text_styles.dart';
import 'package:bwy/widget/fabs.dart';
import 'package:bwy/widget/tagContainer.dart';
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
    Text('Ana Sayfa', style: optionStyle),
    Text('Hakkımızda', style: optionStyle),
    Text('İletişim', style: optionStyle),
    Text('Hesabım', style: optionStyle),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(create: (_) => widget.viewModel, child: _buildScaffold(context));
  }

  SafeArea _buildScaffold(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Ana Sayfa',
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

  Widget _buildSuccess(BuildContext context, HomeSuccess state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text('Merhaba, Hoşgeldiniz!', style: CustomTextStyles().titleTextStyle()),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: MyContainer(
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.blueGrey,
                    child: Image.asset('assets/images/default_person.png', scale: 15),
                    radius: 20,
                  ),
                  const Box(size: BoxSize.EXTRASMALL, type: BoxType.HORIZONTAL),
                  Text('${Constants.USER.userName} ${Constants.USER.userSurname}',
                      style: TextStyle(fontSize: SizeConfig.defaultSize! * 2, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/profile');
                      },
                      icon: const Icon(Icons.arrow_forward_ios_rounded))
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text('Bizi Tanıyın',
                style: TextStyle(
                    color: Colors.white, fontSize: SizeConfig.defaultSize! * 2.2, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: _headerContainer(),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text('Tüm Hizmetler',
                style: TextStyle(
                    color: Colors.white, fontSize: SizeConfig.defaultSize! * 2.2, fontWeight: FontWeight.bold)),
          ),
          _servicesBuilder(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text('Hizmet Detaylarım',
                style: TextStyle(
                    color: Colors.white, fontSize: SizeConfig.defaultSize! * 2.2, fontWeight: FontWeight.bold)),
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
          child: Image.asset('assets/images/bwy_header_new.png', height: 180, fit: BoxFit.fitHeight),
        ),
        Positioned(
            bottom: 8,
            right: 24,
            child: IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_circle_right, size: 40))),
      ],
    );
  }

  Widget _servicesBuilder() {
    return Container(
      height: 180,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _serviceTile(Image.asset(
            'assets/images/2.png',
            fit: BoxFit.scaleDown,
          )),
          const Box(size: BoxSize.SMALL, type: BoxType.HORIZONTAL),
          _serviceTile(Image.asset(
            'assets/images/3.png',
            fit: BoxFit.scaleDown,
          )),
          const Box(size: BoxSize.SMALL, type: BoxType.HORIZONTAL),
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
            child: IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_circle_right, size: 40))),
      ],
    );
  }

  Widget _historyTile(List<ServiceModel> services) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: services.length,
      shrinkWrap: true, // unless put sizedbox with a fixed height
      itemBuilder: (context, index) {
        final service = services[index];
        bool isActive = DateTime.now().compareTo(service.finishDate) < 0;
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: MyContainer(
            backgroundColor: Colors.transparent,
            backgroundImage: Image.asset('assets/images/bwy_history_tile_5.png', height: 200, fit: BoxFit.fitHeight),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                    title: Text(service.domainName,
                        style: TextStyle(
                            color: CustomColors.bwyYellow,
                            fontSize: SizeConfig.defaultSize! * 2.2,
                            fontWeight: FontWeight.bold)),
                    subtitle: Row(
                      children: [
                        Text('Hizmet No: #${service.productId}'),
                        isActive ? isActiveTrueRow() : isActiveFalseRow()
                      ],
                    )),
                // subtitle: Text('Hizmet No: #${service.productId}')),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Row(
                    children: [
                      MyTagContainer(tagTitle: service.productType),
                      const Box(size: BoxSize.EXTRASMALL, type: BoxType.HORIZONTAL),
                      MyTagContainer(tagTitle: '${service.cycle} Lisans'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, bottom: 16),
                  child: Row(
                    children: [
                      Text('Bitiş Tarihi: ${DateFormat('dd.MM.yyyy').format(service.finishDate)}',
                          style: TextStyle(
                              color: const Color.fromARGB(255, 193, 193, 193),
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
    );
  }

  Row isActiveTrueRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
              radius: 12,
              // backgroundColor: CustomColors.bwyGreenPastel,
              backgroundColor: Color(0xff60C289),
              child: Icon(Icons.check_rounded, size: 20)),
        ),
        Text('Aktif',
            style: TextStyle(
              // color: CustomColors.bwyGreenPastel,
              color: const Color(0xff60C289),
              fontSize: SizeConfig.defaultSize! * 1.7,
              fontWeight: FontWeight.bold,
            )),
      ],
    );
  }

  Row isActiveFalseRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
              radius: 12,
              // backgroundColor: CustomColors.bwyRedPastel,
              backgroundColor: Color.fromARGB(255, 212, 84, 84),
              child: Icon(Icons.close_rounded, size: 20)),
        ),
        Text('Pasif',
            style: TextStyle(
                // color: CustomColors.bwyRedPastel,
                color: const Color.fromARGB(255, 234, 99, 99),
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
  ABOUTUS,
  CONTACTUS,
  PROFILE,
}
