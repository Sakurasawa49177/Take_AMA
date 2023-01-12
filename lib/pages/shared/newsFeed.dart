import 'package:flutter/material.dart';

import '../../models/News.dart';
import '../../services/NewsAPI.dart';

class NewsFeed extends StatefulWidget {
  const NewsFeed({Key? key}) : super(key: key);

  @override
  State<NewsFeed> createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(9),
        child: FutureBuilder(
            future: NewsAPI.getAll(),
            builder:
                (BuildContext context, AsyncSnapshot<List<News?>> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Text('No data'),
                );
              }
              List<News?> newss = snapshot.data!;
              return ListView.separated(
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(
                  color: Colors.black,
                ),
                itemCount: newss.length,
                itemBuilder: (BuildContext context, int i) {
                  News news = newss[i]!;
                  return Card(
                    child: Container(
                      margin: EdgeInsets.all(8),
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            news.title!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Text(news.description!),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
      ),
    );
  }
}
