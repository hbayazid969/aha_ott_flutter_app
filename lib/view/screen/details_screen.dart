import 'package:aha_ott_flutter_app/view/screen/player_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aha_ott_flutter_app/controller/details_controller.dart';
import '../../utils/app_colors.dart';

class DetailsScreen extends StatefulWidget {
  final dynamic id;

  const DetailsScreen({super.key, this.id});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch details using the movie ID when the screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<DetailsController>().getDetailsData(id: widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBgColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.appBarBgColor,
        title: Text(
          "Details",
          style: GoogleFonts.roboto(
            fontSize: 16,
            color: AppColors.appWhiteColor,
          ),
        ),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back, color: AppColors.appWhiteColor)),
      ),
      body: GetBuilder<DetailsController>(
        builder: (controller) {
          // Check if data is still loading
          if (controller.isLoadingDetailsData && controller.detailsData==null) {
            return Center(child: SizedBox(
                height: 25,
                width: 25,
                child: CircularProgressIndicator(
                  color: AppColors.appTxtColor,
                )));
          }

          // Get the movie data
          final details = controller.detailsData;

          if (controller.detailsData!=null) {
            return SingleChildScrollView(
            child: Column(
              children: [

                // Movie Poster
                Image.network(
                  details['Poster'],
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 16),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // Movie Title
                      Text(
                        details['Title'],
                        style: GoogleFonts.roboto(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.appWhiteColor
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Movie Year and Genre
                      Text(
                        '${details['Year']} | ${details['Genre']}',
                        style: GoogleFonts.roboto(
                          fontSize: 17,
                            color: AppColors.appWhiteColor
                        ),
                      ),
                      const SizedBox(height: 16),

                      // IMDB Rating & Votes
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.yellow, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            '${details['imdbRating']} IMDb | ${details['imdbVotes']} votes',
                            style: GoogleFonts.roboto(
                              fontSize: 17,
                                color: AppColors.appWhiteColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Movie Plot
                      Text(
                        'Plot: ${details['Plot']}',
                        style: GoogleFonts.roboto(
                          fontSize: 17,
                            color: AppColors.appWhiteColor
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Director and Cast
                      Text(
                        'Director: ${details['Director']}',
                        style: GoogleFonts.roboto(
                          fontSize: 17,
                            color: AppColors.appWhiteColor
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        'Cast: ${details['Actors']}',
                        style: GoogleFonts.roboto(
                          fontSize: 17,
                            color: AppColors.appWhiteColor
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Movie Other Details
                      Text(
                        'Language: ${details['Language']}',
                        style: GoogleFonts.roboto(
                          fontSize: 17,
                            color: AppColors.appWhiteColor
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Runtime: ${details['Runtime']}',
                        style: GoogleFonts.roboto(
                            fontSize: 17,
                            color: AppColors.appWhiteColor
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Country: ${details['Country']}',
                        style: GoogleFonts.roboto(
                           fontSize: 17,
                            color: AppColors.appWhiteColor
                        ),
                      ),

                      const SizedBox(height: 24,),

                    ],
                  ),
                ),
              ],
            ),
          );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
      floatingActionButton: ClipOval(
        child: FloatingActionButton(
          backgroundColor: AppColors.appTxtColor,
          onPressed: (){
            Get.to(()=> const VideoPlayerScreen());
          },
        child: Icon(Icons.play_circle,size: 40,color: AppColors.appWhiteColor,),
        ),
      ),
    );
  }
}
