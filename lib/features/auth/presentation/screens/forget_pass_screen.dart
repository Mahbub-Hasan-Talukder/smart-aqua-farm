import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/app_extension.dart';
import '../../../../core/di/di.dart';
import '../../../../core/navigation/routes.dart';
import '../../../../core/validators/input_field_validation.dart';
import '../cubits/auth/forget_password/forget_pass_cubit.dart';
import '../cubits/validation/email_validation_cubit.dart';
import '../widgets/email_field.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _emailCtrl = TextEditingController();
  final _emailCubit = EmailValidationCubit();

  final _forgetPassCubit = getIt<ForgetPasswordCubit>();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _forgetPassCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _bodyElements(textTheme, colorScheme, screenSize, context),
        ),
      ),
    );
  }

  Column _bodyElements(
    TextTheme textTheme,
    ColorScheme colorScheme,
    Size screenSize,
    BuildContext context,
  ) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Text(
          'Reset your password',
          style: textTheme.textxlSemiBold.copyWith(color: colorScheme.primary),
        ),
        SizedBox(height: screenSize.width * .6),

        Text(
          'Enter email',
          style: textTheme.textBaseMedium.copyWith(color: colorScheme.tertiary),
        ),
        const SizedBox(height: 20),
        EmailField(
          screenSize: MediaQuery.sizeOf(context).width,
          hintText: 'email',
          controller: _emailCtrl,
          emailCubit: _emailCubit,
        ),
        const SizedBox(height: 20),
        BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
          bloc: _forgetPassCubit,
          listener: (context, state) {
            if (state is ForgetPasswordFailed) {
              _showSnackbar(context, state.failure.message, colorScheme.error);
            } else if (state is ForgetPasswordSuccess) {
              _showSnackbar(context, state.success.message, Colors.green);
              context.go(
                "${MyRoutes.forgotPassword}/${MyRoutes.otpRoute}",
                extra: _emailCtrl.text.trim(),
              );
            }
          },
          builder: (context, state) {
            return ElevatedButton(
              onPressed: state is ForgetPasswordLoading ? null : _validateInput,
              child:
                  state is ForgetPasswordLoading
                      ? const CircularProgressIndicator()
                      : const Text('submit'),
            );
          },
        ),
        IconButton(
          onPressed: () {
            print('dbg email testing: ${_emailCtrl.text}');
            context.go(
              "${MyRoutes.forgotPassword}/${MyRoutes.otpRoute}",
              extra: _emailCtrl.text.trim(),
            );
          },
          icon: Icon(Icons.pages),
        ),
      ],
    );
  }

  void _showSnackbar(BuildContext context, String msg, Color color) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(msg),
          backgroundColor: color,
          duration: const Duration(seconds: 2),
        ),
      );
    });
  }

  void _validateInput() {
    final validator = InputFieldValidation();
    if (_emailCtrl.text.isEmpty) {
      _emailCubit.showError('Email is required');
      return;
    }

    bool isEmailValid = validator.emailValidation(_emailCtrl.text);
    if (!isEmailValid) {
      _emailCubit.showError(
        'Please enter a valid email format (example@domain.com)',
      );
      return;
    }
    _emailCubit.showError(null);
    _forgetPassCubit.forgetPassword(_emailCtrl.text);
  }
}
