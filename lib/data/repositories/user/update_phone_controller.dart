import 'package:flutter/cupertino.dart';
import 'package:flutter_ecommerce/data/repositories/user/user_repository.dart';
import 'package:flutter_ecommerce/features/personalization/controllers/user_controller.dart';
import 'package:flutter_ecommerce/features/personalization/screens/profile/profile.dart';
import 'package:flutter_ecommerce/utils/constants/image_strings.dart';
import 'package:flutter_ecommerce/utils/network/network_manager.dart';
import 'package:flutter_ecommerce/utils/popups/full_screen_loader.dart';
import 'package:flutter_ecommerce/utils/popups/loaders.dart';
import 'package:get/get.dart';

class UpdatePhoneController extends GetxController {
  static UpdatePhoneController get instance => Get.find();

  final phoneNum = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  /// init user data when
  @override
  void onInit() {
    initializePhones();
    super.onInit();
  }

  /// Fetch user record
  Future<void> initializePhones() async {
    phoneNum.text = userController.user.value.phoneNumber;
  }

  Future<void> updatePhoneNum() async {
    try {
      // Start loading
      TFullScreenLoader.openLoadingDialog('We are updating your information...', TImages.docerAnimation);

      // Check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // form validation
      if (!updateUserNameFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Update user's first & last name in the firebase firestore
      Map<String, dynamic> phone = {'PhoneNumber': phoneNum.text.trim()};
      await userRepository.updateSingleField(phone);

      // Update the rx user value
      userController.user.value.phoneNumber = phoneNum.text.trim();

      // Remove loader
      TFullScreenLoader.stopLoading();

      // Show success message
      TLoaders.successSnackBar(title: 'Congratulation', message: 'Your phone number has been updated.');

      // Move to previous screen
      Get.off(() => const ProfileScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Error!', message: e.toString());
    }
  }
}