import 'package:bwy/bloc/profile_page/profile_cubit.dart';
import 'package:bwy/bloc/profile_page/profile_state.dart';
import 'package:bwy/constants/constants.dart';
import 'package:bwy/extension/context_extension.dart';
import 'package:bwy/extension/string_extension.dart';
import 'package:bwy/utils/custom_colors.dart';
import 'package:bwy/utils/custom_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:lottie/lottie.dart';

import '../../BottomNavBar.dart';
import '../../lang/locale_keys.g.dart';
import '../../size_config.dart';
import '../../utils/box_constants.dart';
import '../../widget/box.dart';
import '../../widget/button.dart';
import '../../widget/text_fields.dart';
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
  static List<Widget> _widgetOptions = <Widget>[
    Text(LocaleKeys.home_appBarTitle.locale, style: optionStyle),
    Text(LocaleKeys.about_us_appBarTitle.locale, style: optionStyle),
    Text(LocaleKeys.contact_appBarTitle.locale, style: optionStyle),
    Text(LocaleKeys.profile_appBarTitle.locale, style: optionStyle),
  ];

  @override
  Widget build(BuildContext context) {
    widget.viewModel.getProfile();
    return BlocProvider<ProfileCubit>(create: (_) => widget.viewModel, child: _buildScaffold(context));
  }

  SafeArea _buildScaffold(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.profile_appBarTitle.locale, style: CustomTextStyles2.appBarTextStyle(context)),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
          child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: ((context, state) {}),
        builder: (context, state) {
          debugPrint('Profile View State is : $state');
          // if (state is ProfileInitial) {
          //   return Container(color: Colors.red, height: 400, width: 400);
          // }
          if (state is ProfileLoading) {
            return _buildLoading();
          } else if (state is ProfileSuccess) {
            debugPrint('Success is building');
            return _buildSuccess(context, state);
          } else if (state is ProfilePasswordChange) {
            return _buildPasswordChange();
          }
          debugPrint('OUTSIDE');
          return _buildError(context);
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

  Center _buildError(BuildContext context) {
    return Center(
        child: Container(
            color: Colors.black,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Align(
              alignment: Alignment.center,
              child: Lottie.asset(
                'animations/error_animation.json',
                height: 200,
                reverse: false,
                // repeat: true,
                // fit: BoxFit.cover,
              ),
            )));
  }

  Widget _buildPasswordChange() {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Column(
        children: [
          Text(LocaleKeys.profile_changePassword.locale,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
          const Box(size: BoxSize.SMALL, type: BoxType.VERTICAL),
          Text(LocaleKeys.profile_changePasswordSubTitle.locale),
          const Box(size: BoxSize.MEDIUM, type: BoxType.VERTICAL),
          MyTextFieldWidget(
            validatorCallback: ((value) {
              if (value!.isEmpty) {
                return "new password can't be null";
              } else {}
              return null;
            }),
            controller: widget.viewModel.passwordController,
            labelText: LocaleKeys.profile_newPassword.locale,
            isSecure: true,
            keyboardType: TextInputType.number,
          ),
          const Box(size: BoxSize.SMALL, type: BoxType.VERTICAL),
          MyTextFieldWidget(
            validatorCallback: ((value) {
              if (value!.isEmpty) {
                return "new password can't be null";
              } else {}
              return null;
            }),
            controller: widget.viewModel.passwordAgainController,
            labelText: LocaleKeys.profile_newPasswordAgain.locale,
            isSecure: true,
            keyboardType: TextInputType.number,
          ),
          const Box(size: BoxSize.MEDIUM, type: BoxType.VERTICAL),
          MyButtonWidget(
              context: context,
              buttonColor: Colors.white,
              content: Text(LocaleKeys.profile_saveChangesButton.locale,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.bold, color: Colors.black)),
              onPressed: () {
                widget.viewModel.changePassword(context);
                widget.viewModel.passwordAgainController.text = '';
              }),
          const Box(
            size: BoxSize.SMALL,
            type: BoxType.VERTICAL,
          ),
          MyButtonWidget(
            context: context,
            buttonColor: Colors.black,
            content: Text(LocaleKeys.profile_goBackButton.locale),
            onPressed: () {
              widget.viewModel.passwordAgainController.text = '';
              widget.viewModel.passwordController.text = '';
              widget.viewModel.getProfile();
            },
            borderColor: Colors.white,
          ),
        ],
      ),
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
                    style: CustomTextStyles2.titleSmallTextStyle(context, Colors.white)),
                subtitle: Text('${Constants.USER.userEmail}',
                    style: CustomTextStyles2.textSmallTextStyle(context, Colors.grey[400]!)),
                trailing: IconButton(
                    onPressed: () {
                      widget.viewModel.logOut();
                      Navigator.pushNamed(context, '/welcome');
                    },
                    icon: const Icon(Icons.logout, color: Colors.white)),
                leading: Image.asset('assets/images/user.png', scale: 12),
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
            child: Row(
              children: [
                const Icon(Icons.settings, color: Colors.white),
                const Box(size: BoxSize.EXTRASMALL, type: BoxType.HORIZONTAL),
                Text(LocaleKeys.profile_accountSettingsTitle.locale,
                    style: CustomTextStyles2.titleMediumTextStyle(context, Colors.white)),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              widget.viewModel.goPasswordPage();
            },
            child: Row(
              children: [
                const Icon(Icons.phonelink_lock_outlined, color: Colors.white),
                const Box(size: BoxSize.EXTRASMALL, type: BoxType.HORIZONTAL),
                Text(LocaleKeys.profile_changePassword.locale,
                    style: CustomTextStyles2.titleSmallTextStyle(context, Colors.white)),
                const Spacer(),
                Icon(Icons.arrow_forward_ios_rounded, color: Colors.white),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              widget.viewModel.deleteAccount(context);
            },
            child: Row(
              children: [
                const Icon(Icons.delete, color: Colors.white),
                const Box(size: BoxSize.EXTRASMALL, type: BoxType.HORIZONTAL),
                Text(LocaleKeys.profile_deleteAccount.locale,
                    style: CustomTextStyles2.titleSmallTextStyle(context, Colors.white)),
                const Spacer(),
                Icon(Icons.arrow_forward_ios_rounded, color: Colors.white),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
            child: Row(
              children: [
                const Icon(Icons.notifications),
                const Box(size: BoxSize.SMALL, type: BoxType.HORIZONTAL),
                Text(LocaleKeys.profile_servicesnotificationsTitle.locale,
                    style: CustomTextStyles2.titleMediumTextStyle(context, Colors.white)),
              ],
            ),
          ),
          notificationContainer(LocaleKeys.profile_newServicesToggle.locale),
          const Box(size: BoxSize.SMALL, type: BoxType.VERTICAL),
          notificationContainer(LocaleKeys.profile_updateServicesToggle.locale),
        ],
      ),
    );
  }

  Widget notificationContainer(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CupertinoSwitch(activeColor: CustomColors.bwyGreen, value: _isNotificationsActive, onChanged: null),
          // ((value) {
          //   setState(() {
          //     _isNotificationsActive = value;
          //   });
          // })),
          Box(type: BoxType.HORIZONTAL, size: BoxSize.EXTRASMALL),
          Text(title, style: CustomTextStyles2.titleExtraSmallTextStyle(context, Colors.white)),
        ],
      ),
    );
  }
}
