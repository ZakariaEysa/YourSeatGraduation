

import 'package:flutter/cupertino.dart';
import '../../../../../generated/l10n.dart';

class OnBoardingContent {
  String image;
  String title;
  String description;

  OnBoardingContent(
      {required this.image, required this.title, required this.description});
}

List<OnBoardingContent> getOnBoardingContents(BuildContext context) {
  // Access the localized strings here
  var lang = S.of(context); // Now you can use 'lang' with BuildContext

  return [
    OnBoardingContent(
      title: lang.welcomeToYourSeat, // Use localized string here
      image: "assets/images/image 5.png",
      description: lang.enjoyEasyTicketBookingAndPersonalizedRecommendations,
    ),
    OnBoardingContent(
      title: lang.newMoviesEasyBooking, // Use localized string here
      image: "assets/images/image 6.png",
      description: lang.bookTicketsForTheLatestMoviesAtTheCinemaNearestToYou,
    ),
    OnBoardingContent(
      title: lang.favoriteItAddWatchlist, // Use localized string here
      image: "assets/images/image 7.png",
      description: lang.favoritesOrWatchlistForQuickAccessToYourBelovedMovies,
    ),
  ];
}
