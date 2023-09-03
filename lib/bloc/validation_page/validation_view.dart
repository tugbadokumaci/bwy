import 'package:bwy/bloc/validation_page/validation_cubit.dart';
import 'package:bwy/bloc/validation_page/validation_state.dart';
import 'package:bwy/extension/context_extension.dart';
import 'package:bwy/utils/custom_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../size_config.dart';
import '../../utils/box_constants.dart';
import '../../widget/box.dart';
import '../../widget/button.dart';

class ValidationView extends StatefulWidget {
  final ValidationCubit viewModel;
  ValidationView({super.key, required this.viewModel});

  @override
  State<ValidationView> createState() => _ValidationViewState();
}

class _ValidationViewState extends State<ValidationView> {
  late String emailToVerify;
  late String passwordToVerify;
  bool _isSend = false;

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    emailToVerify = arguments['email'];
    passwordToVerify = arguments['password'];
    Future.delayed(Duration.zero, () async {
      if (!_isSend) {
        widget.viewModel.sendOtp(emailToVerify);
        _isSend = !_isSend;
      }
    });

    return BlocProvider<ValidationCubit>(create: (_) => widget.viewModel, child: _buildScaffold(context));
  }

  Widget _buildScaffold(
    BuildContext context,
  ) {
    SizeConfig().init(context);
    return BlocConsumer<ValidationCubit, ValidationState>(
      listener: (context, state) {
        if (state is ValidationSuccess) {
          Navigator.pushReplacementNamed(context, '/home');
        }
      },
      builder: (context, state) {
        debugPrint('The state is $state');
        if (state is ValidationInitial) {
          return _buildInitial(context);
        } else if (state is ValidationLoading) {
          return _buildLoading(context);
        }
        return Container();
      },
    );
  }

  Widget _buildInitial(BuildContext context) {
    final verificationController = context.read<ValidationCubit>().verificationController;

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              icon: Icon(Icons.close)),
        ),
        backgroundColor: Colors.black,
        body: Padding(
          padding: context.paddingAllLarge,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Box(size: BoxSize.EXTRASMALL, type: BoxType.VERTICAL),
              Text('Email Adresinizi Doğrulayın', style: CustomTextStyles2.titleMediumTextStyle(context, Colors.white)),
              const Box(size: BoxSize.MEDIUM, type: BoxType.VERTICAL),
              Text('Doğrulama kodu bu adrese gönderildi',
                  style: CustomTextStyles2.textSmallTextStyle(context, Colors.white)),
              Text(emailToVerify, style: CustomTextStyles2.textSmallTextStyle(context, Colors.white)),
              const Box(size: BoxSize.MEDIUM, type: BoxType.VERTICAL),
              Form(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Spacer(flex: 2),
                    Expanded(flex: 4, child: _digitSizedBox(verificationController.digitControllers[0], context)),
                    Spacer(),
                    Expanded(flex: 4, child: _digitSizedBox(verificationController.digitControllers[1], context)),
                    Spacer(),
                    Expanded(flex: 4, child: _digitSizedBox(verificationController.digitControllers[2], context)),
                    Spacer(),
                    Expanded(flex: 4, child: _digitSizedBox(verificationController.digitControllers[3], context)),
                    Spacer(flex: 2),
                  ],
                ),
              ),
              const Box(size: BoxSize.MEDIUM, type: BoxType.VERTICAL),
              MyButtonWidget(
                context: context,
                buttonColor: Colors.green,
                content: Text('Doğrula'),
                onPressed: () {
                  widget.viewModel.validate(context, emailToVerify, passwordToVerify);
                },
              ),
            ],
          ),
        ));
  }

  TextFormField _digitSizedBox(TextEditingController _controller, BuildContext context) {
    return TextFormField(
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
      style: CustomTextStyles2.titleMediumTextStyle(context, Colors.white),
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      inputFormatters: [LengthLimitingTextInputFormatter(1), FilteringTextInputFormatter.digitsOnly],
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
