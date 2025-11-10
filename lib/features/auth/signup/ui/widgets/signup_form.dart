import 'package:e_shop_flutter_app/core/themes/my_colors.dart';
import 'package:e_shop_flutter_app/core/themes/my_text_style.dart';
import 'package:e_shop_flutter_app/core/widgets/my_text_form_field.dart';
import 'package:e_shop_flutter_app/core/widgets/spacing_widgets.dart';
import 'package:e_shop_flutter_app/features/auth/signup/cubit/signup_cubit.dart';
import 'package:e_shop_flutter_app/features/auth/signup/ui/widgets/terms_and_conditions_check_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  bool isObscureText = true;

  @override
  void initState() {
    super.initState();
    firstNameController = context.read<SignupCubit>().firstNameController;
    lastNameController = context.read<SignupCubit>().lastNameController;
    emailController = context.read<SignupCubit>().emailController;
    passwordController = context.read<SignupCubit>().passwordController;
    confirmPasswordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<SignupCubit>().formKey,
      child: Column(
        children: [
          MyTextFormField(
            textInputType: TextInputType.name,
            hintText: 'First Name',
            controller: firstNameController,
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
            textInputType: TextInputType.name,
            hintText: 'Last Name',
            controller: lastNameController,
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
            textInputType: TextInputType.visiblePassword,
            hintText: 'Create a passaword',
            controller: passwordController,
            validator: (value) {
              return null;
            },
            isObscureText: true,
            suffixIcon: const Icon(Icons.visibility_off, size: 16),
          ),
          const VerticalSpace(16),
          MyTextFormField(
            textInputType: TextInputType.visiblePassword,
            hintText: 'Confirm password',
            controller: confirmPasswordController,
            validator: (value) {
              return null;
            },
            isObscureText: true,
            suffixIcon: const Icon(Icons.visibility_off, size: 16),
          ),
          const VerticalSpace(24),
          const TermsAndConditionsCheckbox(),
        ],
      ),
    );
  }
}
