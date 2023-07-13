import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:news/models/news_model.dart';
import 'package:news/providers/news_provider.dart';
import 'package:news/screens/home_screen/widgets/news_card.dart';
import 'package:news/services/utils.dart';
import 'package:news/widgets/empty_screen.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final FocusNode focusNode;
  late final TextEditingController _searchTextFieldController;

  @override
  void initState() {
    _searchTextFieldController = TextEditingController();
    focusNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    if (mounted) {
      _searchTextFieldController.dispose();
      focusNode.dispose();
    }
    super.dispose();
  }

  List<NewsModel?> searchList = [];
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).getColorForCurrentTheme;
    final newsProvider = Provider.of<NewsProvider>(context);

    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(IconlyLight.arrowLeft2),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10.0),
                          child: TextField(
                            style: TextStyle(color: color),
                            autofocus: true,
                            textInputAction: TextInputAction.search,
                            controller: _searchTextFieldController,
                            focusNode: focusNode,
                            keyboardType: TextInputType.text,
                            onEditingComplete: () async {
                              searchList = await newsProvider.searchNews(
                                query: _searchTextFieldController.text,
                              );
                              isSearching = true;
                              focusNode.unfocus();
                              setState(() {});
                            },
                            decoration: InputDecoration(
                              hintText: "Search",
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              contentPadding: const EdgeInsets.only(bottom: 5),
                              suffix: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    _searchTextFieldController.clear();
                                    focusNode.unfocus();
                                    isSearching = false;
                                    searchList.clear();

                                    setState(() {
                                    });
                                  },
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.red,
                                    size: 18.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (isSearching && searchList.isEmpty)
                    const Flexible(
                      child: EmptyNewsWidget(
                        text: "Oops! No results found!",
                        imagePath: "assets/images/search.png",
                      ),
                    ),
                  if (isSearching && searchList.isNotEmpty)
                    ListView.builder(
                      itemCount: searchList.length,
                      itemBuilder: (context, index) {
                        NewsModel data = searchList[index]!;
                        return ChangeNotifierProvider.value(
                          value: data,
                          child: NewsCard(
                            key: UniqueKey(),
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
