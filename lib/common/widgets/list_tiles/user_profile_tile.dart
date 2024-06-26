import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/features/personalization/controllers/user_controller.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/colors.dart';

class TUserProfileTile extends StatelessWidget {
  const TUserProfileTile({
    super.key, required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return ListTile(
      // leading: const TCircularImage(image: TImages.user, width: 50, height: 50, padding: 0),
      leading: Image.network(controller.user.value.profilePicture, width: 50, height: 50),
      title: Text(controller.user.value.fullName, style: Theme.of(context).textTheme.headlineSmall!.apply(color: TColors.white)),
      subtitle: Text(controller.user.value.email, style: Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.white)),
      trailing: IconButton (onPressed: onPressed, icon: const Icon (Iconsax.edit, color: TColors.white)),
    ); // ListTile
  }
}
