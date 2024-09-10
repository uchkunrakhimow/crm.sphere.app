import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tedbook/pages/home/bloc/home_bloc.dart';
import 'package:tedbook/pages/home/home_page.dart';
import 'package:tedbook/pages/login/bloc/login_bloc.dart';
import 'package:tedbook/persistance/text_style_const.dart';
import 'package:tedbook/utils/navigator_extension.dart';
import 'package:tedbook/utils/size_context_extension.dart';
import 'package:tedbook/widgets/custom_button.dart';
import 'package:tedbook/widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginBloc bloc;

  @override
  void initState() {
    bloc = context.read<LoginBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log("\nscreenWidth: ${screenWidth}\nscreenHeight: ${screenHeight}");

    return Scaffold(
      body: _mainUi,
      backgroundColor: Colors.white,
      // resizeToAvoidBottomInset: false,
    );
  }

  Widget get _mainUi => Stack(
        children: [
          SizedBox(height: screenHeight),
          Image(
            image: AssetImage("assets/images/login_back.webp"),
            fit: BoxFit.cover,
          ),
          Container(
            height: screenHeight * 0.4,
            alignment: Alignment.center,
            child: Image(
              image: AssetImage("assets/images/logo_text.webp"),
              height: 48,
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 56),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Container(
                //   width: screenWidth,
                //   height: screenHeight * 0.4,
                //   decoration: BoxDecoration(
                //     image: DecorationImage(
                //       image: AssetImage("assets/images/login_back.webp"),
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                //   child: Image(
                //     image: AssetImage("assets/images/logo_text.webp"),
                //     height: 48,
                //   ),
                //   alignment: Alignment.center,
                // ),
                SizedBox(height: screenHeight * 0.48),
                CustomTextField(hintText: "Логин"),
                const SizedBox(height: 13),
                CustomTextField(
                  hintText: "Пароль",
                  inputAction: TextInputAction.done,
                ),
                const SizedBox(height: 21),
                CustomButton(
                  text: "Войти",
                  onTap: () => pushWithBloc(HomePage(), HomeBloc()),
                ),
                // Expanded(child: SizedBox()),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 24,
            // padding: const EdgeInsets.only(bottom: 24),
            child: Text(
              "© TEDBOOK Kompaniyasi 2021",
              style: TextStyleS.s12w500(),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );
}
