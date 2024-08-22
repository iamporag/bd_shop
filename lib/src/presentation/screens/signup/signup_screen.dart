import 'package:bd_shop/src/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../blocs/blocs.dart';
import '../../widgets/full_width_button.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Sign Up",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              BlocConsumer<SignupBloc, SignupState>(
                listener: (context, state){
                  if (state is SignupSuccess) {
                    context.goNamed(Routes.HOME_ROUTE);
                  }
                  if (state is SignupFailed) {
                    Fluttertoast.showToast(msg: state.message);
                  }
                },
                builder: (context, state) {
                  if (state is SignupInitial) {
                    return Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              controller: state.usernameController,
                              decoration: InputDecoration(
                                  label: const Text("Username"),
                                  labelStyle: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .outlineVariant)),
                              onChanged: (value) {
                                state.usernameController.text = value;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Enter Password";
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: state.emailController,
                              decoration: InputDecoration(
                                  label: const Text("Email"),
                                  labelStyle: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .outlineVariant)),
                              onChanged: (value) {
                                state.emailController.text = value;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Enter Password";
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: state.passwordController,
                              decoration: InputDecoration(
                                  label: const Text("Password"),
                                  labelStyle: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .outlineVariant)),
                              onChanged: (value) {
                                state.passwordController.text = value;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Enter Password";
                                }
                                return null;
                              },
                            ),
                            const Gap(20),
                          ],
                        ));
                  } else {
                    return Container();
                  }
                },
              ),
              const Gap(20),
            ],
          ),
        ),
        bottomNavigationBar:
            BlocBuilder<SignupBloc, SignupState>(builder: (context, state) {
          return FullWidthButton(
            onTap: () {
              if (state is SignupInitial) {
                if (formKey.currentState!.validate()) {
                  context.read<SignupBloc>().add(RequestEmailSignUp(
                      username: state.usernameController.text.trim(),
                      email: state.emailController.text.trim(),
                      password: state.passwordController.text.trim(),
                      confirmPassword:
                          state.confirmPasswordController.text.trim()));
                }
              }
            },
            title: "Sign Up",
            buttonChild: state is SignupLoading
                ? const CircularProgressIndicator()
                : null,
          );
        }));
  }
}
