import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/services/utils.dart';
import 'package:news/widgets/empty_screen.dart';

class FavouriteScreen extends StatefulWidget {
  static const routeName = "/favourite";
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  late Color baseShimmerColor, highlightShimmerColor, widgetShimmerColor;

  @override
  void didChangeDependencies() {
    final Utils utils = Utils(context);

    baseShimmerColor = utils.baseShimmerColor;
    highlightShimmerColor = utils.highlightShimmerColor;
    widgetShimmerColor = utils.widgetShimmerColor;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final Color color = Utils(context).getColorForCurrentTheme;
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: color),
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          centerTitle: true,
          title: Text(
            'Favourite',
            style: GoogleFonts.alatsi(
              textStyle:
                  TextStyle(color: color, fontSize: 20, letterSpacing: 0.6),
            ),
          ),
        ),
        body: const EmptyNewsWidget(
          text: 'You didn\'t add anything yet to your bookmarks',
          imagePath: "assets/images/bookmark.png",
        )
        // ListView.builder(
        //     itemCount: 20,
        //     itemBuilder: (ctx, index) {
        //       return const NewsCard();
        //     }),
        );
  }
}
