import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:news_app/models/news_model.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Article> photos = [];

  Future<List<Article>> getNewsList() async {
    var response = await http.get(
      Uri.parse(
          "https://newsapi.org/v2/everything?q=tesla&from=2024-12-26&sortBy=publishedAt&apiKey=2eebeaa50122431cb3c2a603d3920bae"),
    );
    var data = jsonDecode(response.body.toString());
    List<dynamic> articlesData = data["articles"];
    if (response.statusCode == 200) {
      for (var article in articlesData) {
        photos.add(Article.fromJson(article));
      }
      return photos;
    }
    return photos;
  }

  PageController _controller = PageController();
  int currenIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "News App",
          style: TextStyle(
            color: Colors.blue,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications_none,
                size: 30,
              )),
        ],
      ),
      body: PageView(
        controller: _controller,
        onPageChanged: (int index) {
          setState(() {
            currenIndex = index;
          });
        },
        children: [
          Container(
            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  height: MediaQuery.of(context).size.height * 0.06,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1),
                  ),
                  child: Center(
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.search,
                          size: 32,
                        ),
                        hintText: "Search",
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Trending",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      Text(
                        "See all",
                        style: TextStyle(
                            color: Colors.grey.shade700, fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  height: MediaQuery.of(context).size.height * 0.30,
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: AssetImage("assets/img_1.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        flex: 3,
                      ),
                      Expanded(
                          child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              "Europe",
                              style: TextStyle(color: Colors.grey.shade800),
                            ),
                            Text(
                              "Russian warship: Moskva sinks in Black Sea",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              children: [
                                Text(
                                  "BBC News",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "4h ago",
                                  style: TextStyle(color: Colors.grey.shade800),
                                ),
                              ],
                            )
                          ],
                        ),
                      )),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Latest",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      Text(
                        "See all",
                        style: TextStyle(
                            color: Colors.grey.shade700, fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, top: 20),
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _item_category(name: "All", isActive: true),
                      _item_category(name: "Sports", isActive: false),
                      _item_category(name: "Politics", isActive: false),
                      _item_category(name: "Bussiness", isActive: false),
                      _item_category(name: "Health", isActive: false),
                      _item_category(name: "Travel", isActive: false),
                      _item_category(name: "Science", isActive: false),
                    ],
                  ),
                ),
                // ListView builder to display news articles
                Container(
                  height: MediaQuery.of(context).size.height *
                      0.7, // define height for ListView
                  child: FutureBuilder(
                    future: getNewsList(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Article>> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          var article = snapshot.data![index];
                          return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            height: MediaQuery.of(context).size.height * 0.13,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            article.urlToImage.toString()),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    margin: EdgeInsets.only(left: 5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          article.author.toString(),
                                          style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontSize: 16,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          article.description.toString(),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(article.publishedAt.toString())
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        itemCount: snapshot.data?.length ?? 0,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(),
          Container(),
          Container(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.blue,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        currentIndex: currenIndex,
        onTap: (int index) {
          setState(() {
            currenIndex = index;
            _controller.jumpToPage(index);
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.explore_outlined), label: "Explore"),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_border), label: "Bookmark"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: "Profile"),
        ],
      ),
    );
  }

  Widget _item_category({name, isActive}) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          border: isActive
              ? Border(bottom: BorderSide(color: Colors.blue, width: 2))
              : null,
        ),
        child: Text(
          name,
          style: TextStyle(color: Colors.grey.shade800, fontSize: 18),
        ),
      ),
    );
  }
}
