import 'package:aha_ott_flutter_app/controller/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:aha_ott_flutter_app/utils/app_colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'details_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // TextEditingController to control the text input in the search bar
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    Get.find<SearchControllerLoad>().getSearchData(search: "movies");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchControllerLoad>(
      builder: (searchController) {
        return Scaffold(
          backgroundColor: AppColors.appBgColor,
          appBar: AppBar(
            title:  Text("Search Movies", style: GoogleFonts.roboto(color: AppColors.appWhiteColor,
              fontSize: 17,
              fontWeight: FontWeight.w500
            )),
            backgroundColor: AppColors.appBarBgColor,
            elevation: 0,
            centerTitle: true,
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                icon:  Icon(Icons.close, color: AppColors.appWhiteColor),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search Bar
                  TextField(
                    controller: _searchController,
                    style: TextStyle(color: AppColors.appWhiteColor),
                    onChanged: (value){
                      Get.find<SearchControllerLoad>().getSearchData(search: value);
                    },
                    decoration: InputDecoration(
                      hintText: "Search for movies...",
                      hintStyle: GoogleFonts.roboto(color: AppColors.appWhiteColor.withOpacity(0.6),fontWeight: FontWeight.w400),
                      prefixIcon:  Icon(Icons.search, color: AppColors.appWhiteColor),
                      filled: true,
                      fillColor: AppColors.appBarBgColor.withOpacity(0.8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    ),
                  ),
                  const SizedBox(height: 10),
              
                  // Show loading indicator while searching
                  // Display search results message
                  if (!searchController.isLoadingSearch && searchController.searchData==null)
                    Center(
                      child: Text(
                        'What are you looking for?',
                        style: GoogleFonts.roboto(
                          color: AppColors.appWhiteColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
              
                  searchController.isLoadingSearch==false && searchController.searchData!=null?
                  ListView.builder(
                    padding: EdgeInsets.zero,
                      itemCount: searchController.searchData.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context,index){
                          return GestureDetector(
                            onTap: (){
                              Get.to(()=> DetailsScreen(
                                id:searchController.searchData[index]['imdbID'],
                              ),transition: Transition.leftToRight);
                            },
                            child: Card(
                              color: AppColors.appBarBgColor,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,vertical: 16
                                ),
                                child: ListTile(
                                  leading: Image.network("${searchController.searchData[index]["Poster"]}",
                                  ),
                                  title: Text("${searchController.searchData[index]["Title"]}",
                                  style: GoogleFonts.roboto(
                                    color: AppColors.appWhiteColor
                                  ),
                                  ),
                                  subtitle: Text("${searchController.searchData[index]["Year"]}",
                                    style: GoogleFonts.roboto(
                                        color: AppColors.appWhiteColor
                                    ),
                                ),
                              ),
                            )),
                          );
                  }):
                  Center(child: SizedBox(
                      height: 25,
                      width: 25,
                      child: CircularProgressIndicator(
                        color: AppColors.appTxtColor,
                      ))),
              
              
              
              
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
