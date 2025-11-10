import 'package:e_shop_flutter_app/core/themes/my_colors.dart';
import 'package:e_shop_flutter_app/core/themes/my_text_style.dart';
import 'package:e_shop_flutter_app/core/widgets/my_text_form_field.dart';
import 'package:e_shop_flutter_app/core/widgets/spacing_widgets.dart';
import 'package:e_shop_flutter_app/features/auth/login/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  bool isObscureText = true;

  @override
  void initState() {
    super.initState();
    emailController = context.read<LoginCubit>().emailController;
    passwordController = context.read<LoginCubit>().passwordController;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<LoginCubit>().formKey,
      child: Column(
        children: [
          MyTextFormField(
            textInputType: TextInputType.emailAddress,
            hintText: 'Email Address',
            controller: emailController,
            validator: (value) {
              return null;
            },
            hintStyle: MyTextStyle.body.m.copyWith(
              color: MyColors.neutral.dark.light,
            ),
            inputTextStyle: MyTextStyle.body.m.copyWith(
              color: MyColors.neutral.dark.darkest,
            ),
          ),
          const VerticalSpace(16),
          MyTextFormField(
            textInputType: TextInputType.emailAddress,
            hintText: 'Password',
            controller: passwordController,
            validator: (value) {
              return null;
            },
            isObscureText: isObscureText,
            suffixIcon: GestureDetector(
              onTap: () => setState(() => isObscureText = !isObscureText),
              child: Icon(
                isObscureText ? Icons.visibility_off : Icons.visibility,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
