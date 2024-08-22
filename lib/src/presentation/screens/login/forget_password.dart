import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../routes/routes.dart';
import '../../widgets/full_width_button.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "New Password",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
               TextFormField(
                // controller: state.usernameController,
                decoration: InputDecoration(
                    label: const Text("Password"),
                    labelStyle: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(
                            color:
                                Theme.of(context).colorScheme.outlineVariant)),
                onChanged: (value) {
                  // state.usernameController.text = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter Email";
                  }
                  return null;
                },
              ),
               TextFormField(
                // controller: state.usernameController,
                decoration: InputDecoration(
                    label: const Text("Confirm Password"),
                    labelStyle: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(
                            color:
                                Theme.of(context).colorScheme.outlineVariant)),
                onChanged: (value) {
                  // state.usernameController.text = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter Email";
                  }
                  return null;
                },
              ),
              ],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Please write your new password.",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.outlineVariant),
              ),
              const Gap(20),
               FullWidthButton(
                title: "Reset Password", onTap: () => context.pushNamed(Routes.HOME_ROUTE),)
            ],
          )
        ],
      ),
    );
  }
}
