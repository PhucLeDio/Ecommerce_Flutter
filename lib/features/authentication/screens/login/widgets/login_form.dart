import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/features/authentication/controllers/login/login_controller.dart';
import 'package:flutter_ecommerce/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:flutter_ecommerce/features/authentication/screens/signup/signup.dart';
import 'package:flutter_ecommerce/navigation_menu.dart';
import 'package:flutter_ecommerce/utils/validators/validation.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';

class TLoginForm extends StatelessWidget {
  const TLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(LoginController());

    return Form(child: Padding(
      padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
      child: Column(
        children: [
          /// Email
          TextFormField(
            // controller: controller.email,
            // validator: (value) => TValidator.validateEmail(value),
            decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.direct_right),
              labelText: TTexts.email,
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          /// Password
          /* Obx(() => TextFormField(
              validator: (value) => TValidator.validatePassword(value),
              controller: controller.password,
              obscureText: controller.hidePassword.value,
              decoration: InputDecoration(
                labelText: TTexts.password,
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                  icon: Icon(controller.hidePassword.value ? Iconsax.eye_slash : Iconsax.eye),
                ),
              ),
            ),
          ),
           */
          TextFormField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.password_check),
              labelText: TTexts.password,
                suffixIcon: Icon(Iconsax.eye_slash)
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields / 2),

          /// Remember me & forget password
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Remember me
              Row(
                children: [
                  // Obx(() => Checkbox(value: controller.rememberMe.value, onChanged: (value) => controller.rememberMe.value =! controller.rememberMe.value)),
                  Checkbox(value: true, onChanged: (value){}),
                  const Text(TTexts.rememberMe)
                ],
              ),

              /// forget password
              TextButton(onPressed: () => Get.to(() => const ForgetPassword()), child: const Text(TTexts.forgetPassword))
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwSections,),

          /// Sign In button
          // SizedBox(width: double.infinity ,child: ElevatedButton(onPressed: () => Get.to(() => const NavigationMenu()), child: Text(TTexts.signIn))),
          SizedBox(width: double.infinity ,child: ElevatedButton(onPressed: () => Get.to(() => const NavigationMenu()), child: Text(TTexts.signIn))),
          const SizedBox(height: TSizes.spaceBtwItems),

          /// Create account button
          SizedBox(width: double.infinity ,child: OutlinedButton(onPressed: () => Get.to(() => const SignupScreen()), child: const Text(TTexts.createAccount))),
        ],
      ),
    ));
  }
}