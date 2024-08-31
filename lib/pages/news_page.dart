import 'package:flutter/material.dart';
import 'package:app/utils/articlepage.dart';
import 'package:metadata_fetch/metadata_fetch.dart';
import 'package:app/utils/list_item.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late List<ListItem> listTiles;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      isLoading = true;
    });

    listTiles = await Future.wait([
      fetchMetadata("https://www.lung.org/lung-health-diseases/wellness/protecting-your-lungs"),
      fetchMetadata("https://www.health.harvard.edu/diseases-and-conditions/what-to-do-for-bronchitis"),
      fetchMetadata('https://www.tandfonline.com/doi/full/10.1080/1059924X.2023.2178573')
    ]);

    setState(() {
      isLoading = false;
    });
  }

  Future<ListItem> fetchMetadata(String url) async {
    final data = await MetadataFetch.extract(url);
    return ListItem(
      data?.image ?? '',
      data?.title ?? 'No title',
      "20h", 
      url,
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double padding = screenWidth * 0.02;
    double cardHeight = screenHeight * 0.15;

    return Scaffold(
      backgroundColor: Color(0xFF81C9F3),
      appBar: AppBar(
        toolbarHeight: screenHeight * 0.1,
        centerTitle: true,
        title: Text(
          "News",
          style: TextStyle(color: Colors.black, fontSize: screenWidth * 0.05),
        ),
        backgroundColor: Color(0xFF81C9F3),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Color.fromARGB(255, 15, 124, 167),
                strokeCap: StrokeCap.round,
                valueColor: AlwaysStoppedAnimation<Color?>(Colors.white),
                strokeWidth: 6,
              ),
            )
          : RefreshIndicator(
              onRefresh: _loadData,
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: ListView.builder(
                  itemCount: listTiles.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ArticlePage(
                              url: listTiles[index].url,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 4,
                        margin: EdgeInsets.symmetric(vertical: padding / 2),
                        child: Padding(
                          padding: EdgeInsets.all(padding),
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                listTiles[index].imgUrl,
                                width: cardHeight * 0.75,
                                height: cardHeight,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(
                              listTiles[index].newsTitle,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: cardHeight * 0.2,
                              ),
                            ),
                            /*
                            subtitle: Text(
                              "${listTiles[index].author} • ${listTiles[index].date}",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: cardHeight * 0.15,
                              ),
                            ),*/
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }
}
