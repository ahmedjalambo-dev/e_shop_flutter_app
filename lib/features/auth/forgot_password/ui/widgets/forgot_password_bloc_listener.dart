import 'package:e_shop_flutter_app/core/extentions/extentions.dart';
import 'package:e_shop_flutter_app/core/routes/my_routes.dart';
import 'package:e_shop_flutter_app/features/auth/forgot_password/cubit/forgot_password_cubit.dart';
import 'package:e_shop_flutter_app/features/auth/forgot_password/cubit/forgot_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordBlocListener extends StatelessWidget {
  const ForgotPasswordBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
      listenWhen: (previous, current) =>
          current is Loading || current is Success || current is Failure,
      listener: (context, state) {
        state.whenOrNull(
          loading: () => showDialog(
            context: context,
            builder: (context) =>
                const Center(child: CircularProgressIndicator()),
          ),
          success: (successMessage) {
            context.pop(); // Close loading dialog
            final email = context
                .read<ForgotPasswordCubit>()
                .emailController
                .text;

            // Show a quick confirmation
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(successMessage),
                backgroundColor: Colors.green,
              ),
            );

            // Navigate to the reset password screen
            context.pushNamed(MyRoutes.resetPassword, arguments: email);
          },
          failure: (errorMessage) {
            /* ... */
          },
        );
      },
      child: const SizedBox.shrink(),
    );
  }
}
