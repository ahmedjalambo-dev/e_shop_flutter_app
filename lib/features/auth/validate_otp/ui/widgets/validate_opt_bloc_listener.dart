import 'package:e_shop_flutter_app/core/extentions/extentions.dart';
import 'package:e_shop_flutter_app/core/routes/my_routes.dart';
import 'package:e_shop_flutter_app/features/auth/validate_otp/cubit/validate_otp_cubit.dart';
import 'package:e_shop_flutter_app/features/auth/validate_otp/cubit/validate_otp_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ValidateOtpBlocListener extends StatelessWidget {
  const ValidateOtpBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ValidateOtpCubit, ValidateOtpState>(
      listenWhen: (previous, current) =>
          current is Loading || current is Success || current is Failure,
      listener: (context, state) {
        state.whenOrNull(
          loading: () => showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) =>
                const Center(child: CircularProgressIndicator()),
          ),
          success: (successMessage) {
            context.pop(); // Close loading dialog

            // Get the email from the cubit
            final email = context.read<ValidateOtpCubit>().email;

            // Show success message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(successMessage),
                backgroundColor: Colors.green,
              ),
            );

            // Navigate to reset password screen
            context.pushNamed(MyRoutes.resetPassword, arguments: email);
          },
          failure: (errorMessage) {
            context.pop(); // Close loading dialog
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                icon: const Icon(Icons.error, color: Colors.red),
                content: Text(errorMessage),
                actions: [
                  TextButton(
                    onPressed: () => context.pop(),
                    child: const Text('Got It'),
                  ),
                ],
              ),
            );
          },
        );
      },
      child: const SizedBox.shrink(),
    );
  }
}
