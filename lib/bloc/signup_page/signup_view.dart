import 'package:bwy/bloc/signup_page/signup_cubit.dart';
import 'package:bwy/bloc/signup_page/signup_state.dart';
import 'package:bwy/utils/box_constants.dart';
import 'package:bwy/widget/container.dart';
import 'package:bwy/widget/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../size_config.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_text_styles.dart';
import '../../widget/box.dart';
import '../../widget/button.dart';

class SignupView extends StatefulWidget {
  final SignupCubit viewModel;
  const SignupView({super.key, required this.viewModel});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  late bool _passwordVisible;
  void initState() {
    _passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignupCubit>(create: (_) => widget.viewModel, child: _buildScaffold(context));
  }

  Widget _buildScaffold(BuildContext context) {
    SizeConfig().init(context);
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupSuccess) {
          Navigator.pushReplacementNamed(context, '/home');
        }
      },
      builder: (context, state) {
        debugPrint('The state is $state');
        if (state is SignupInitial) {
          return _buildInitial(context);
        } else if (state is SignupLoading) {
          return _buildLoading(context);
        } else if (state is SignupValidate) {
          return _buildValidate(context);
        }
        return Container();
      },
    );
  }

  Widget _buildValidate(BuildContext context) {
    final verificationController = context.read<SignupCubit>().verificationController;

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/welcome');
              },
              icon: Icon(Icons.close)),
        ),
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            children: [
              const Box(size: BoxSize.EXTRASMALL, type: BoxType.VERTICAL),
              Text('Email Adresinizi Doğrulayın',
                  style: TextStyle(fontSize: SizeConfig.defaultSize! * 2.2, fontWeight: FontWeight.bold)),
              const Box(size: BoxSize.MEDIUM, type: BoxType.VERTICAL),
              Text('Doğrulama kodu bu adrese gönderildi',
                  style: TextStyle(fontSize: SizeConfig.defaultSize! * 1.5, fontWeight: FontWeight.bold)),
              Text('${widget.viewModel.getEmailController.text} ',
                  style: TextStyle(fontSize: SizeConfig.defaultSize! * 1.5, fontWeight: FontWeight.bold)),
              const Box(size: BoxSize.MEDIUM, type: BoxType.VERTICAL),
              Form(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _digitSizedBox(verificationController.digitControllers[0]),
                    _digitSizedBox(verificationController.digitControllers[1]),
                    _digitSizedBox(verificationController.digitControllers[2]),
                    _digitSizedBox(verificationController.digitControllers[3]),
                  ],
                ),
              ),
              const Box(size: BoxSize.MEDIUM, type: BoxType.VERTICAL),
              MyButtonWidget(
                context: context,
                height: 50,
                width: 350,
                buttonColor: Colors.green,
                content: Text('Doğrula'),
                onPressed: () {
                  widget.viewModel.validate(context);
                },
              ),
            ],
          ),
        ));
  }

  SizedBox _digitSizedBox(TextEditingController _controller) {
    return SizedBox(
        height: 68,
        width: 64,
        child: TextFormField(
          controller: _controller,
          cursorColor: Colors.green,
          onTapOutside: (event) {
            FocusScope.of(context).unfocus();
          },
          onChanged: (value) {
            if (value.length == 1) {
              FocusScope.of(context).nextFocus();
            }
          },
          onSaved: (pin1) {},
          decoration: InputDecoration(
              hintText: "0",
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.green,
                ),
              )),
          style: TextStyle(color: Colors.white, fontSize: SizeConfig.defaultSize! * 2.2, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          inputFormatters: [LengthLimitingTextInputFormatter(1), FilteringTextInputFormatter.digitsOnly],
        ));
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
                    widget.viewModel.signup(context);
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
        controller: widget.viewModel.getPhoneController,
        labelText: 'Telefon');
  }

  Widget _passwordField() {
    return MyTextFieldWidget(
      validatorCallback: ((value) {
        if (value!.isEmpty) {
          return "password can't be null";
        } else {}
        return null;
      }),
      controller: widget.viewModel.getPasswordController,
      labelText: 'Password',
      isSecure: _passwordVisible,
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
        controller: widget.viewModel.getEmailController,
        labelText: 'Email');
  }

  Widget _surnameField() {
    return MyTextFieldWidget(
        validatorCallback: ((value) {
          if (value!.isEmpty) {
            return "surname can't be null";
          } else {}
          return null;
        }),
        controller: widget.viewModel.getSurnameController,
        labelText: 'Soyisim');
  }

  Widget _nameField() {
    return MyTextFieldWidget(
        validatorCallback: ((value) {
          if (value!.isEmpty) {
            return "name can't be null";
          } else {}
          return null;
        }),
        controller: widget.viewModel.getNameController,
        labelText: 'İsim');
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
