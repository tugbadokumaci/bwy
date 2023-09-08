import 'package:bwy/extension/context_extension.dart';
import 'package:bwy/extension/string_extension.dart';
import 'package:bwy/utils/box_constants.dart';
import 'package:bwy/constants/constants.dart';
import 'package:bwy/utils/custom_text_styles.dart';
import 'package:bwy/widget/fabs.dart';
import 'package:bwy/widget/lottie_widget.dart';
import 'package:bwy/widget/tagContainer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../bottomNavBar.dart';
import '../../lang/locale_keys.g.dart';
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

List<Image> images = [
  Image.asset('assets/images/turkish.png', height: 50, width: 50),
  Image.asset('assets/images/english.png', height: 50, width: 50),
  Image.asset('assets/images/german.png', height: 50, width: 50)
];

List<String> languages = ["Türkçe", "English", "Deutch"];
// List<Map<String, dynamic>> languages = [
//   {'image': Image.asset('assets/images/turkish.png', height: 50, width: 50), 'name': "Türkçe"},
//   {'image': Image.asset('assets/images/english.png', height: 50, width: 50), 'name': "English"},
//   {'image': Image.asset('assets/images/german.png', height: 50, width: 50), 'name': "Deutsch"},
// ];

int dropdownIndex = 0; // otherwise will be assign to the index 0 after clicks

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = Pages.HOME.index; // creating index field for our state
  // static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.w600, color: Colors.white);
  // static List<Widget> _widgetOptions = <Widget>[
  //   Text(LocaleKeys.home_appBarTitle.locale, style: optionStyle),
  //   Text(LocaleKeys.about_us_appBarTitle.locale, style: optionStyle),
  //   Text(LocaleKeys.contact_appBarTitle.locale, style: optionStyle),
  //   Text(LocaleKeys.profile_appBarTitle.locale, style: optionStyle),
  // ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(create: (_) => widget.viewModel, child: _buildScaffold(context));
  }

  SafeArea _buildScaffold(BuildContext context) {
    debugPrint("important: ${context.locale}");
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.home_appBarTitle.locale, style: CustomTextStyles2.appBarTextStyle(context)),
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
            return Container();
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
      bottomNavigationBar: buildBottomNavigationBar,
    ));
  }

  CustomBottomNavigationBar get buildBottomNavigationBar {
    return CustomBottomNavigationBar(
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
    );
  }

  Widget _buildSuccess(BuildContext context, HomeSuccess state) {
    return Padding(
      padding: kHorizontalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _profileHeader(),
          // Box(size: BoxSize.SMALL, type: BoxType.VERTICAL),
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 20),
          //   child: Text('Merhaba, Hoşgeldiniz!', style: CustomTextStyles().titleTextStyle()),
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(bottom: 16.0),
          //   child: MyContainer(
          //     child: Row(
          //       children: [
          //         Image.asset('assets/images/user.png', scale: 15),
          //         const Box(size: BoxSize.EXTRASMALL, type: BoxType.HORIZONTAL),
          //         Text('${Constants.USER.userName} ${Constants.USER.userSurname}',
          //             style: TextStyle(fontSize: SizeConfig.defaultSize! * 2, fontWeight: FontWeight.bold)),
          //         const Spacer(),
          //         IconButton(
          //             onPressed: () {
          //               Navigator.pushNamed(context, '/profile');
          //             },
          //             icon: const Icon(Icons.arrow_forward_ios_rounded))
          //       ],
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(bottom: 20),
          //   child: Text('Bizi Tanıyın',
          //       style: TextStyle(
          //           color: Colors.white, fontSize: SizeConfig.defaultSize! * 2.2, fontWeight: FontWeight.bold)),
          // ),
          Padding(
            padding: kVerticalPadding,
            child: _headerContainer(),
          ),
          Text(LocaleKeys.home_servicesTitle.locale,
              style: CustomTextStyles2.titleMediumTextStyle(context, Colors.white)),
          Padding(
            padding: kVerticalPadding,
            child: _servicesBuilder(),
          ),
          Text(LocaleKeys.home_myServicesTitle.locale,
              style: CustomTextStyles2.titleMediumTextStyle(context, Colors.white)),
          Padding(
            padding: kVerticalPadding,
            child: _historyTile(state.serviceResource.data!),
          ),
        ],
      ),
    );
  }

  Row _profileHeader() {
    return Row(
      children: [
        Image.asset('assets/images/user.png', height: 40),
        TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
            child: Text('${Constants.USER.userName} ${Constants.USER.userSurname}',
                style: CustomTextStyles2.titleSmallTextStyle(context, Colors.white))),
        const Spacer(),
        DropdownButtonHideUnderline(
          child: DropdownButton<Image>(
            value: images[dropdownIndex],
            dropdownColor: Colors.black,
            onChanged: (Image? value) {
              setState(() {
                dropdownIndex = images.indexOf(value!);
                context.setLocale(Localization.SUPPORTED_LANGUAGES[dropdownIndex]);
              });
            },
            items: images.map<DropdownMenuItem<Image>>((Image value) {
              return DropdownMenuItem<Image>(
                value: value,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      value,
                      // Box(size: BoxSize.EXTRASMALL, type: BoxType.HORIZONTAL),
                      // Text(languages[images.indexOf(value)],
                      //     style: TextStyle(fontSize: SizeConfig.defaultSize! * 1.7, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }

  Widget _headerContainer() {
    return Stack(
      // alignment: Alignment.topLeft,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset('assets/images/bwy_header_new.png', width: context.dynamicWidth(1), fit: BoxFit.fitWidth),
        ),
        Positioned(
            bottom: 8,
            right: 24,
            child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/bwy', arguments: -1);
                },
                icon: const Icon(Icons.arrow_circle_right, size: 40))),
      ],
    );
  }

  Widget _servicesBuilder() {
    return Container(
      height: 180,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _serviceTile(Image.asset('assets/images/sil1.png', fit: BoxFit.scaleDown), 0),
          const Box(size: BoxSize.SMALL, type: BoxType.HORIZONTAL),
          _serviceTile(Image.asset('assets/images/sil5.png', fit: BoxFit.scaleDown), 1),
          const Box(size: BoxSize.SMALL, type: BoxType.HORIZONTAL),
          _serviceTile(Image.asset('assets/images/sil3.png', fit: BoxFit.scaleDown), 2),
          const Box(size: BoxSize.SMALL, type: BoxType.HORIZONTAL),
          _serviceTile(Image.asset('assets/images/sil2.png', fit: BoxFit.scaleDown), 3),
          const Box(size: BoxSize.SMALL, type: BoxType.HORIZONTAL),
          _serviceTile(Image.asset('assets/images/sil4.png', fit: BoxFit.scaleDown), 4),
        ],
      ),
    );
  }

  Stack _serviceTile(Image image, int focusIndex) {
    return Stack(
      // alignment: Alignment.topLeft,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: image,
        ),
        Positioned(
            top: 20,
            left: 16,
            child: Text(LocaleKeys.home_ourServices.locale,
                style: CustomTextStyles2.titleMediumTextStyle(context, Colors.white))),
        Positioned(
            top: 8,
            right: 24,
            child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/bwy', arguments: focusIndex);
                },
                icon: const Icon(Icons.arrow_circle_right, size: 40))),
      ],
    );
  }

  Widget _historyTile(List<ServiceModel> services) {
    if (services.isEmpty) {
      return Column(
        children: [
          Icon(Icons.error_outline, color: CustomColors.bwyYellow),
          const Box(size: BoxSize.EXTRASMALL, type: BoxType.VERTICAL),
          Text(LocaleKeys.home_noServiceFound.locale,
              textAlign: TextAlign.center, style: CustomTextStyles2.titleSmallTextStyle(context, Colors.grey))
        ],
      );
    }
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
            // backgroundColor: Colors.transparent,
            // backgroundImage: Image.asset('assets/images/bwy_history_tile_5.png', height: 200, fit: BoxFit.fitHeight),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                    title: Text(service.domainName,
                        style: CustomTextStyles2.titleMediumTextStyle(context, CustomColors.bwyYellow)),
                    subtitle: Row(
                      children: [
                        Text(service.productType, style: CustomTextStyles2.titleSmallTextStyle(context, Colors.white)),
                        isActive ? isActiveTrueRow() : isActiveFalseRow(),
                        const Box(size: BoxSize.EXTRASMALL, type: BoxType.HORIZONTAL),
                        Text('${LocaleKeys.home_serviceNo.locale}${service.productId}'),
                      ],
                    )),
                // subtitle: Text('Hizmet No: #${service.productId}')),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Row(
                    children: [
                      MyTagContainer(tagTitle: LocaleKeys.home_license.locale),
                      const Box(size: BoxSize.EXTRASMALL, type: BoxType.HORIZONTAL),
                      _daysLeftTagContainer(service),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, bottom: 16),
                  child: Row(
                    children: [
                      Text(
                          '${LocaleKeys.home_endingTime.locale}: ${DateFormat('dd.MM.yyyy').format(service.finishDate)}',
                          style: CustomTextStyles2.textSmallTextStyle(context, Color.fromARGB(255, 193, 193, 193))),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Row(
                    children: [
                      Text('${LocaleKeys.home_refreshingFee.locale}: ${service.price}₺',
                          style: CustomTextStyles2.titleSmallTextStyle(context, Colors.white)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  MyTagContainer _daysLeftTagContainer(ServiceModel service) {
    int diff = daysBetween(DateTime.now(), service.finishDate);
    if (diff > 0) {
      return MyTagContainer(
          tagTitle: '${LocaleKeys.home_daysLefting.locale}: $diff', borderColor: Colors.green, textColor: Colors.green);
    }
    return MyTagContainer(
        tagTitle: '${LocaleKeys.home_daysPassed.locale}: ${diff * -1}', borderColor: Colors.red, textColor: Colors.red);
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }
  // String daysBetween(DateTime from, DateTime to) {
  //   from = DateTime(from.year, from.month, from.day);
  //   to = DateTime(to.year, to.month, to.day);
  //   int diff = (to.difference(from).inHours / 24).round();
  //   if (diff > 0) {
  //     return 'Son $diff gün';
  //   }
  //   return '${diff * -1} gün geçti';
  // }

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
        Text(LocaleKeys.home_active.locale,
            style: CustomTextStyles2.textMediumTextStyle(context, const Color(0xff60C289))),
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
        Text(LocaleKeys.home_inactive.locale,
            style: CustomTextStyles2.textMediumTextStyle(context, const Color.fromARGB(255, 234, 99, 99))),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Hata ile karşılaşıldı', style: CustomTextStyles2.titleMediumTextStyle(context, CustomColors.bwyYellow)),
        Container(
            color: Colors.black,
            child: Align(
              alignment: Alignment.center,
              child: LottieWidget(path: 'error_animation'),
            )),
      ],
    );
  }
}

enum Pages {
  HOME,
  ABOUTUS,
  CONTACTUS,
  PROFILE,
}
