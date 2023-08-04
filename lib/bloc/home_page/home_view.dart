// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/user_model.dart';
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
      body: SingleChildScrollView(
          child: BlocConsumer<HomeCubit, HomeState>(
        listener: ((context, state) {}),
        builder: (context, state) {
          debugPrint('Home View State is : $state');
          if (state is HomeInitial) {
            viewModel.fetchData();
            // viewModel.getData();
            // viewModel.createUser();
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
          return Container(
              width: 120,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
              child: Text(user.userName));
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
