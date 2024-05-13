import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/common/widgets/appbar/appbar.dart';
import 'package:flutter_ecommerce/features/personalization/controllers/address_controller.dart';
import 'package:flutter_ecommerce/features/personalization/screens/address/address.dart';
import 'package:flutter_ecommerce/utils/constants/sizes.dart';
import 'package:flutter_ecommerce/utils/validators/validation.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;

    return Scaffold(
      appBar: const TAppBar(showBackArrow: true, title: Text("Add new address")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
            key: controller.addressFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: controller.name,
                  validator: (value) => TValidator.validateEmptyText('Name', value),
                  decoration: const InputDecoration(prefixIcon: Icon(Iconsax.user), labelText: 'Name'),
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                TextFormField(
                  controller: controller.phoneNumber,
                    validator: TValidator.validatePhoneNumber,
                    decoration: const InputDecoration(prefixIcon: Icon(Iconsax.mobile), labelText: "Phone")),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                Row(
                  children: [
                    Expanded(child: TextFormField(controller: controller.street, validator: (value) => TValidator.validateEmptyText('Street', value), decoration: const InputDecoration(prefixIcon: Icon(Iconsax.building_31), labelText: "Street"))),
                    const SizedBox(width: TSizes.spaceBtwInputFields),
                    Expanded(child: TextFormField(controller: controller.postalCode, validator: (value) => TValidator.validateEmptyText('Postal Code', value), decoration: const InputDecoration(prefixIcon: Icon(Iconsax.code), labelText: "Postal code"))),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                Row(
                  children: [
                    Expanded(child: TextFormField(controller: controller.city, validator: (value) => TValidator.validateEmptyText('City', value), expands: false, decoration: const InputDecoration(prefixIcon: Icon(Iconsax.building), labelText: "City"))),
                    const SizedBox(width: TSizes.spaceBtwInputFields),
                    Expanded(child: TextFormField(controller: controller.state, validator: (value) => TValidator.validateEmptyText('State', value), expands: false, decoration: const InputDecoration(prefixIcon: Icon(Iconsax.activity), labelText: "State"))),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                TextFormField(controller: controller.country, validator: (value) => TValidator.validateEmptyText('Country', value), decoration: const InputDecoration(prefixIcon: Icon(Iconsax.global), labelText: "Country")),
                const SizedBox(height: TSizes.defaultSpace),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.addNewAddresses,
                    child: const Text("Save"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const AddNewAddressScreen()),
        backgroundColor: TColors.primary,
        child: const Icon(Iconsax.location, color: TColors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, // Positions the FAB in the bottom right corner
    );
  }
}
