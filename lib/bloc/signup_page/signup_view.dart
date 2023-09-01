import 'package:bwy/bloc/signup_page/signup_cubit.dart';
import 'package:bwy/bloc/signup_page/signup_state.dart';
import 'package:bwy/utils/box_constants.dart';
import 'package:bwy/widget/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../size_config.dart';
import '../../utils/custom_text_styles.dart';
import '../../widget/box.dart';
import '../../widget/button.dart';

class SignupView extends StatelessWidget {
  final SignupCubit viewModel;
  const SignupView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignupCubit>(create: (_) => viewModel, child: _buildScaffold(context));
  }

  Widget _buildScaffold(BuildContext context) {
    SizeConfig().init(context);
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupSuccess) {
          Navigator.pushReplacementNamed(context, '/validation', arguments: {
            'email': viewModel.getEmailController.text,
            'password': viewModel.getPasswordController.text
          });
        }
      },
      builder: (context, state) {
        debugPrint('The state is $state');
        if (state is SignupInitial) {
          return _buildInitial(context);
        } else if (state is SignupLoading) {
          return _buildLoading(context);
        }
        return Container();
      },
    );
  }

  Widget _buildInitial(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/welcome');
            },
            icon: const Icon(Icons.close, color: Colors.white)),
        // title: const Text('Merhaba'),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const Box(size: BoxSize.SMALL, type: BoxType.VERTICAL),
                Text('Hesap oluşturun',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                const Box(size: BoxSize.SMALL, type: BoxType.VERTICAL),
                Text('Lütfen aşağıdaki bilgileri eksiksiz doldurun.'),
                const Box(size: BoxSize.MEDIUM, type: BoxType.VERTICAL),
                _nameField(),
                const Box(size: BoxSize.SMALL, type: BoxType.VERTICAL),
                _surnameField(),
                const Box(size: BoxSize.SMALL, type: BoxType.VERTICAL),
                _phoneField(),
                const Box(size: BoxSize.SMALL, type: BoxType.VERTICAL),
                _emailField(),
                const Box(size: BoxSize.SMALL, type: BoxType.VERTICAL),
                _passwordField(),
                const Box(size: BoxSize.MEDIUM, type: BoxType.VERTICAL),
                MyButtonWidget(
                  context: context,
                  height: 50,
                  width: 350,
                  content: Text('İlerle', style: CustomTextStyles2.buttonTextStyle(context, Colors.black)),
                  onPressed: () {
                    viewModel.signup(context);
                  },
                  buttonColor: Colors.white,
                  // borderColor: Colors.wite,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _phoneField() {
    return MyTextFieldWidget(
      validatorCallback: ((value) {
        if (value!.isEmpty) {
          return "phone number can't be null";
        } else {}
        return null;
      }),
      controller: viewModel.getPhoneController,
      labelText: 'Telefon',
      keyboardType: TextInputType.phone,
    );
  }

  Widget _passwordField() {
    return MyTextFieldWidget(
      validatorCallback: ((value) {
        if (value!.isEmpty) {
          return "password can't be null";
        } else {}
        return null;
      }),
      controller: viewModel.getPasswordController,
      labelText: 'Password',
      isSecure: true,
      keyboardType: TextInputType.number,
    );
  }

  Widget _emailField() {
    return MyTextFieldWidget(
      validatorCallback: ((value) {
        if (value!.isEmpty) {
          return "email can't be null";
        } else {}
        return null;
      }),
      controller: viewModel.getEmailController,
      labelText: 'Email',
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget _surnameField() {
    return MyTextFieldWidget(
        validatorCallback: ((value) {
          if (value!.isEmpty) {
            return "surname can't be null";
          } else {}
          return null;
        }),
        controller: viewModel.getSurnameController,
        labelText: 'Soyisim',
        keyboardType: TextInputType.text);
  }

  Widget _nameField() {
    return MyTextFieldWidget(
        validatorCallback: ((value) {
          if (value!.isEmpty) {
            return "name can't be null";
          } else {}
          return null;
        }),
        controller: viewModel.getNameController,
        labelText: 'İsim',
        keyboardType: TextInputType.text);
  }

  Center _buildLoading(BuildContext context) {
    return Center(
        child: Container(
            color: Colors.black,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Align(
              alignment: Alignment.center,
              child: Lottie.asset(
                'animations/loading_animation.json',
                height: 200,
                reverse: false,
                repeat: true,
                // fit: BoxFit.cover,
              ),
            )));
  }
}
