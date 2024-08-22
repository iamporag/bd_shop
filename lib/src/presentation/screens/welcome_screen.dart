import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

import '../../blocs/blocs.dart';
import '../../routes/routes.dart';
import '../widgets/full_width_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Let's Get Started",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          BlocConsumer<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state is LoginLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      SocialLoginButton(
                        onPressed: () => context.read<LoginBloc>().add(RequestFacebookLogin()),
                        buttonType: SocialLoginButtonType.facebook,
                      ),
                      const Gap(20),
                      SocialLoginButton(
                        onPressed: () => context.read<LoginBloc>().add(RequestTwitterLogin()),
                        buttonType: SocialLoginButtonType.twitter,
                      ),
                      const Gap(20),
                      SocialLoginButton(
                        onPressed: () => context.read<LoginBloc>().add(RequestGoogleLogin()),
                        buttonType: SocialLoginButtonType.google,
                      ),
                    ],
                  ),
                );
              },
              listener: (context, state) {
                if (state is LoginSuccess) {
                  Fluttertoast.showToast(
                    msg: "Login Success"
                    );
                    Future.delayed(const Duration(milliseconds: 500),(){
                      context.goNamed(Routes.HOME_ROUTE);
                    });
                }
              }),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                  TextButton(
                      onPressed: () => context.pushNamed(Routes.LOGIN_ROUTE),
                      child: Text(
                        "Signin",
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer),
                      ))
                ],
              ),
              FullWidthButton(
                title: "Create An Account",
                onTap: () => context.pushNamed(Routes.REGISTER_ROUTE),
              )
            ],
          )
        ],
      ),
    );
  }
}
