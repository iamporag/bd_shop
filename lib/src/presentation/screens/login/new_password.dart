import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../routes/routes.dart';
import '../../widgets/full_width_button.dart';

class NewPassword extends StatelessWidget {
  const NewPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               Text(
                  "Forgot Password",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
                ),
              TextFormField(
               // controller: state.usernameController,
               decoration: InputDecoration(
                   label: const Text("New Password"),
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
      ),
      bottomNavigationBar: FullWidthButton(
        onTap: () => context.pushNamed(Routes.HOME_ROUTE),
        title: "Rest Password",
      ),
    );
  }
}