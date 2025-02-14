import 'package:craftify_vendor/common/button.dart';
import 'package:craftify_vendor/common/crafti_hub_logo.dart';
import 'package:craftify_vendor/common/flush_bar.dart';
import 'package:craftify_vendor/common/form_field_features.dart';
import 'package:craftify_vendor/screens/Auth/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    final authProvider = Provider.of<AuthProvider>(context);
    final space = SizedBox(
      height: 1.5.h,
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 10.h),
                craftiHubLogo(),
                SizedBox(
                  height: 6.h,
                ),
                TextFormField(
                  controller: authProvider.tcName,
                  validator: emptyCheckValidator,
                  decoration: textFormFieldDecoration(
                      hinttext: 'Full Name',
                      prefixIcon: Icons.person_2_outlined),
                ),
                space,
                TextFormField(
                  controller: authProvider.tcPhone,
                  validator: emptyCheckValidator,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  keyboardType: TextInputType.number,
                  decoration: textFormFieldDecoration(
                      hinttext: 'Phone', prefixIcon: Icons.phone_outlined),
                ),
                space,
                TextFormField(
                  controller: authProvider.tcEmail,
                  validator: emailValidator,
                  decoration: textFormFieldDecoration(
                      hinttext: 'Email', prefixIcon: Icons.email_outlined),
                ),
                space,
                TextFormField(
                  controller: authProvider.tcWhatsappNumber,
                  validator: emptyCheckValidator,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  keyboardType: TextInputType.number,
                  decoration: textFormFieldDecoration(
                      hinttext: 'WhatsApp Number',
                      prefixIcon: Icons.chat_bubble_outline),
                ),
                space,
                InkWell(
                  onTap: () async {
                    authProvider.profileImage == null
                        ? await authProvider.pickProfileImage()
                        : authProvider.profileImage = null;
                  },
                  child: TextFormField(
                    enabled: false,
                    decoration: textFormFieldDecoration(
                        hinttext: authProvider.profileImage == null
                            ? 'Select Image'
                            : authProvider.imageName ?? 'Select Image',
                        prefixIcon: Icons.image_outlined,
                        suffix: authProvider.profileImage == null
                            ? null
                            : IconButton(
                                onPressed: () {
                                  authProvider.profileImage = null;
                                },
                                icon: Icon(Icons.close))),
                  ),
                ),
                space,
                TextFormField(
                  controller: authProvider.tcPassword,
                  obscureText: true,
                  validator: emptyCheckValidator,
                  decoration: textFormFieldDecoration(
                      hinttext: 'Password', prefixIcon: Icons.lock_outline),
                ),
                space,
                TextFormField(
                  controller: authProvider.tcConfirmPassword,
                  validator: (value) => confirmPasswordValidator(
                      value, authProvider.tcPassword.text),
                  decoration: textFormFieldDecoration(
                      hinttext: 'Confirm Password',
                      prefixIcon: Icons.lock_reset_outlined),
                ),
                SizedBox(
                  height: 3.5.h,
                ),
                customButton(
                    isLoading: authProvider.isLoading,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final data = {
                          "name": authProvider.tcName.text,
                          "contact_number": authProvider.tcPhone.text,
                          "whatsapp_number": authProvider.tcWhatsappNumber.text,
                          "email": authProvider.tcEmail.text,
                          "display_image": authProvider.profileImage
                        };
                        if (authProvider.profileImage == null) {
                          showFlushbar(
                              context: context,
                              color: Colors.red,
                              icon: Icons.image_not_supported_outlined,
                              message: 'Profile Picture Not Selected');
                        } else if (authProvider.tcPhone.text.length < 10 ||
                            authProvider.tcWhatsappNumber.text.length < 10) {
                          showFlushbar(
                              context: context,
                              color: Colors.red,
                              icon: Icons.phone_outlined,
                              message: 'Enter 10 digit Number');
                        } else {
                          authProvider.registerVendor(data, context);
                        }
                      }
                    },
                    buttonName: 'Register',
                    color: Colors.cyan),
                space,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                    ),
                    TextButton(
                        onPressed: () {
                          authProvider.resetRegister();
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.cyan),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
