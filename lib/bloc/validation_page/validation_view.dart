import 'package:bwy/bloc/validation_page/validation_cubit.dart';
import 'package:bwy/bloc/validation_page/validation_state.dart';
import 'package:bwy/constants/constants.dart';
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

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    emailToVerify = arguments['email'];
    passwordToVerify = arguments['password'];
    Future.delayed(Duration.zero, () async {
      widget.viewModel.sendOtp(emailToVerify);
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
              Text(emailToVerify,
                  style: TextStyle(fontSize: SizeConfig.defaultSize! * 1.5, fontWeight: FontWeight.bold)),
              const Box(size: BoxSize.MEDIUM, type: BoxType.VERTICAL),
              Form(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _digitSizedBox(verificationController.digitControllers[0], context),
                    _digitSizedBox(verificationController.digitControllers[1], context),
                    _digitSizedBox(verificationController.digitControllers[2], context),
                    _digitSizedBox(verificationController.digitControllers[3], context),
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
                  widget.viewModel.validate(context, emailToVerify, passwordToVerify);
                },
              ),
            ],
          ),
        ));
  }

  SizedBox _digitSizedBox(TextEditingController _controller, BuildContext context) {
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
