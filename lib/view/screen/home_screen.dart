import 'package:aha_ott_flutter_app/controller/home_controller.dart';
import 'package:aha_ott_flutter_app/utils/app_strings.dart';
import 'package:aha_ott_flutter_app/view/screen/about_us_screen.dart';
import 'package:aha_ott_flutter_app/view/screen/all_movies_screen.dart';
import 'package:aha_ott_flutter_app/view/screen/all_series_screen.dart';
import 'package:aha_ott_flutter_app/view/screen/details_screen.dart';
import 'package:aha_ott_flutter_app/view/screen/privacy_policy_screen.dart';
import 'package:aha_ott_flutter_app/view/screen/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:aha_ott_flutter_app/utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});

  // Create a GlobalKey for Scaffold
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.appBgColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.appBarBgColor,
        title: Image.asset(
          "assets/images/splash_logo.png",
          height: 70,
          width: 70,
        ),
        leading: Padding(
          padding: const EdgeInsets.all(14.0),
          child: GestureDetector(
            onTap: (){
              // Open the drawer when the menu icon is pressed
              _scaffoldKey.currentState?.openDrawer();
            },
            child: Image.asset(
              "assets/images/menu_icon.png",
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: GestureDetector(
              onTap: (){
                Get.to(()=> SearchScreen(),transition: Transition.leftToRight);
              },
              child: Image.asset(
                "assets/images/search_icon.png",
                height: 30,
                width: 30,
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        width: 260,
        backgroundColor: AppColors.appBgColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
             DrawerHeader(
              decoration: BoxDecoration(
                color: AppColors.appBarBgColor,
              ),
              child: Center(
                child: Image.asset("assets/images/splash_logo.png",
                  height: 100,
                  width: 100,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.privacy_tip_sharp,color: AppColors.appWhiteColor,),
              title: Text('Privacy Policy',
                style: GoogleFonts.roboto(
                color: AppColors.appWhiteColor,
                fontSize: 17
              ),),
              onTap: () {
                Get.to(()=> const PrivacyPolicyScreen(),transition: Transition.leftToRight);
              },
            ),
            ListTile(
              leading: Icon(Icons.info,color: AppColors.appWhiteColor,),
              title: Text('About Us',
                style: GoogleFonts.roboto(
                    color: AppColors.appWhiteColor,
                    fontSize: 17
                ),),
              onTap: () {
                Get.to(()=> const AboutUsScreen(),transition: Transition.leftToRight);
              },
            ),
          ],
        ),
      ),
      body: GetBuilder<HomeController>(
        builder: (controller) {
          // Handle loading state
          if (controller.isLoadingMovieData==true && controller.isLoadingSeriesData==true) {
            return Center(child: SizedBox(
                height: 25,
                width: 25,
                child: CircularProgressIndicator(
                  color: AppColors.appTxtColor,
                )));
          }

          // If data is available, display the UI
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 12),
                // Carousel Slider for Movies
                controller.moviesData != null && controller.moviesData.isNotEmpty &&
                    controller.isLoadingMovieData == false && controller.isLoadingSeriesData == false
                    ? CarouselSlider.builder(
                  itemCount: controller.moviesData.length, // Specify the number of items in the list
                  itemBuilder: (BuildContext context, int index, int realIndex) {
                    var movie = controller.moviesData[index]; // Access the movie by index
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: movie['Poster'] != null
                          ? GestureDetector(
                        onTap: (){
                          Get.to(()=> DetailsScreen(
                            id:controller.moviesData[index]['imdbID'],
                          ),transition: Transition.leftToRight);
                        },
                            child: Image.network(
                                                  movie['Poster'], // Accessing 'Poster' field
                                                  fit: BoxFit.cover,
                                                  width: double.infinity,
                                                ),
                          )
                          : const Center(child: Text('No Image Available')), // Fallback for missing image
                    );
                  },
                  options: CarouselOptions(
                    height: 250.0,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(milliseconds: 800),
                    enlargeCenterPage: true,
                    scrollPhysics: const BouncingScrollPhysics(),
                  ),
                )
                    : const Center(child: Text('No movies available.')),
            
            
                const SizedBox(height: 24),
            
                // Movie Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Movies",
                            style: GoogleFonts.roboto(
                              color: AppColors.appTxtColor,
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              Get.to(()=> AllMoviesScreen(),transition: Transition.leftToRight);
                            },
                            child: Text(
                              "View All",
                              style: GoogleFonts.roboto(
                                color: AppColors.appWhiteColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 150,
                        child: controller.moviesData != null && controller.moviesData.isNotEmpty
                            ? ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.moviesData.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: GestureDetector(
                                onTap: (){
                                  Get.to(()=> DetailsScreen(
                                    id:controller.moviesData[index]['imdbID'],
                                  ),transition: Transition.leftToRight);
                                },
                                child: Container(
                                  height: 100,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(controller.moviesData[index]['Poster']),
                                      fit: BoxFit.cover,
                                    ),
                                    color: AppColors.appBarBgColor,
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                            : const Center(child: Text('No movies available.')),
                      ),
            
                      const SizedBox(height: 16),
            
                      // Series Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Series",
                            style: GoogleFonts.roboto(
                              color: AppColors.appTxtColor,
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              Get.to(()=> AllSeriesScreen(),transition: Transition.leftToRight);
                            },
                            child: Text(
                              "View All",
                              style: GoogleFonts.roboto(
                                color: AppColors.appWhiteColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 150,
                        child: controller.seriesData != null && controller.seriesData.isNotEmpty
                            ? ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: GestureDetector(
                                onTap: (){
                                  Get.to(()=> DetailsScreen(
                                    id:controller.seriesData[index]['imdbID'],
                                  ),transition: Transition.leftToRight);
                                },
                                child: Container(
                                  height: 100,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(controller.seriesData[index]['Poster']),
                                      fit: BoxFit.cover,
                                    ),
                                    color: AppColors.appBarBgColor,
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                            : const Center(child: Text('No series available.')),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }
}
