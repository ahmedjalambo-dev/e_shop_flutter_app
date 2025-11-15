import 'package:e_shop_flutter_app/core/extentions/extentions.dart';
import 'package:e_shop_flutter_app/core/routes/my_routes.dart';
import 'package:e_shop_flutter_app/features/auth/reset_password/cubit/reset_password_cubit.dart';
import 'package:e_shop_flutter_app/features/auth/reset_password/cubit/reset_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordBlocListener extends StatelessWidget {
  const ResetPasswordBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResetPasswordCubit, ResetPasswordState>(
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
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                icon: const Icon(Icons.check_circle, color: Colors.green),
                content: Text(successMessage),
                actions: [
                  TextButton(
                    onPressed: () {
                      context.pop(); // Close alert
                      context.pushNamedAndRemoveUntil(
                        MyRoutes.login,
                        predicate: (route) => false,
                      );
                    },
                    child: const Text('Go to Login'),
                  ),
                ],
              ),
            );
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
