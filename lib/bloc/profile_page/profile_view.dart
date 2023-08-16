import 'package:bwy/BottomNavBar.dart';
import 'package:bwy/bloc/profile_page/profile_cubit.dart';
import 'package:bwy/bloc/profile_page/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../size_config.dart';
import '../../utils/custom_colors.dart';
import '../home_page/home_cubit.dart';

class ProfileView extends StatelessWidget {
  final ProfileCubit viewModel;
  const ProfileView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(create: (_) => viewModel, child: _buildScaffold(context));
  }

  SafeArea _buildScaffold(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.bwyYellow,
        title: const Text('Profile'),
        centerTitle: true,
        actions: <Widget>[
          TextButton(
            onPressed: () {},
            child: Text('Edit',
                style: TextStyle(
                    color: Colors.white, fontSize: SizeConfig.defaultSize! * 1.6, fontWeight: FontWeight.bold // 16
                    )),
          )
        ],
      ),
      backgroundColor: Colors.black,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(backgroundColor: Colors.black, onPressed: () {}),
      // drawer: const Navbar(),
      bottomNavigationBar: CustomBottomNavBar(),
      body: SingleChildScrollView(
          child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: ((context, state) {}),
        builder: (context, state) {
          debugPrint('Profile View State is : $state');
          if (state is ProfileInitial) {
            viewModel.getProfile();
          } else if (state is ProfileLoading) {
            return _buildLoading();
          } else if (state is ProfileSuccess) {
            return _buildSuccess(context, state);
          }
          // else if (state is ProfileError) {
          //   return _buildError();
          // }
          return Container();
        },
      )),
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
    return const Column();
  }
}
