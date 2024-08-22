import 'package:bd_shop/src/data/utils/values.dart';
import 'package:bd_shop/src/presentation/widgets/full_width_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../blocs/blocs.dart';
import '../../../routes/routes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                "Welcome",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              Text(
                "Please enter your data to continue",
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).colorScheme.outlineVariant),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const Gap(40),
                BlocConsumer<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state is LoginLoading) {
                      context.goNamed(Routes.HOME_ROUTE);
                    }
                    if (state is LoginFailure) {
                      Fluttertoast.showToast(msg: state.message);
                    }
                  },
                  builder: (context, state) {
                    if (state is LoginInitial) {
                      return Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
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
                                              .outlineVariant),
                                ),
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
                            ],
                          ));
                    } else {
                      return Container();
                    }
                  },
                ),
                const Gap(20),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: InkWell(
                    onTap: () => context.pushNamed(Routes.FORGET_PASSWORD),
                    child: Text(
                      "Forgot password?",
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Theme.of(context).colorScheme.error),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Remember Me",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    BlocBuilder<RememberCubit, RememberState>(
                      builder: (context, state) {
                        return Switch(
                            activeColor: Colors.white,
                            activeTrackColor: Colors.green,
                            inactiveTrackColor: Colors.white,
                            value: state is SwitchStatusChange
                                ? state.value
                                : false,
                            onChanged: (value) => context
                                .read<RememberCubit>()
                                .switchToggle(value));
                      },
                    ),
                  ],
                ),
                const Gap(20),
              ],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .outlineVariant),
                        ),
                        const Gap(10),
                        InkWell(
                          onTap: () => context.goNamed(Routes.REGISTER_ROUTE),
                          child: Text(
                            "Signup",
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer),
                          ),
                        )
                      ],
                    ),
                    const Gap(10),
                    Text(
                      "By connecting your account confirm that you agree",
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Theme.of(context).colorScheme.outlineVariant),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "with our ",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .outlineVariant),
                        ),
                        Text(
                          "Term and Condition",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const Gap(20),
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  return FullWidthButton(
                    title:
                        state is LoginInitial ? Values.SIGN_IN_BUTTON_TEXT : '',
                    buttonChild: state is LoginLoading
                        ? const CircularProgressIndicator()
                        : null,
                    onTap: () {
                      if (state is LoginInitial) {
                        if (formKey.currentState!.validate()) {
                          context.read<LoginBloc>().add(RequestEmailLogin(
                              email: state.emailController.text.trim(),
                              password: state.passwordController.text.trim(),
                              isRemember: RememberCubit.isRemember));
                        }
                      }
                    },
                  );
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
