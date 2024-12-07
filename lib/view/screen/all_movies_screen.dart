import 'package:aha_ott_flutter_app/view/screen/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/all_movies_controller.dart';
import '../../utils/app_colors.dart';

class AllMoviesScreen extends StatelessWidget {
  const AllMoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllMoviesController>(
      builder: (controller) {
        // Show loading indicator if no data is fetched yet
        if (controller.isLoadingMovieData==true && controller.allMoviesData == null) {
          return Center(child: SizedBox(
              height: 25,
              width: 25,
              child: CircularProgressIndicator(
                color: AppColors.appTxtColor,
              )));
        }
        else{
          // Show movies data in a list view
          return Scaffold(
            backgroundColor: AppColors.appBgColor,
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: AppColors.appBarBgColor,
              title: Text(
                "Movies",
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  color: AppColors.appWhiteColor,
                ),
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back, color: AppColors.appWhiteColor),
              ),
            ),
            body: NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                // Check if the user is at the bottom of the list
                if (!controller.isLoadingMovieData && scrollNotification is ScrollEndNotification &&
                    scrollNotification.metrics.pixels == scrollNotification.metrics.maxScrollExtent) {
                  if (controller.allMoviesData.length % 10 == 0) {
                    // Load more data if more pages are available
                    controller.getAllMoviesData(page: controller.currentPage + 1);
                  }
                }
                return false;
              },
              child: ListView.builder(
                itemCount: controller.allMoviesData.length + 1, // Add 1 for loading indicator at the bottom
                itemBuilder: (context, index) {
                  // If this is the last item, show loading indicator for more data
                  if (index == controller.allMoviesData.length) {
                    return controller.isLoadingMovieData
                        ? const Center(child: CircularProgressIndicator())
                        : const SizedBox.shrink();
                  }

                  // Display each movie in the list
                  var movie = controller.allMoviesData[index];
                  return ListTile(
                    onTap: (){
                      Get.to(()=> DetailsScreen(
                        id: movie["imdbID"],
                      ),transition: Transition.leftToRight);
                    },
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    title: Text(
                      movie['Title'] ?? 'No Title',
                      style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.appWhiteColor),
                    ),
                    subtitle: Text(
                      movie['Year'] ?? 'Unknown Year',
                      style: GoogleFonts.roboto(fontSize: 12, color: Colors.grey),
                    ),
                    leading: movie['Poster'] != null
                        ? Image.network(
                      movie['Poster'] ?? '',
                      width: 50,
                      height: 75,
                      fit: BoxFit.cover,
                    )
                        : const Icon(Icons.movie, size: 50),
                  );
                },
              ),
            ),
          );
        }

      },
    );
  }
}
