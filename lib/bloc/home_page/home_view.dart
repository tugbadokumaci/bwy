// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../BottomNavBar.dart';
import '../../Navbar.dart';
import '../../models/user_model.dart';
import '../../utils/custom_colors.dart';
import 'home_cubit.dart';
import 'home_state.dart';

class HomeView extends StatelessWidget {
  HomeCubit viewModel;
  HomeView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(create: (_) => viewModel, child: _buildScaffold(context));
  }

  SafeArea _buildScaffold(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Bursa Web Yazılım'),
      ),
      backgroundColor: Colors.black,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {
            Navigator.pushNamed(context, '/bwy');
          },
          child: Padding(
            padding: const EdgeInsets.all(.5),
            child: Image.asset('assets/images/bwy_logo.png'),
          )),
      // drawer: const Navbar(),
      bottomNavigationBar: CustomBottomNavBar(),
      body: SingleChildScrollView(
          child: BlocConsumer<HomeCubit, HomeState>(
        listener: ((context, state) {}),
        builder: (context, state) {
          debugPrint('Home View State is : $state');
          if (state is HomeInitial) {
            viewModel.getData();
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
    ));
  }

  Widget _buildSuccess(BuildContext context, HomeSuccess state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Text('Home Page'), _userTile(state.fetchResource.data)],
    );
  }

  Widget _userTile(List<UserModel>? users) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: users!.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return Text(user.userName);
        },
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

  Widget _buildError() {
    return const Column(
      children: [Text('Home Error')],
    );
  }
}
