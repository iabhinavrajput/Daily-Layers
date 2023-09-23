import 'package:cached_network_image/cached_network_image.dart';
import 'package:daily_layer/models/categories_news_model.dart';
import 'package:daily_layer/models/news_channel_headline_model.dart';
import 'package:daily_layer/view_model/news_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum NewsFilterList { bbcNews, bbcSports, eSPN, googleNews, googleNewsIndia }

class _HomeScreenState extends State<HomeScreen> {
  NewsViewModel newsViewModel = NewsViewModel();
  NewsFilterList? selectedMenu;
  final format = DateFormat('MMMM dd, yyyy');
  String name = 'bbc-news';
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/categories');
          },
          icon: Image.asset(
            'assets/images/category_icon.png',
            height: 30,
            width: 30,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'News',
          style: GoogleFonts.poppins(
              fontSize: 24, fontWeight: FontWeight.w700, color: Colors.black),
        ),
        // creating the pop up button : like this will show right side
        actions: [
          PopupMenuButton<NewsFilterList>(
              initialValue: selectedMenu,
              icon: const Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
              onSelected: (NewsFilterList item) {
                if (NewsFilterList.bbcNews.name == item.name) {
                  name = 'bbc-news';
                }
                if (NewsFilterList.bbcSports.name == item.name) {
                  name = 'bbc-sport';
                }
                if (NewsFilterList.googleNews.name == item.name) {
                  name = 'google-news';
                }
                if (NewsFilterList.googleNewsIndia.name == item.name) {
                  name = 'google-news-in';
                }
                if (NewsFilterList.eSPN.name == item.name) {
                  name = 'espn';
                }
                setState(() {
                  selectedMenu = item;
                });
              },
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<NewsFilterList>>[
                    const PopupMenuItem<NewsFilterList>(
                      value: NewsFilterList.bbcNews,
                      child: Text("BBC News"),
                    ),
                    const PopupMenuItem<NewsFilterList>(
                      value: NewsFilterList.bbcSports,
                      child: Text("BBC Sports"),
                    ),
                    const PopupMenuItem<NewsFilterList>(
                      value: NewsFilterList.eSPN,
                      child: Text("ESPN"),
                    ),
                    const PopupMenuItem<NewsFilterList>(
                      value: NewsFilterList.googleNews,
                      child: Text("Google News"),
                    ),
                    const PopupMenuItem<NewsFilterList>(
                      value: NewsFilterList.googleNewsIndia,
                      child: Text("Google News India"),
                    ),
                  ]),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 20),
        children: [
          SizedBox(
            height: height * .55,
            width: width,
            child: FutureBuilder<NewsChannelsHeadlinesModel>(
              future: newsViewModel.fetchNewsChannelHeadLinesApi(name),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SpinKitCircle(
                      size: 50,
                      color: Colors.green.shade500,
                    ),
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.articles!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        DateTime dateTime = DateTime.parse(snapshot
                            .data!.articles![index].publishedAt
                            .toString());
                        return SizedBox(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: height * .6,
                                width: width * .9,
                                padding: EdgeInsets.symmetric(
                                    horizontal: height * .02),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child:
                                      snapshot.data == null ||
                                              snapshot.data!.articles == null ||
                                              snapshot.data!.articles!.isEmpty ||
                                      snapshot.data!.articles![index]
                                                  .urlToImage ==
                                              null
                                          ? Image.asset(
                                              'assets/images/google_news.png',
                                              height: height * .18,
                                              width: width * .3,
                                            )
                                          : CachedNetworkImage(
                                              imageUrl: snapshot.data!
                                                  .articles![index].urlToImage
                                                  .toString(),
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  Container(
                                                child: spinKit,
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(
                                                Icons.error_outline,
                                                color: Colors.red,
                                              ),
                                            ),
                                ),
                              ),
                              Positioned(
                                bottom: 20,
                                child: Card(
                                  elevation: 5,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Container(
                                    alignment: Alignment.bottomCenter,
                                    padding: const EdgeInsets.all(15),
                                    height: height * .22,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: width * .7,
                                          child: Text(
                                            snapshot
                                                .data!.articles![index].title
                                                .toString(),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                        const Spacer(),
                                        Container(
                                          width: width * .7,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                snapshot.data!.articles![index]
                                                    .source!.name
                                                    .toString(),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Text(
                                                format.format(dateTime),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },);
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: FutureBuilder<CategoriesNewsModel>(
              future: newsViewModel.fetchNewsCategoriesNewsApi('General'),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SpinKitCircle(
                      size: 50,
                      color: Colors.green.shade500,
                    ),
                  );
                } else {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.articles!.length,
                      itemBuilder: (context, index) {
                        DateTime dateTime = DateTime.parse(snapshot
                            .data!.articles![index].publishedAt
                            .toString());
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child:
                                    snapshot.data == null ||
                                            snapshot.data!.articles == null ||
                                            snapshot.data!.articles!.isEmpty ||
                                    snapshot.data!.articles![index]
                                                .urlToImage ==
                                            null
                                        ? Image.asset(
                                            'assets/images/google_news.png',
                                            height: height * .18,
                                            width: width * .3,
                                          )
                                        : CachedNetworkImage(
                                            imageUrl: snapshot.data!
                                                .articles![index].urlToImage
                                                .toString(),
                                            fit: BoxFit.cover,
                                            height: height * .18,
                                            width: width * .3,
                                            placeholder: (context, url) =>
                                                Container(
                                              child: Center(
                                                child: SpinKitCircle(
                                                  size: 50,
                                                  color: Colors.green.shade500,
                                                ),
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(
                                              Icons.error_outline,
                                              color: Colors.red,
                                            ),
                                          ),
                              ),
                              Expanded(
                                  child: Container(
                                height: height * .18,
                                padding: const EdgeInsets.only(left: 15),
                                child: Column(children: [
                                  Text(
                                    snapshot.data!.articles![index].title
                                        .toString(),
                                    maxLines: 3,
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        snapshot
                                            .data!.articles![index].source!.name
                                            .toString(),
                                        style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      // Text(
                                      //   format.format(dateTime),
                                      //   maxLines: 3,
                                      //   style: GoogleFonts.poppins(
                                      //       fontSize: 15,
                                      //       fontWeight: FontWeight.w500),
                                      // ),
                                    ],
                                  ),
                                ]),
                              ))
                            ],
                          ),
                        );
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

const spinKit = SpinKitFadingCircle(
  color: Colors.yellow,
  size: 50,
);


