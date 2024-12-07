import 'package:aha_ott_flutter_app/controller/all_series_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/app_colors.dart';
import 'details_screen.dart';

class AllSeriesScreen extends StatelessWidget {
  const AllSeriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllSeriesController>(
      builder: (controller) {
        // Show loading indicator if no data is fetched yet
        if (controller.isLoadingSeriesData==true && controller.allSeriesData == null) {
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
                "Series",
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
                if (!controller.isLoadingSeriesData && scrollNotification is ScrollEndNotification &&
                    scrollNotification.metrics.pixels == scrollNotification.metrics.maxScrollExtent) {
                  if (controller.allSeriesData.length % 10 == 0) {
                    // Load more data if more pages are available
                    controller.getAllSeriesData(page: controller.currentPage + 1);
                  }
                }
                return false;
              },
              child: ListView.builder(
                itemCount: controller.allSeriesData.length + 1, // Add 1 for loading indicator at the bottom
                itemBuilder: (context, index) {
                  // If this is the last item, show loading indicator for more data
                  if (index == controller.allSeriesData.length) {
                    return controller.isLoadingSeriesData
                        ? const Center(child: CircularProgressIndicator())
                        : const SizedBox.shrink();
                  }

                  // Display each movie in the list
                  var movie = controller.allSeriesData[index];
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
