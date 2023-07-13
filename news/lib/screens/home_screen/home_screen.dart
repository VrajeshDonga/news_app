import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/consts/enums.dart';
import 'package:news/models/news_model.dart';
import 'package:news/providers/news_provider.dart';
import 'package:news/screens/favourite_screen/favourites_screen.dart';
import 'package:news/screens/home_screen/widgets/news_card.dart';
import 'package:news/screens/home_screen/widgets/news_card_loading.dart';
import 'package:news/screens/home_screen/widgets/pagination_button.dart';
import 'package:news/screens/search_screen/search_screen.dart';
import 'package:news/services/utils.dart';
import 'package:news/widgets/empty_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // NewsTabType newsTabType = NewsTabType.allNews;
  var currentPageNumber = 0;
  String sortBy = SortBy.publishedAt.name;

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).getColorForCurrentTheme;
    final size = MediaQuery.of(context).size;
    final newsProvider = Provider.of<NewsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(color: color),
        centerTitle: true,
        leading: SizedBox(),
        elevation: 0,
        title: Text(
          "News App",
          style: GoogleFonts.alatsi(color: color),
        ),
        actions: [
          IconButton(
            icon: const Icon(IconlyLight.search),
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                    child: const SearchScreen(),
                    type: PageTransitionType.rightToLeft,
                    inheritTheme: true,
                    ctx: context),
              );
            },
          ),
          IconButton(
            icon: const Icon(IconlyLight.heart),
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                    child: const FavouriteScreen(),
                    type: PageTransitionType.rightToLeft,
                    inheritTheme: true,
                    ctx: context),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _sortBy(),
            _newsList(newsProvider),
            _paginationRow(newsProvider),
          ],
        ),
      ),
    );
  }

  FutureBuilder<List<NewsModel>> _newsList(NewsProvider newsProvider) {
    return FutureBuilder<List<NewsModel>>(
      // future: NewsAPIServices.getAllNews(
      //     page: currentPageNumber + 1, sortBy: sortBy),
      future: newsProvider.fetchAllNews(
              page: currentPageNumber + 1, sortBy: sortBy),
      builder: (context, snapShot) {
        if (snapShot.connectionState == ConnectionState.waiting &&
            snapShot.hasData) {
          return Flexible(
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                return const NewsCardLoading(
                  newsTabType: NewsTabType.allNews,
                );
              },
            ),
          );
        } else if (snapShot.hasError) {
          // TODO error handling
          return Flexible(
            child: EmptyNewsWidget(
              text: "An error occurred: ${snapShot.error}",
              imagePath: "assets/images/no_news.png",
            ),
          );
        } else if (snapShot.data == null) {
          return const Flexible(
            child: EmptyNewsWidget(
              text: "No news found!",
              imagePath: "assets/images/no_news.png",
            ),
          );
        }
        return Flexible(
          child: ListView.builder(
            itemCount: snapShot.data!.length,
            itemBuilder: (context, index) {
              NewsModel data = snapShot.data![index];
              return ChangeNotifierProvider.value(
                value: data,
                child: NewsCard(
                  key: UniqueKey(),
                ),
              );
            },
          ),
        );
      },
    );
  }

  _sortBy() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.only(
        right: 5,
        left: 10,
        bottom: 0,
        top: 0,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          elevation: 3,
          style: GoogleFonts.lato(fontSize: 16, color: Colors.black),
          isExpanded: true,
          isDense: false,
          items: [
            DropdownMenuItem(
              value: SortBy.relevancy.name,
              child: Text(
                SortBy.relevancy.name.capitalizeFirst(),
                style: GoogleFonts.lato(fontSize: 16),
              ),
            ),
            DropdownMenuItem(
              value: SortBy.popularity.name,
              child: Text(
                SortBy.popularity.name.capitalizeFirst(),
                style: GoogleFonts.lato(fontSize: 16),
              ),
            ),
            DropdownMenuItem(
              value: SortBy.publishedAt.name,
              child: Text(
                SortBy.publishedAt.name.capitalizeFirst(),
                style: GoogleFonts.lato(fontSize: 16),
              ),
            ),
          ],
          value: sortBy,
          onChanged: (String? value) {
            setState(() {
              sortBy = value!;
            });
          },
        ),
      ),
    );
  }

  Container _paginationRow(NewsProvider newsProvider) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 5.0),
            child: NewsPaginationButton(
              icon: IconlyLight.arrowLeft,
              onPressed: () {
                if (currentPageNumber > 0) {
                  setState(() {
                    currentPageNumber -= 1;
                  });
                }
              },
            ),
          ),
          Flexible(
            child: ListView.builder(
              itemCount: 5,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return InkWell(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  onTap: () {
                    setState(() {
                      currentPageNumber = index;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      color: index == currentPageNumber
                          ? Colors.blue
                          : Theme.of(context).cardColor,
                    ),
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
                    padding: const EdgeInsets.all(10.0),
                    alignment: Alignment.center,
                    child: Text(
                      (index + 1).toString(),
                      style: GoogleFonts.lato(
                        fontSize: 13.0,
                        color: index == currentPageNumber
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 5.0),
            child: NewsPaginationButton(
              icon: IconlyLight.arrowRight,
              onPressed: () {
                // TODO: getting the end of pagination with data
                if (currentPageNumber < newsProvider.getNewsList.length - 1) {
                  setState(() {
                    currentPageNumber += 1;
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
