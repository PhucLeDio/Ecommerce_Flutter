import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/data/repositories/authentication/authentication_repository.dart';
import 'package:flutter_ecommerce/data/repositories/user/user_repository.dart';
import 'package:flutter_ecommerce/features/authentication/screens/signup/verify_email.dart';
import 'package:flutter_ecommerce/utils/popups/full_screen_loader.dart';
import 'package:flutter_ecommerce/utils/popups/loaders.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/network/network_manager.dart';
import '../../../personalization/models/user_model.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  /// variables
  final hidePassword = true.obs;
  final privacyPolicy = true.obs;
  final email = TextEditingController(); // Controller for email input
  final lastName = TextEditingController(); // Controller for last name input
  final username = TextEditingController(); // Controller for username input
  final password = TextEditingController(); // Controller for password input
  final firstName = TextEditingController(); // Controller for first name input
  final phoneNumber = TextEditingController(); // Controller for phone number input
  GlobalKey<FormState> signupFormkey = GlobalKey<FormState>(); // Form key for form validation

  /// -- Sign up
  void signup() async {
    try {
      //Start Loading
      TFullScreenLoader.openLoadingDialog('We are processing your information...', TImages.docerAnimation);

      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // remove loader
        TFullScreenLoader.stopLoading();
        return;
      }

      //Form Validation
      if (!signupFormkey.currentState!.validate()) {
        // remove loader
        TFullScreenLoader.stopLoading();
        return;
      }

      //Privacy Policy Check
      if (!privacyPolicy.value) {
        TLoaders.warningSnackbar(
            title: 'Accept privacy policy',
            message: 'In order to create account, you must have to read and accept the privacy policy & terms of use.'
        );
        return;
      }

      //Register user in the Firebase Authentication & Save user data in the Firebase
      final userCredential = await AuthenticationRepository.instance.registerWithEmailAndPassword(email.text.trim(), password.text.trim());

      //Save Authenticated user data in the Firebase Firestore
      final newUser = UserModel(
          id: userCredential.user!.uid,
          firstName: firstName.text.trim(),
          lastName: lastName.text.trim(),
          username: username.text.trim(),
          email: email.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          profilePicture: '',
          role: 'user'
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      // remove loader
      TFullScreenLoader.stopLoading();

      //Show Success Message
      TLoaders.successSnackBar(title: 'Congratulations', message: 'Your account has been created! Verify email to continue.');

      //Move to Verify Email Screen
      Get.to(() => VerifyEmailScreen(email: email.text.trim(),));
    } catch (e) {
      //Remove Loader
      TFullScreenLoader.stopLoading();
      // Show some Generic Error to the user
      TLoaders.errorSnackBar(title: 'Oops!', message: e.toString());
    }
  }
}