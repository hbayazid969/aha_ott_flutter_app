import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/app_colors.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBgColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.appBarBgColor,
        title: Text(
          "Privacy Policy",
          style: GoogleFonts.roboto(
            fontSize: 16,
            color: AppColors.appWhiteColor,
          ),
        ),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back, color: AppColors.appWhiteColor)),
      ),
      body: ListView(
        children: [
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
            child: Column(
              children: [
                Text('''
We value your privacy and are committed to protecting your personal information. We collect only the necessary data to enhance your experience, such as account details and usage preferences. We do not share your information with third parties without your consent. Your data is securely stored and handled in accordance with industry standards. By using our app, you agree to the collection and use of your data as described in this policy.
              ''',style: GoogleFonts.roboto(
                  fontSize: 17,
                  color: AppColors.appWhiteColor
                ),)
              ],
            ),
          )
        ],
      ),
    );
  }
}
