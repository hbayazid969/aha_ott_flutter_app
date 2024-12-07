import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/app_colors.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBgColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.appBarBgColor,
        title: Text(
          "About Us",
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
We are passionate about delivering the best in entertainment with a diverse collection of movies and series. Our app offers a seamless streaming experience, bringing you the latest content in high quality. We strive to keep you entertained with a wide range of genres, personalized recommendations, and an easy-to-use interface. Our goal is to provide you with endless hours of entertainment, anytime, anywhere. Join us and discover a world of movies at your fingertips!
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
