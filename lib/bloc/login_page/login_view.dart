// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:bwy/extension/context_extension.dart';
import 'package:bwy/widget/lottie_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../utils/box_constants.dart';
import '../../utils/custom_colors.dart';
import '../../widget/text_fields.dart';
import '../../widget/box.dart';
import '../../widget/button.dart';
import 'login_cubit.dart';
import 'login_state.dart';

class LoginView extends StatelessWidget {
  final LoginCubit viewModel;
  LoginView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(create: (_) => viewModel, child: _buildScaffold(context));
  }

  Scaffold _buildScaffold(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // title: const FaIcon(FontAwesomeIcons.twitter, color: Colors.white),
          leading: IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/');
              },
              icon: const Icon(Icons.close)),
        ),
        backgroundColor: Colors.black,
        body: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              Navigator.pushReplacementNamed(context, '/home');
            }
          },
          builder: ((context, state) {
            if (state is LoginInitial) {
              viewModel.initialize();
              return _buildInitial(context);
            } else if (state is LoginLoading) {
              return _buildLoading(context);
            }
            // else if(state is Login)
            return Container();
          }),
        ));
  }

  Widget _buildInitial(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hoşgeldiniz',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
            const Box(size: BoxSize.SMALL, type: BoxType.VERTICAL),
            const Text('Lütfen aşağıdaki bilgileri eksiksiz doldurun.'),
            const Box(size: BoxSize.MEDIUM, type: BoxType.VERTICAL),
            MyTextFieldWidget(
              validatorCallback: ((value) {
                if (value!.isEmpty) {
                  return "email alanı boş olamaz";
                } else {}
                return null;
              }),
              controller: viewModel.getEmailController,
              labelText: 'Email',
              keyboardType: TextInputType.emailAddress,
            ),
            const Box(size: BoxSize.SMALL, type: BoxType.VERTICAL),
            MyTextFieldWidget(
              validatorCallback: ((value) {
                if (value!.isEmpty) {
                  return "şifre alanı boş olamaz";
                } else {}
                return null;
              }),
              controller: viewModel.getPasswordController,
              labelText: 'Şifre',
              isSecure: true,
              keyboardType: TextInputType.number,
            ),
            const Box(size: BoxSize.MEDIUM, type: BoxType.VERTICAL),
            MyButtonWidget(
                context: context,
                buttonColor: Colors.white,
                content: Text('Giriş yap',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.bold, color: Colors.black)),
                onPressed: () {
                  viewModel.login(context);
                }),
            const Box(
              size: BoxSize.SMALL,
              type: BoxType.VERTICAL,
            ),
            // MyButtonWidget(
            //   context: context,
            //   height: 50,
            //   width: 350,
            //   buttonColor: Colors.black,
            //   content: const Text('Forgot Password?'),
            //   onPressed: () {},
            //   borderColor: Colors.white,
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Henüz bir hesabınız yok mu?',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(color: CustomColors.lightGray)),
                TextButton(
                  child: Text('Kaydol',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(color: CustomColors.bwyRed)),
                  onPressed: () => Navigator.pushReplacementNamed(context, '/signUp'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Center _buildLoading(BuildContext context) {
    return Center(
        child: Container(
            color: Colors.black,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Align(
              alignment: Alignment.center,
              child: LottieWidget(path: 'loading_animation'),
            )));
  }
}
